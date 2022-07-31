import 'package:stacked/stacked.dart';

import 'busy_state_helper.dart';
import 'error_state_helper.dart';

/// [FutureRunnerHelper] depends on [ErrorStateHelper] and [BusyStateHelper] to reflect the result of
/// the future into the view model, you have to add [ErrorStateHelper], [BusyStateHelper] mixins
/// before you can add the [FutureRunnerHelper] mixin.
mixin FutureRunnerHelper on BaseViewModel {
  /// Sets the ViewModel to busy, runs the future and then sets it to not busy when complete.
  ///
  /// rethrows [Exception] after setting busy to false for object or class
  Future<T> runBusyFuture<T>(Future<T> busyFuture,
      {Object? busyObject, bool throwException = false}) async {
    _setBusyForModelOrObject(true, busyObject: busyObject);
    try {
      var value = await runErrorFuture<T>(busyFuture,
          key: busyObject, throwException: throwException);
      return value;
    } catch (e) {
      if (throwException) rethrow;
      return Future.value();
    } finally {
      _setBusyForModelOrObject(false, busyObject: busyObject);
    }
  }

  Future<T> runErrorFuture<T>(Future<T> future,
      {Object? key, bool throwException = false}) async {
    try {
      setErrorForModelOrObject(null, key: key);
      return await future;
    } catch (e) {
      setErrorForModelOrObject(e, key: key);
      onFutureError(e, key);
      if (throwException) rethrow;
      return Future.value();
    }
  }

  /// Function that is called when a future throws an error
  void onFutureError(dynamic error, Object? key) {}

  void _setBusyForModelOrObject(bool value, {Object? busyObject}) {
    if (busyObject != null) {
      setBusyForObject(busyObject, value);
    } else {
      setBusyForObject(this, value);
    }
  }
}
