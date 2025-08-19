import 'package:flutter/material.dart';
import 'package:stacked/src/router/controller/routing_controller.dart';

class RouteDataScope extends InheritedWidget {
  final RouteData routeData;

  const RouteDataScope({
    super.key,
    required this.routeData,
    required super.child,
  });

  static RouteDataScope of(BuildContext context) {
    var scope = context.findAncestorWidgetOfExactType<RouteDataScope>();
    assert(() {
      if (scope == null) {
        throw FlutterError(
            'RouteData operation requested with a context that does not include an RouteData.\n'
            'The context used to retrieve the RouteData must be that of a widget that '
            'is a descendant of a StackedPage.');
      }
      return true;
    }());
    return scope!;
  }

  @override
  bool updateShouldNotify(covariant RouteDataScope oldWidget) {
    return routeData.route != oldWidget.routeData.route;
  }
}
