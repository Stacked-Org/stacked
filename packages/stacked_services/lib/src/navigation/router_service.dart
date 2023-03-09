import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/// Provides a service to perform
class RouterService {
  late RootStackRouter router;

  setRouter(RootStackRouter router) {
    this.router = router;
  }

  List<StackedPage> get stack => router.stack;

  RouteData get topRoute => router.topRoute;

  Future<dynamic> navigateTo(
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

  Future<T?> navigateWithTransition<T extends Object?>(
    Widget widget, {
    RouteTransitionsBuilder? transitionBuilder,
    bool fullscreenDialog = false,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) =>
      router.pushWidget<T>(
        widget,
        transitionBuilder: transitionBuilder,
        transitionDuration: transitionDuration,
        fullscreenDialog: fullscreenDialog,
      );

  Future<T?> replaceWith<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) =>
      router.replace(route, onFailure: onFailure);

  Future<void> clearStackAndShow(PageRouteInfo route,
      {OnNavigationFailure? onFailure}) {
    return router.pushAll([route], onFailure: onFailure);
  }

  Future<void> clearStackAndShowView(
    Widget widget, {
    RouteTransitionsBuilder? transitionBuilder,
    bool fullscreenDialog = false,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) {
    router.clear();
    return navigateWithTransition(
      widget,
      transitionBuilder: transitionBuilder,
      transitionDuration: transitionDuration,
      fullscreenDialog: fullscreenDialog,
    );
  }

  void popForced<T extends Object?>([T? result]) => router.popForced(result);

  Future<bool> pop<T extends Object?>([T? result]) => router.pop(result);

  RoutingController topMostRouter({bool ignorePagelessRoutes = false}) =>
      router.topMostRouter(
        ignorePagelessRoutes: ignorePagelessRoutes,
      );

  Future<T?> pushNativeRoute<T extends Object?>(Route<T> route) =>
      router.pushNativeRoute(route);
}
