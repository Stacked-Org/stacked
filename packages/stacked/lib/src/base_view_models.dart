import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:stacked/src/reactive_service_mixin.dart';

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
  /// If you're using a primitive type the value SHOULD NOT BE CHANGED, since Hashcode uses == value
  void setBusyForObject(Object object, bool value) {
    _busyStates[object.hashCode] = value;
    notifyListeners();
  }

  /// Sets the ViewModel to busy, runs the future and then sets it to not busy when complete.
  ///
  /// If a busyKey is su
  Future runBusyFuture(Future busyFuture, {Object busyObject}) async {
    _setBusyForModelOrObject(true, busyObject: busyObject);
    var value = await busyFuture.catchError((error) {
      // TODO: Should probably store the error here and indicate we have an error
      throw error;
    });
    _setBusyForModelOrObject(false, busyObject: busyObject);
    return value;
  }

  void _setBusyForModelOrObject(bool value, {Object busyObject}) {
    if (busyObject != null) {
      setBusyForObject(busyObject.hashCode, value);
    } else {
      setBusyForObject(this, value);
    }
  }

  // Sets up streamData property to hold data, busy, and lifecycle events
  @protected
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

@protected
class DynamicSourceViewModel<T> extends ReactiveViewModel {
  bool changeSource = false;
  void notifySourceChanged({bool clearOldData = false}) {
    changeSource = true;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}

class _SingleDataSourceViewModel<T> extends DynamicSourceViewModel {
  T _data;
  T get data => _data;

  bool _hasError;
  bool get hasError => _hasError;

  dynamic _error;
  dynamic get error => _error;

  bool get dataReady => _data != null && !_hasError;
}

class _MultiDataSourceViewModel extends DynamicSourceViewModel {
  Map<String, dynamic> _dataMap;
  Map<String, dynamic> get dataMap => _dataMap;

  Map<String, bool> _errorMap;

  Map<String, dynamic> _errors;
  dynamic getError(String key) => _errors[key];

  bool hasError(String key) => _errorMap[key] ?? false;
  bool dataReady(String key) =>
      _dataMap[key] != null && (_errorMap[key] == null);
}

/// Provides functionality for a ViewModel that's sole purpose it is to fetch data using a [Future]
abstract class FutureViewModel<T> extends _SingleDataSourceViewModel<T> {
  /// The future that fetches the data and sets the view to busy
  @Deprecated('Use the futureToRun function')
  Future<T> get future => null;

  // TODO: Add timeout functionality
  // TODO: Add retry functionality - default 1
  // TODO: Add retry lifecycle hooks to override in the viewmodel

  Future<T> futureToRun();

  Future runFuture() async {
    _hasError = false;
    _error = null;
    // We set busy manually as well because when notify listeners is called to clear error messages the
    // ui is rebuilt and if you expect busy to be true it's not.
    setBusy(true);
    notifyListeners();

    _data = await runBusyFuture(futureToRun()).catchError((error) {
      _hasError = true;
      _error = error;
      setBusy(false);
      onError(error);
      notifyListeners();
    });

    if (_data != null) {
      onData(_data);
    }

    changeSource = false;
  }

  /// Called when an error occurs within the future being run
  void onError(error) {}

  /// Called after the data has been set
  void onData(T data) {}
}

/// Provides functionality for a ViewModel to run and fetch data using multiple future
abstract class MultipleFutureViewModel extends _MultiDataSourceViewModel {
  Map<String, Future Function()> get futuresMap;

  Completer _futuresCompleter;
  int _futuresCompleted;

  void _initialiseData() {
    if (_errorMap == null) {
      _errorMap = Map<String, bool>();
    }
    if (_dataMap == null) {
      _dataMap = Map<String, dynamic>();
    }
    if (_errors == null) {
      _errors = Map<String, dynamic>();
    }

    _futuresCompleted = 0;
  }

