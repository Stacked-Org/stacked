import 'dart:async';

import 'package:stacked/src/state_management/helpers/data_state_helper.dart';

import 'base_view_models.dart';
import 'helpers/message_state_helper.dart';

/// Provides functionality for a ViewModel that's sole purpose it is to fetch data using a [Future]
/// This class is mixed with mixins:
/// - [MessageStateHelper]
/// - [FutureRunnerHelper]
/// - [DataStateHelper]
abstract class FutureViewModel<T> extends DynamicSourceViewModel<T>
    with MessageStateHelper, DataStateHelper
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
    setBusy(true);

    data = await runBusyFuture<T?>(futureToRun(), throwException: true)
        .catchError((error) {
      setError(error);
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

/// Provides functionality for a ViewModel that's sole purpose it is to fetch data using a [Stream]
/// This class is mixed with mixins:
/// - [MessageStateHelper]
/// - [DataStateHelper]
abstract class StreamViewModel<T> extends DynamicSourceViewModel<T>
    with MessageStateHelper, DataStateHelper
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
      onError: (error) {
        setError(error);
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
