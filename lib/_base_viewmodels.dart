import 'dart:async';

import 'package:flutter/cupertino.dart';

import '_reactive_service_mixin.dart';

/// Contains ViewModel functionality for busy state management
class BaseViewModel extends ChangeNotifier {
  Map<int, bool> _busyStates = Map<int, bool>();

  /// Returns the busy status for an object if it exists. Returns false if not present
  bool busy(Object object) => _busyStates[object.hashCode] ?? false;

  /// Returns the busy status of the viewmodel
  bool get isBusy => busy(this);

  /// Marks the viewmodel as busy and calls notify listeners
  void setBusy(bool value) {
    setBusyForObject(this, value);
  }

  /// Sets the busy state for the object equal to the value passed in and notifies Listeners
  void setBusyForObject(Object object, bool value) {
    _busyStates[object.hashCode] = value;
    notifyListeners();
  }

  /// Sets the ViewModel to busy, runs the future and then sets it to not busy when complete.
  ///
  /// If a busyKey is su
  Future runBusyFuture(Future busyFuture, {Object busyObject}) async {
    _setBusyForModelOrObject(true, busyObject: busyObject);
    var value = await busyFuture;
    _setBusyForModelOrObject(false, busyObject: busyObject);
    return value;
  }

  void _setBusyForModelOrObject(bool value, {Object busyObject}) {
    if (busyObject != null) {
      setBusyForObject(busyObject, value);
    } else {
      setBusyForObject(this, value);
    }
  }

  // Sets up streamData property to hold data, busy, and lifecycle events
  StreamData setupStream<T>(
    Stream<T> stream, {
    onData,
    onSubscribed,
    onError,
    onCancel,
    transformData,
  }) {
    StreamData<T> streamData = StreamData<T>(
      stream,
      onData: onData,
      onSubscribed: onSubscribed,
      onError: onError,
      onCancel: onCancel,
      transformData: transformData,
    );
    streamData.initialise();

    return streamData;
  }
}

/// A [BaseViewModel] that provides functionality to subscribe to a reactive service.
abstract class ReactiveViewModel extends BaseViewModel {
  List<ReactiveServiceMixin> _reactiveServices;

  List<ReactiveServiceMixin> get reactiveServices;

  ReactiveViewModel() {
    _reactToServices(reactiveServices);
  }

  void _reactToServices(List<ReactiveServiceMixin> reactiveServices) {
    _reactiveServices = reactiveServices;
    for (var reactiveService in _reactiveServices) {
      reactiveService.addListener(_indicateChange);
    }
  }

  @override
  void dispose() {
    for (var reactiveService in _reactiveServices) {
      reactiveService.removeListener(_indicateChange);
    }
    super.dispose();
  }

  void _indicateChange() {
    notifyListeners();
  }
}

class _SingleDataSourceViewModel<T> extends BaseViewModel {
  T _data;
  T get data => _data;

  bool _hasError;
  bool get hasError => _hasError;

  bool get dataReady => _data != null && !_hasError;
}

class _MultiDataSourceViewModel extends BaseViewModel {
  Map<String, dynamic> _dataMap;
  Map<String, dynamic> get dataMap => _dataMap;

  Map<String, bool> _errorMap;

  bool hasError(String key) => _errorMap[key] ?? false;
  bool dataReady(String key) =>
      _dataMap[key] != null && (_errorMap[key] == null);
}

/// Provides functionality for a ViewModel that's sole purpose it is to fetch data using a [Future]
abstract class FutureViewModel<T> extends _SingleDataSourceViewModel {
  /// The future that fetches the data and sets the view to busy
  @Deprecated('Use the futureToRun function')
  Future<T> get future => null;

  // TODO: Add timeout functionality
  // TODO: Add retry functionality - default 1
  // TODO: Add retry lifecycle hooks to override in the viewmodel

  Future<T> futureToRun();

  Future runFuture() async {
    _hasError = false;
    notifyListeners();

    _data = await runBusyFuture(futureToRun()).catchError((error) {
      _hasError = true;
      setBusy(false);
      onError(error);
      notifyListeners();
    });
  }

  void onError(error) {}
}

/// Provides functionality for a ViewModel to run and fetch data using multiple future
abstract class MultipleFutureViewModel extends _MultiDataSourceViewModel {
  Map<String, Future Function()> get futuresMap;

  Completer _futuresCompleter;
  int _futuresCompleted;

  void _initialiseData() {
    _errorMap = Map<String, bool>();
    _dataMap = Map<String, dynamic>();
    _futuresCompleted = 0;
  }

  Future runFutures() {
    _futuresCompleter = Completer();
    _initialiseData();
    notifyListeners();

    for (var key in futuresMap.keys) {
      runBusyFuture(futuresMap[key](), busyObject: key).then((futureData) {
        _dataMap[key] = futureData;
        notifyListeners();
        onData(key);
        _incrementAndCheckFuturesCompleted();
      }).catchError((error) {
        _errorMap[key] = true;
        setBusyForObject(key, false);
        onError(key: key, error: error);
        notifyListeners();
        _incrementAndCheckFuturesCompleted();
      });
    }

    return _futuresCompleter.future;
  }

