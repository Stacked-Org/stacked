import 'package:stacked/src/router/controller/routing_controller.dart';
import 'package:stacked/src/router/matcher/route_match.dart';
import 'package:stacked/src/router/route/page_route_info.dart';

typedef OnNavigationFailure = void Function(NavigationFailure failure);

abstract class NavigationFailure {
  const NavigationFailure();
}

class RouteNotFoundFailure extends NavigationFailure {
  final PageRouteInfo route;

  const RouteNotFoundFailure(this.route);

  @override
  String toString() {
    return "Failed to navigate to ${route.fullPath}";
  }
}

class RejectedByGuardFailure extends NavigationFailure {
  final RouteMatch route;
  final StackedRouteGuard guard;

  const RejectedByGuardFailure(this.route, this.guard);

  @override
  String toString() {
    return '${route.stringMatch} rejected by guard ${guard.runtimeType}';
  }
}
