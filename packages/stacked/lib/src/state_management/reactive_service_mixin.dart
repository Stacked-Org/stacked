import 'package:flutter/foundation.dart';

import '../../stacked.dart';

/// Adds functionality to easily listen to all reactive values in a service
mixin ReactiveServiceMixin {
  List<Function> _listeners = List<Function>.empty(growable: true);

  /// List to the values and react when there are any changes
  void listenToReactiveValues(List<dynamic> reactiveValues) {
    for (var reactiveValue in reactiveValues) {
      if (reactiveValue is ReactiveValue) {
        reactiveValue.values.listen((value) => notifyListeners());
      } else if (reactiveValue is ReactiveList) {
        reactiveValue.onChange.listen((event) => notifyListeners());
      } else if (reactiveValue is ChangeNotifier) {
        reactiveValue.addListener(notifyListeners);
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
