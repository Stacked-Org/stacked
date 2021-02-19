import 'package:stacked_app/src/router/controller/routing_controller.dart';

import 'route/page_route_info.dart';

abstract class StackedRouteGuard {
  Future<bool> canNavigate(
    List<PageRouteInfo> routes,
    RoutingController router,
  );
}
