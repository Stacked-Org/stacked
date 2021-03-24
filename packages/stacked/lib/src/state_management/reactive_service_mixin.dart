import 'package:flutter/cupertino.dart';

/// Adds functionality to easily listen to all reactive values in a service
mixin ReactiveServiceMixin {
  List<Function> _listeners = List<Function>();

  /// List to the values and react when there are any changes
  void listenToReactiveValues(
      @Deprecated('Prefer to use the notifyListeners call in the service when you want your ViewModel to rebuild. Observable_Ish has been removed')
          List<dynamic> reactiveValues) {
    for (var reactiveValue in reactiveValues) {
      if (reactiveValue is ChangeNotifier) {
        reactiveValue.notifyListeners();
      }
    }
  }

  /// Registers a listener with this service
  void addListener(void Function() listener) {
    _listeners.add(listener);
  }

  /// Removes a listener from the service
  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  /// Notifies all the listeners attached to this service
  @protected
  @visibleForTesting
  void notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}
