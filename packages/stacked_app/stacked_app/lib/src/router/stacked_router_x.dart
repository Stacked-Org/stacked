import 'package:flutter/widgets.dart' show BuildContext;

import '../route/route_data.dart';
import 'controller/routing_controller.dart';
import 'widgets/stacked_router.dart';

extension StackedRouterX on BuildContext {
  RoutingController get router => StackedRouter.of(this);

  RoutingController findChildRouter(String routeKey) => StackedRouter.ofChildRoute(this, routeKey);

  RouteData get route => RouteData.of(this);
}
