import 'package:observable_ish/observable_ish.dart';

/// Adds functionality to easily listen to all reactive values in a service
mixin ReactiveServiceMixin {
  List<Function> _listeners = List<Function>();

  void listenToReactiveValues(List<RxValue> reactiveValues) {
    for (var reactiveValue in reactiveValues) {
      reactiveValue.values.listen((value) {
        for (var listener in _listeners) {
          listener();
        }
      });
    }
  }

  void addListener(void Function() listener) {
    _listeners.add(listener);
  }

  void removeListeners(void Function() listener) {
    _listeners.remove(listener);
  }
}