  void _incrementAndCheckFuturesCompleted() {
    _futuresCompleted++;
    if (_futuresCompleted == futuresMap.length &&
        !_futuresCompleter.isCompleted) {
      _futuresCompleter.complete();
    }
  }

  void onError({String key, error}) {}

  void onData(String key) {}
}

class LifecycleEvents {
  Function onData;
  Function onSubscribed;
  Function onError;
  Function onCancel;
  Function transformData;

  LifecycleEvents({
    this.onData,
    this.onSubscribed,
    this.onError,
    this.onCancel,
    this.transformData,
  });
}

/// Provides functionality for a ViewModel to run and fetch data using multiple streams

abstract class MultipleStreamViewModel extends _MultiDataSourceViewModel {
  // Every MultipleStreamViewModel must override streamDataMap
  // StreamData requires a stream, but lifecycle events are optional
  // if a lifecyle event isn't defined we use the default ones here
  Map<String, StreamData> get streamsMap;

  Map<String, StreamSubscription> _streamsSubscriptions;

  void initialise() {
    _dataMap = Map<String, dynamic>();
    _errorMap = Map<String, bool>();
    _streamsSubscriptions = Map<String, StreamSubscription>();

    notifyListeners();
    for (var key in streamsMap.keys) {
      // If a lifecycle function isn't supplied, we fallback to default
      _streamsSubscriptions[key] = streamsMap[key].stream.listen(
        (incomingData) {
          _errorMap.remove(key);
          notifyListeners();
          // Extra security in case transformData isnt sent
          var interceptedData = streamsMap[key].transformData == null
              ? transformData(key, incomingData)
              : streamsMap[key].transformData(incomingData);

          if (interceptedData != null) {
            _dataMap[key] = interceptedData;
          } else {
            _dataMap[key] = incomingData;
          }

          notifyListeners();
          streamsMap[key].onData != null
              ? streamsMap[key].onData(_dataMap[key])
              : onData(key, _dataMap[key]);
        },
        onError: (error) {
          _errorMap[key] = true;
          _dataMap[key] = null;

          streamsMap[key].onError != null
              ? streamsMap[key].onError(error)
              : onError(key, error);
          notifyListeners();
        },
      );
      streamsMap[key].onSubscribed != null
          ? streamsMap[key].onSubscribed()
          : onSubscribed(key);
      notifyListeners();
    }
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
    if (_streamsSubscriptions != null) {
      for (var key in _streamsSubscriptions.keys) {
        _streamsSubscriptions[key].cancel();
      }
    }

    super.dispose();
  }
}

abstract class StreamViewModel<T> extends _SingleDataSourceViewModel<T> {
  Stream<T> get stream;
  // Holds the data, dataReady, hasError, isBusy properties
  StreamData streamData;
  T get data => streamData.data;
  get dataReady => streamData.dataReady;
  get hasError => streamData.hasError;
  get isBusy => streamData.isBusy;

  void initialise() {
    streamData = setupStream(
      stream,
      onData: onData,
      onSubscribed: onSubscribed,
      onError: onError,
      onCancel: onCancel,
      transformData: transformData,
    );
  }

  void onData(T data) {}
  void onSubscribed() {}
  void onError(error) {}
  void onCancel() {}
  T transformData(T data) {
    return data;
  }
}

class StreamData<T> extends _SingleDataSourceViewModel<T> {
  Stream<T> stream;

  /// Called when the new data arrives
  ///
  /// notifyListeners is called before this so no need to call in here unless you're
  /// running additional logic and setting a separate value.
  Function onData;

  /// Called after the stream has been listened too
  Function onSubscribed;

  /// Called when an error is placed on the stream
  Function onError;

  /// Called when the stream is cancelled
  Function onCancel;

  /// Allows you to modify the data before it's set as the new data for the model
  ///
  /// This can be used to modify the data if required. If nothhing is returned the data
  /// won't be set.
  Function transformData;
  StreamData(
    this.stream, {
    this.onData,
    this.onSubscribed,
    this.onError,
    this.onCancel,
    this.transformData,
  });
  StreamSubscription _streamSubscription;

  void initialise() {
    _streamSubscription = stream.listen(
      (incomingData) {
        _hasError = false;
        notifyListeners();
        // Extra security in case transformData isnt sent
        var interceptedData =
            transformData == null ? incomingData : transformData(incomingData);

        if (interceptedData != null) {
          _data = interceptedData;
        } else {
          _data = incomingData;
        }

        notifyListeners();
        onData(_data);
      },
      onError: (error) {
        _hasError = true;
        _data = null;
        onError(error);
        notifyListeners();
      },
    );

    onSubscribed();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    onCancel();

    super.dispose();
  }
}
