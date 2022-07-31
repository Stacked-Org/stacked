import 'package:flutter/foundation.dart';

mixin ErrorStateHelper on ChangeNotifier {
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
}
