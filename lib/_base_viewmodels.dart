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
  StreamData setupStream(Stream stream) {
    StreamData streamData = StreamData(stream);
    streamData.initialise();
    notifyListeners();
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
  bool dataReady(String key) => _dataMap[key] != null && _errorMap[key] == null;
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

/// Provides functionality for a ViewModel to run and fetch data using multiple streams

abstract class MultipleStreamViewModel extends _MultiDataSourceViewModel {
  Map<String, Stream> get streamsMap;
  Map<String, StreamData> _streamDataMap;
  Map<String, StreamData> get streamDataMap => _streamDataMap;

  void _initialiseData() {
    _streamDataMap = Map<String, StreamData>();
  }

  void runStreams() {
    _initialiseData();
    notifyListeners();
    for (var key in streamsMap.keys) {
      _streamDataMap[key] = setupStream(streamsMap[key]);
      notifyListeners();
    }
  }
}

abstract class StreamViewModel<T> extends _SingleDataSourceViewModel<T> {
  Stream<T> get stream;
  // Holds the data, dataReady, hasError, isBusy properties
  StreamData streamData;
  get data => streamData.data;
  get dataReady => streamData.dataReady;
  get hasError => streamData.hasError;
  get isBusy => streamData.isBusy;

  //TODO: Integrate read/write for onData, onCancel, onSubscribed, onError and transformData properties
  //TODO: Figure out a more elegant way of integrating StreamData
  //TODO: Get this to work with generic stream types again
  //TODO: Possibly have a default setbusy for overwrittenn lifecycle events

  Future initialise() async {
    streamData = setupStream(stream);
  }
}

class StreamData<T> extends _SingleDataSourceViewModel<T> {
  Stream<T> stream;
  StreamData(this.stream);
  StreamSubscription _streamSubscription;

  void initialise() {
    _streamSubscription = stream.listen(
      (incomingData) {
        _hasError = false;
        notifyListeners();

        var interceptedData = transformData(incomingData);

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

  /// Called when the new data arrives
  ///
  /// notifyListeners is called before this so no need to call in here unless you're
  /// running additional logic and setting a separate value.
  void onData(T data) {
    setBusy(false);
  }

  /// Called after the stream has been listened too
  void onSubscribed() {
    setBusy(true);
  }

  /// Called when an error is placed on the stream
  void onError(error) {
    setBusy(false);
  }

  /// Called when the stream is cancelled
  void onCancel() {
    setBusy(false);
  }

  /// Allows you to modify the data before it's set as the new data for the model
  ///
  /// This can be used to modify the data if required. If nothhing is returned the data
  /// won't be set.
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