  Future runFutures() {
    _futuresCompleter = Completer();
    _initialiseData();
    // We set busy manually as well because when notify listeners is called to clear error messages the
    // ui is rebuilt and if you expect busy to be true it's not.
    setBusy(true);
    notifyListeners();

    for (var key in futuresMap.keys) {
      runBusyFuture(futuresMap[key](), busyObject: key).then((futureData) {
        _dataMap[key] = futureData;
        notifyListeners();
        onData(key);
        _incrementAndCheckFuturesCompleted();
      }).catchError((error) {
        _errorMap[key] = true;
        _errors[key] = error;
        setBusyForObject(key, false);
        onError(key: key, error: error);
        notifyListeners();
        _incrementAndCheckFuturesCompleted();
      });
    }

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

  void onError({String key, error}) {}

  void onData(String key) {}
}

/// Provides functionality for a ViewModel to run and fetch data using multiple streams
abstract class MultipleStreamViewModel extends _MultiDataSourceViewModel {
  // Every MultipleStreamViewModel must override streamDataMap
  // StreamData requires a stream, but lifecycle events are optional
  // if a lifecyle event isn't defined we use the default ones here
  Map<String, StreamData> get streamsMap;

  Map<String, StreamSubscription> _streamsSubscriptions;

  @visibleForTesting
  Map<String, StreamSubscription> get streamsSubscriptions =>
      _streamsSubscriptions;

  /// Returns the stream subscription associated with the key
  StreamSubscription getSubscriptionForKey(String key) =>
      _streamsSubscriptions[key];

  void initialise() {
    _dataMap = Map<String, dynamic>();
    _errorMap = Map<String, bool>();
    _errors = Map<String, dynamic>();
    _streamsSubscriptions = Map<String, StreamSubscription>();

    if (!changeSource) {
      notifyListeners();
    }

    for (var key in streamsMap.keys) {
      // If a lifecycle function isn't supplied, we fallback to default
      _streamsSubscriptions[key] = streamsMap[key].stream.listen(
        (incomingData) {
          _errorMap.remove(key);
          _errors.remove(key);
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
          _errors[key] = error;
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
      changeSource = false;
    }
  }

  @override
  void notifySourceChanged({bool clearOldData = false}) {
    changeSource = true;
    _disposeAllSubscriptions();

    if (clearOldData) {
      dataMap.clear();
      _errorMap.clear();
      _errors.clear();
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
      for (var key in _streamsSubscriptions.keys) {
        _streamsSubscriptions[key].cancel();
      }

      _streamsSubscriptions.clear();
    }
  }
}

abstract class StreamViewModel<T> extends _SingleDataSourceViewModel<T>
    implements DynamicSourceViewModel {
  /// Stream to listen to
  Stream<T> get stream;

  StreamSubscription get streamSubscription => _streamSubscription;

  StreamSubscription _streamSubscription;

  @override
  void notifySourceChanged({bool clearOldData = false}) {
    changeSource = true;
    _streamSubscription?.cancel();
    _streamSubscription = null;

    if (clearOldData) {
      _data = null;
    }

    notifyListeners();
  }

  void initialise() {
    _streamSubscription = stream.listen(
      (incomingData) {
        _hasError = false;
        _error = null;
        notifyListeners();
        // Extra security in case transformData isnt sent
        var interceptedData =
            transformData == null ? incomingData : transformData(incomingData);

        if (interceptedData != null) {
          _data = interceptedData;
        } else {
          _data = incomingData;
        }

        onData(_data);
        notifyListeners();
      },
      onError: (error) {
        _hasError = true;
        _error = error;
        _data = null;
        onError(error);
        notifyListeners();
      },
    );

    onSubscribed();
    changeSource = false;
  }

  /// Called before the notifyListeners is called when data has been set
  void onData(T data) {}

  /// Called when the stream is listened too
  void onSubscribed() {}

  /// Called when an error is fired in the stream
  void onError(error) {}

  void onCancel() {}

  /// Called before the data is set for the viewmodel
  T transformData(T data) {
    return data;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    onCancel();

    super.dispose();
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
        _error = null;
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
