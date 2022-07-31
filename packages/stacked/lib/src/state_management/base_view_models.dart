import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:stacked/src/state_management/reactive_service_mixin.dart';

import 'helpers/busy_state_helper.dart';
import 'helpers/error_state_helper.dart';
import 'helpers/future_runner_helper.dart';
import 'helpers/message_state_helper.dart';

mixin _InitialisableHelper {
  bool _initialised = false;
  bool get initialised => _initialised;

  /// Sets the initialised value for the ViewModel to true. This is called after
  /// the first initialise special ViewModel call
  void setInitialised(bool value) {
    _initialised = value;
  }
}
mixin _ModalReadyHelper {
  bool _onModelReadyCalled = false;
  bool get onModelReadyCalled => _onModelReadyCalled;

  /// Sets the onModelReadyCalled value to true. This is called after this first onModelReady call
  void setOnModelReadyCalled(bool value) {
    _onModelReadyCalled = value;
  }
}
mixin _DisposableHelper {
  bool _disposed = false;
  bool get disposed => _disposed;
}

/// Contains ViewModel functionality for busy state management
class BaseViewModel extends ChangeNotifier
    with _DisposableHelper, _ModalReadyHelper, _InitialisableHelper {
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

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// A [BaseViewModel] that provides functionality to subscribe to a reactive service.
abstract class ReactiveViewModel extends BaseViewModel {
  late List<ReactiveServiceMixin> _reactiveServices;

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

class _SingleDataSourceViewModel<T> extends DynamicSourceViewModel
    with ErrorStateHelper {
  T? _data;
  T? get data => _data;

  dynamic _error;

  @override
  dynamic error([Object? object]) => _error;
  @override
  void setError(error) {
    _error = error;
    super.setError(error);
  }

  bool get hasError => error(this) != null;
  bool get dataReady => _data != null && !hasError;
}

class _MultiDataSourceViewModel<K extends Object> extends DynamicSourceViewModel
    with ErrorStateHelper {
  Map<K, dynamic>? _dataMap;
  Map<K, dynamic>? get dataMap => _dataMap;

  bool dataReady(K key) => _dataMap![key] != null && (error(key) == null);
}

/// Provides functionality for a ViewModel that's sole purpose it is to fetch data using a [Future]
abstract class FutureViewModel<T> extends _SingleDataSourceViewModel<T>
    with MessageStateHelper, BusyStateHelper, FutureRunnerHelper
    implements Initialisable {
  /// The future that fetches the data and sets the view to busy
  @Deprecated('Use the futureToRun function')
  Future<T>? get future => null;

  // TODO: Add timeout functionality
  // TODO: Add retry functionality - default 1
  // TODO: Add retry lifecycle hooks to override in the viewmodel

  /// The future that fetches the data and sets the view to busy
  Future<T> futureToRun();

  /// Indicates if you want the error caught in futureToRun to be rethrown
  bool get rethrowException => false;

  Future initialise() async {
    setError(null);
    setMessage(null);
    _error = null;
    // We set busy manually as well because when notify listeners is called to clear error messages the
    // ui is rebuilt and if you expect busy to be true it's not.
    setBusy(true);
    notifyListeners();

    _data = await runBusyFuture<T?>(futureToRun(), throwException: true)
        .catchError((error) {
      setError(error);
      _error = error;
      setBusy(false);
      onError(error);
      notifyListeners();
      if (rethrowException) {
        throw error;
      }

      return null;
    });

    if (_data != null) {
      onData(_data);
    }

    changeSource = false;
  }

  /// Called when an error occurs within the future being run
  void onError(error) {}

  /// Called after the data has been set
  void onData(T? data) {}
}

/// Provides functionality for a ViewModel to run and fetch data using multiple future
abstract class MultipleFutureViewModel extends _MultiDataSourceViewModel
    with BusyStateHelper, FutureRunnerHelper
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

abstract class StreamViewModel<T> extends _SingleDataSourceViewModel<T>
    with MessageStateHelper
    implements DynamicSourceViewModel, Initialisable {
  /// Stream to listen to
  Stream<T> get stream;

  StreamSubscription? get streamSubscription => _streamSubscription;

  StreamSubscription? _streamSubscription;

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
        setError(null);
        setMessage(null);
        _error = null;
        notifyListeners();
        // Extra security in case transformData isnt sent
        var interceptedData = transformData(incomingData);

        if (interceptedData != null) {
          _data = interceptedData;
        } else {
          _data = incomingData;
        }

        onData(_data);
        notifyListeners();
      },
      onError: (error) {
        setError(error);
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
  void onData(T? data) {}

  /// Called when the stream is listened too
  void onSubscribed() {}

  /// Called when an error is fired in the stream
  void onError(error) {}

  void onCancel() {}

  /// Called before the data is set for the ViewModel
  T transformData(T data) {
    return data;
  }

  @override
  void dispose() {
    _streamSubscription!.cancel();
    onCancel();

    super.dispose();
  }
}

class StreamData<T> extends _SingleDataSourceViewModel<T>
    with MessageStateHelper {
  Stream<T> stream;

  /// Called when the new data arrives
  ///
  /// notifyListeners is called before this so no need to call in here unless you're
  /// running additional logic and setting a separate value.
  Function? onData;

  /// Called after the stream has been listened too
  Function? onSubscribed;

  /// Called when an error is placed on the stream
  Function? onError;

  /// Called when the stream is cancelled
  Function? onCancel;

  /// Allows you to modify the data before it's set as the new data for the ViewModel
  ///
  /// This can be used to modify the data if required. If nothhing is returned the data
  /// won't be set.
  Function? transformData;
  StreamData(
    this.stream, {
    this.onData,
    this.onSubscribed,
    this.onError,
    this.onCancel,
    this.transformData,
  });
  late StreamSubscription _streamSubscription;

  void initialise() {
    _streamSubscription = stream.listen(
      (incomingData) {
        setError(null);
        setMessage(null);
        _error = null;
        notifyListeners();
        // Extra security in case transformData isnt sent
        var interceptedData =
            transformData == null ? incomingData : transformData!(incomingData);

        if (interceptedData != null) {
          _data = interceptedData;
        } else {
          _data = incomingData;
        }

        notifyListeners();
        onData!(_data);
      },
      onError: (error) {
        setError(error);
        _data = null;
        onError!(error);
        notifyListeners();
      },
    );

    onSubscribed!();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    onCancel!();

    super.dispose();
  }
}

/// Interface: Additional actions that should be implemented by spcialised ViewModels
abstract class Initialisable {
  void initialise();
}
