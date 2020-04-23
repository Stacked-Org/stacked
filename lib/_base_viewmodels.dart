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
  Future runBusyFuture(Future busyFuture, {Object busyHascode}) async {
    setBusyForObject(this, true);
    var value = await busyFuture;
    setBusyForObject(this, false);
    return value;
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

abstract class StreamViewModel<T> extends BaseViewModel {
  T _data;
  T get data => _data;

  Stream<T> get stream;

  StreamSubscription _streamSubscription;

  StreamViewModel() {
    _streamSubscription = stream.listen(
      (incomingData) {
        var interceptedData = transformData(incomingData);

        if (interceptedData != null) {
          _data = interceptedData;
        } else {
          _data = incomingData;
        }

        notifyListeners();
        onData(_data);
      },
      onError: (error) => onError(error),
    );

    onSubscribed();
  }

  /// Called when the new data arrives
  ///
  /// notifyListeners is called before this so no need to call in here unless you're
  /// running additional logic and setting a separate value.
  void onData(T data) {}

  /// Called after the stream has been listened too
  void onSubscribed() {}

  /// Called when an error is placed on the stream
  void onError(error) {}

  /// Called when the stream is cancelled
  void onCancel() {}

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
