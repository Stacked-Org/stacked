import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

/// Adds functionality to easily listen to all reactive values in a service
mixin ListenableServiceMixin {
  List<Function> _listeners = List<Function>.empty(growable: true);

  int get listenersCount => _listeners.length;

  /// List to the values and react when there are any changes
  void listenToReactiveValues(List<dynamic> reactiveValues) {
    for (var reactiveValue in reactiveValues) {
      switch (reactiveValue.runtimeType) {
        case ReactiveValue:
          reactiveValue.values.listen((value) => notifyListeners());
          break;
        case ReactiveList:
          reactiveValue.onChange.listen((event) => notifyListeners());
          break;
        case ChangeNotifier:
          reactiveValue.addListener(notifyListeners);
          break;
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
