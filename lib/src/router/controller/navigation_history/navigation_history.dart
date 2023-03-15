import 'package:stacked/src/router/controller/routing_controller.dart';

import 'navigation_history_base.dart';

class NavigationHistoryImpl extends NavigationHistory {
  NavigationHistoryImpl(StackRouter router);
  @override
  void back() {
    throw Exception("Stub implementation");
  }

  @override
  bool get canNavigateBack => throw Exception("Stub implementation");

  @override
  void forward() {
    throw Exception("Stub implementation");
  }

  @override
  int get length => throw Exception("Stub implementation");

  @override
  StackRouter get router => throw Exception("Stub implementation");
}
