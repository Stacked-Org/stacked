import 'dart:async';

import 'base_view_models.dart';
import 'helpers/future_runner_helper.dart';
import 'helpers/message_state_helper.dart';

/// Provides functionality for a ViewModel that's sole purpose it is to fetch data using a [Future]
abstract class FutureViewModel<T> extends SingleDataSourceViewModel<T>
    with MessageStateHelper, FutureRunnerHelper
    implements Initialisable {
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

    data = await runBusyFuture<T?>(futureToRun(), throwException: true)
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

    if (data != null) {
      onData(data);
    }

    changeSource = false;
  }

  /// Called when an error occurs within the future being run
  void onError(error) {}

  /// Called after the data has been set
  void onData(T? data) {}
}

abstract class StreamViewModel<T> extends SingleDataSourceViewModel<T>
    with MessageStateHelper
    implements DynamicSourceViewModel<T>, Initialisable {
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
      data = null;
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
          data = interceptedData;
        } else {
          data = incomingData;
        }

        onData(data);
        notifyListeners();
      },
      onError: (error) {
        setError(error);
        _error = error;
        data = null;
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
