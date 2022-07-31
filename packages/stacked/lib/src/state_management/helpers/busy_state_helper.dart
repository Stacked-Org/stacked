import 'package:flutter/foundation.dart';

mixin BusyStateHelper on ChangeNotifier {
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
}
