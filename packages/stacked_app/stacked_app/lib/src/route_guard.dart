import 'dart:async';

import 'package:stacked_app/src/extended_navigator.dart';

abstract class RouteGuard {
  Future<bool> canNavigate(
    ExtendedNavigatorState navigator,
    String routeName,
    Object arguments,
  );
}
