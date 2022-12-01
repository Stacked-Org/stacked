import 'package:flutter/foundation.dart';

mixin MessageStateHelper on ChangeNotifier {
  Map<int, String?> _messageStates = Map<int, String?>();

  /// Returns the message for an object if it exists. Returns null if not present
  String? message(Object object) => _messageStates[object.hashCode];

  /// Returns the message status of the ViewModel
  bool get hasMessage => message(this) != null;

  /// Returns the message status of the ViewModel
  String? get modelMessage => message(this);

  /// Returns a boolean that indicates if the ViewModel has an message for the key
  bool hasMessageForKey(Object key) => message(key) != null;

  void clearMessages() {
    _messageStates.clear();
  }

  /// Sets the message for the ViewModel
  void setMessage(String? message) {
    setMessageForObject(this, message);
  }

  /// Sets the message for the object equal to the value passed in and notifies Listeners
  /// If you're using a primitive type the value SHOULD NOT BE CHANGED, since Hashcode uses == value
  void setMessageForObject(Object object, String? value) {
    _messageStates[object.hashCode] = value;
    notifyListeners();
  }
}
