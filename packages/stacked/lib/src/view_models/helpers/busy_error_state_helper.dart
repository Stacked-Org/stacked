import 'package:flutter/foundation.dart';

mixin BusyAndErrorStateHelper on ChangeNotifier {
  Map<int, bool> _busyStates = Map<int, bool>();

  /// Returns the busy status for an object if it exists. Returns false if not present
  bool busy(Object? object) => _busyStates[object.hashCode] ?? false;

  /// Returns the busy status of the ViewModel
  bool get isBusy => busy(this);

  // Returns true if any objects still have a busy status that is true.
  bool get anyObjectsBusy => _busyStates.values.any((busy) => busy);

  /// Sets the busy state for the object equal to the value passed in and notifies Listeners
  /// If you're using a primitive type the value SHOULD NOT BE CHANGED, since Hashcode uses == value
  void setBusyForObject(Object? object, bool value) {
    _busyStates[object.hashCode] = value;
    notifyListeners();
  }

  /// Marks the ViewModel as busy and calls notify listeners
  void setBusy(bool value) {
    setBusyForObject(this, value);
  }

  /// returns real data passed if neither the model is busy nor the object passed is busy
  T skeletonData<T>(
      {required T? realData, required T busyData, Object? busyKey}) {
    /// If busyKey is supplied we check busy(busyKey) to see if that property is busy
    /// If it is we return busyData, else realData
    bool isBusyKeySupplied = busyKey != null;
    if ((isBusyKeySupplied && busy(busyKey)) || realData == null)
      return busyData;
    else if (!isBusyKeySupplied && isBusy) return busyData;

    return realData;
  }

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

  void _setBusyForModelOrObject(bool value, {Object? busyObject}) {
    if (busyObject != null) {
      setBusyForObject(busyObject, value);
    } else {
      setBusyForObject(this, value);
    }
  }

  Map<int, dynamic> _errorStates = Map<int, dynamic>();
  dynamic error(Object object) => _errorStates[object.hashCode];

  /// Returns the error existence status of the ViewModel
  bool get hasError => error(this) != null;

  /// Returns the error status of the ViewModel
  dynamic get modelError => error(this);

  /// Clears all the errors
  void clearErrors() {
    _errorStates.clear();
  }

  /// Returns a boolean that indicates if the ViewModel has an error for the key
  bool hasErrorForKey(Object key) => error(key) != null;

  /// Sets the error for the ViewModel
  void setError(dynamic error) {
    setErrorForObject(this, error);
  }

  void setErrorForModelOrObject(dynamic value, {Object? key}) {
    if (key != null) {
      setErrorForObject(key, value);
    } else {
      setErrorForObject(this, value);
    }
  }

  /// Sets the error state for the object equal to the value passed in and notifies Listeners
  /// If you're using a primitive type the value SHOULD NOT BE CHANGED, since Hashcode uses == value
  void setErrorForObject(Object object, dynamic value) {
    _errorStates[object.hashCode] = value;
    notifyListeners();
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
}
