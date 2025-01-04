import 'dart:async';

import 'package:stacked/src/view_models/helpers/data_state_helper.dart';

import '../base_view_models.dart';
import '../helpers/message_state_helper.dart';

/// Provides functionality for a ViewModel that's sole purpose it is to fetch data using a [Future]
/// This class is mixed with mixins:
/// - [MessageStateHelper]
/// - [DataStateHelper]
abstract class FutureViewModel<T> extends DynamicSourceViewModel<T>
    with MessageStateHelper, DataStateHelper<T>
    implements Initialisable {
  // TODO: Add timeout functionality
  // TODO: Add retry functionality - default 1
  // TODO: Add retry lifecycle hooks to override in the viewmodel

  /// The future that fetches the data and sets the view to busy
  Future<T> futureToRun();

  /// Indicates if you want the error caught in futureToRun to be rethrown
  bool get rethrowException => false;

  @override
  Future initialise() async {
    setError(null);
    setMessage(null);
    setBusy(true);

    try {
      data = await runBusyFuture<T?>(futureToRun(), throwException: true);
    } catch (exception, stackTrace) {
      setError(exception);
      setBusy(false);
      onError(exception, stackTrace);

      notifyListeners();
      if (rethrowException) {
        throw error;
      }

      return null;
    }

    if (data != null) {
      onData(data);
    }

    changeSource = false;
  }

  /// Called when an error occurs within the future being run
  void onError(dynamic error, StackTrace? stackTrace) {}

  /// Called after the data has been set
  void onData(T? data) {}
}

/// Provides functionality for a ViewModel that's sole purpose it is to fetch data using a [Stream]
/// This class is mixed with mixins:
/// - [MessageStateHelper]
/// - [DataStateHelper]
abstract class StreamViewModel<T> extends DynamicSourceViewModel<T>
    with MessageStateHelper, DataStateHelper<T>
    implements Initialisable {
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

  @override
  void initialise() {
    _streamSubscription = stream.listen(
      (incomingData) {
        setError(null);
        setMessage(null);
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
      onError: (dynamic error, StackTrace? stackTrace) {
        setError(error);
        data = null;
        onError(error, stackTrace);
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
  void onError(Object error, StackTrace? stackTrace) {}

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
