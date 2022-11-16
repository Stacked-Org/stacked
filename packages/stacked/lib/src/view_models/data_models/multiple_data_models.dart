import 'dart:async';

import 'package:flutter/foundation.dart';

import '../base_view_models.dart';

class _MultiDataSourceViewModel<K extends Object>
    extends DynamicSourceViewModel {
  Map<K, dynamic>? _dataMap;
  Map<K, dynamic>? get dataMap => _dataMap;

  bool dataReady(K key) => _dataMap![key] != null && (error(key) == null);
}

/// Provides functionality for a ViewModel to run and fetch data using multiple future
abstract class MultipleFutureViewModel extends _MultiDataSourceViewModel
    implements Initialisable {
  Map<String, Future Function()> get futuresMap;

  late Completer _futuresCompleter;
  late int _futuresCompleted;

  void _initialiseData() {
    if (_dataMap == null) {
      _dataMap = Map<String, dynamic>();
    }

    _futuresCompleted = 0;
  }

  Future initialise() {
    _futuresCompleter = Completer();
    _initialiseData();
    // We set busy manually as well because when notify listeners is called to clear error messages the
    // ui is rebuilt and if you expect busy to be true it's not.
    setBusy(true);
    notifyListeners();

    for (var key in futuresMap.keys) {
      runBusyFuture(futuresMap[key]!(), busyObject: key, throwException: true)
          .then((futureData) {
        _dataMap![key] = futureData;
        setBusyForObject(key, false);
        notifyListeners();
        onData(key);
        _incrementAndCheckFuturesCompleted();
      }).catchError((error) {
        setErrorForObject(key, error);
        setBusyForObject(key, false);
        onError(key: key, error: error);
        notifyListeners();
        _incrementAndCheckFuturesCompleted();
      });
    }
    setBusy(false);
    changeSource = false;

    return _futuresCompleter.future;
  }

  void _incrementAndCheckFuturesCompleted() {
    _futuresCompleted++;
    if (_futuresCompleted == futuresMap.length &&
        !_futuresCompleter.isCompleted) {
      _futuresCompleter.complete();
    }
  }

  void onError({String? key, error}) {}

  void onData(String key) {}
}

/// Provides functionality for a ViewModel to run and fetch data using multiple streams
abstract class MultipleStreamViewModel extends _MultiDataSourceViewModel
    implements Initialisable {
  // Every MultipleStreamViewModel must override streamDataMap
  // StreamData requires a stream, but lifecycle events are optional
  // if a lifecyle event isn't defined we use the default ones here
  Map<String, StreamData> get streamsMap;

  Map<String, StreamSubscription>? _streamsSubscriptions;

  @visibleForTesting
  Map<String, StreamSubscription>? get streamsSubscriptions =>
      _streamsSubscriptions;

  /// Returns the stream subscription associated with the key
  StreamSubscription? getSubscriptionForKey(String key) =>
      _streamsSubscriptions![key];

  void initialise() {
    _dataMap = Map<String, dynamic>();
    clearErrors();
    _streamsSubscriptions = Map<String, StreamSubscription>();

    if (!changeSource) {
      notifyListeners();
    }
    final _streamsMapValues = Map<String, StreamData>.from(streamsMap);

    for (final key in _streamsMapValues.keys) {
      // If a lifecycle function isn't supplied, we fallback to default
      _streamsSubscriptions![key] = _streamsMapValues[key]!.stream.listen(
        (incomingData) {
          setErrorForObject(key, null);
          notifyListeners();
          // Extra security in case transformData isnt sent
          var interceptedData = _streamsMapValues[key]!.transformData == null
              ? transformData(key, incomingData)
              : _streamsMapValues[key]!.transformData!(incomingData);

          if (interceptedData != null) {
            _dataMap![key] = interceptedData;
          } else {
            _dataMap![key] = incomingData;
          }

          notifyListeners();
          _streamsMapValues[key]!.onData != null
              ? _streamsMapValues[key]!.onData!(_dataMap![key])
              : onData(key, _dataMap![key]);
        },
        onError: (error) {
          setErrorForObject(key, error);
          _dataMap![key] = null;

          _streamsMapValues[key]!.onError != null
              ? _streamsMapValues[key]!.onError!(error)
              : onError(key, error);
          notifyListeners();
        },
      );
      _streamsMapValues[key]!.onSubscribed != null
          ? _streamsMapValues[key]!.onSubscribed!()
          : onSubscribed(key);
      changeSource = false;
    }
  }

  @override
  void notifySourceChanged({bool clearOldData = false}) {
    changeSource = true;
    _disposeAllSubscriptions();

    if (clearOldData) {
      dataMap!.clear();
      clearErrors();
    }

    notifyListeners();
  }

  void onData(String key, dynamic data) {}
  void onSubscribed(String key) {}
  void onError(String key, error) {}
  void onCancel(String key) {}
  dynamic transformData(String key, data) {
    return data;
  }

  @override
  @mustCallSuper
  void dispose() {
    _disposeAllSubscriptions();
    super.dispose();
  }

  void _disposeAllSubscriptions() {
    if (_streamsSubscriptions != null) {
      for (var key in _streamsSubscriptions!.keys) {
        _streamsSubscriptions![key]!.cancel();
        onCancel(key);
      }

      _streamsSubscriptions!.clear();
    }
  }
}
