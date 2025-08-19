import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:stacked/src/router/controller/routing_controller.dart';
// ignore: avoid_web_libraries_in_flutter
import 'package:web/web.dart';

import 'navigation_history_base.dart';

class NavigationHistoryImpl extends NavigationHistory {
  NavigationHistoryImpl(this.router);

  @override
  final StackRouter router;

  final _history = window.history;

  @override
  void back() {
    _history.back();
  }

  int get _currentIndex {
    final state = _history.state;
    if (state != null) {
      try {
        final stateObj = state as JSObject;
        final serialCount = stateObj.getProperty('serialCount'.toJS);
        if (serialCount != null && serialCount.typeofEquals('number')) {
          return (serialCount as JSNumber).toDartInt;
        }
      } catch (e) {
        return 0;
      }
    }
    return 0;
  }

  @override
  bool get canNavigateBack => _currentIndex > 0;

  @override
  void forward() => _history.forward();

  @override
  int get length => _history.length;
}
