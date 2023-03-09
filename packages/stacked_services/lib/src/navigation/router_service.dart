import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// Provides a service to perform
class RouterService {
  final RootStackRouter router;

  RouterService(this.router);

  List<AutoRoutePage> get stack => router.stack;

  RouteData get topRoute => router.topRoute;

  Future<dynamic> navigate(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) =>
      router.navigate(route, onFailure: onFailure);

  Future<void> navigateToPath({
    required String path,
    bool includePrefixMatches = false,
    OnNavigationFailure? onFailure,
  }) =>
      router.navigateNamed(
        path,
        includePrefixMatches: includePrefixMatches,
        onFailure: onFailure,
      );

  void popForced<T extends Object?>([T? result]) => router.popForced(result);

  Future<bool> pop<T extends Object?>([T? result]) => router.pop(result);

  RoutingController topMostRouter({bool ignorePagelessRoutes = false}) =>
      router.topMostRouter(
        ignorePagelessRoutes: ignorePagelessRoutes,
      );

  Future<T?> pushNativeRoute<T extends Object?>(Route<T> route) =>
      router.pushNativeRoute(route);
}
