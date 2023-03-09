import 'package:flutter/widgets.dart' show BuildContext, optionalTypeArgs;
import 'package:stacked/src/router/route/page_route_info.dart';
import 'package:stacked/src/router/widgets/auto_tabs_router.dart';

import 'controller/controller_scope.dart';
import 'controller/routing_controller.dart';
import 'matcher/route_match.dart';
import 'navigation_failure.dart';
import 'widgets/nested_router.dart';

extension StackedRouterExtensions on BuildContext {
  StackRouter get router => NestedRouter.of(this);

  StackRouter get watchRouter => NestedRouter.of(this, watch: true);

  @optionalTypeArgs
  Future<T?> pushRoute<T extends Object?>(PageRouteInfo route,
          {OnNavigationFailure? onFailure}) =>
      router.push<T>(route, onFailure: onFailure);

  @optionalTypeArgs
  Future<T?> replaceRoute<T extends Object?>(PageRouteInfo route,
          {OnNavigationFailure? onFailure}) =>
      router.replace<T>(route, onFailure: onFailure);

  @optionalTypeArgs
  Future<bool> popRoute<T extends Object?>([T? result]) =>
      router.pop<T>(result);

  Future<void> navigateTo(PageRouteInfo route,
          {OnNavigationFailure? onFailure}) =>
      RouterScope.of(this).controller.navigate(
            route,
            onFailure: onFailure,
          );

  void navigateBack() => RouterScope.of(this).controller.navigateBack();

  Future<void> navigateNamedTo(String path,
          {bool includePrefixMatches = false,
          OnNavigationFailure? onFailure}) =>
      RouterScope.of(this).controller.navigateNamed(
            path,
            includePrefixMatches: includePrefixMatches,
            onFailure: onFailure,
          );

  TabsRouter get tabsRouter => AutoTabsRouter.of(this);

  TabsRouter get watchTabsRouter => AutoTabsRouter.of(this, watch: true);

  // returns the top most rendered route
  RouteData get topRoute => watchRouter.topRoute;

  // returns the top most match rendered or pending
  RouteMatch get topRouteMatch => watchRouter.topMatch;

  T? innerRouterOf<T extends RoutingController>(String routeKey) =>
      RouterScope.of(this).controller.innerRouterOf<T>(routeKey);

  RouteData get routeData => RouteData.of(this);
}
