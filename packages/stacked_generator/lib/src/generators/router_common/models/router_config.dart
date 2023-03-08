import 'package:analyzer/dart/element/element.dart' show ClassElement;

import 'route_config.dart';

class RouterConfig {
  final List<RouteConfig> routes;
  final bool generateNavigationHelper;
  final String routesClassName;
  final String? routeNamePrefix;
  final RouteConfig? parentRouteConfig;
  final String routerClassName;
  final RouterConfig? parent;
  final String? replaceInRouteName;
  final ClassElement? element;
  final bool deferredLoading;

  RouterConfig({
    this.generateNavigationHelper = false,
    required this.routesClassName,
    this.routeNamePrefix,
    required this.routes,
    this.element,
    this.parentRouteConfig,
    required this.routerClassName,
    this.parent,
    this.replaceInRouteName,
    this.deferredLoading = false,
  });

  RouterConfig copyWith({
    bool? generateNavigationHelper,
    List<RouteConfig>? routes,
    RouteConfig? parentRouteConfig,
    String? routesClassName,
    String? routeNamePrefix,
    String? routerClassName,
    RouterConfig? parent,
    String? replaceInRouteName,
    ClassElement? element,
    bool? deferredLoading,
  }) {
    return RouterConfig(
      routes: routes ?? this.routes,
      parentRouteConfig: parentRouteConfig ?? this.parentRouteConfig,
      routerClassName: routerClassName ?? this.routerClassName,
      replaceInRouteName: replaceInRouteName ?? this.replaceInRouteName,
      parent: parent ?? this.parent,
      element: this.element,
      deferredLoading: deferredLoading ?? this.deferredLoading,
      routesClassName: routesClassName ?? this.routesClassName,
      generateNavigationHelper:
          generateNavigationHelper ?? this.generateNavigationHelper,
      routeNamePrefix: routeNamePrefix ?? this.routeNamePrefix,
    );
  }

  List<RouteConfig> get routesIncludingTheirChildren => nestedRoutes(routes);

  final List<RouteConfig> _allRoutes = [];
  List<RouteConfig> nestedRoutes(List<RouteConfig> routes) {
    if (routes.isEmpty) return [];
    _allRoutes.addAll(routes);
    routes.where((element) => element.children.isNotEmpty).forEach((element) {
      nestedRoutes(element.children);
    });

    return _allRoutes;
  }

  @override
  String toString() {
    return 'RouterConfig{routes: $routes, routesClassName: $routesClassName, routerClassName: $routerClassName}';
  }

  List<RouterConfig> get subRouters {
    final routers = <RouterConfig>[];
    for (final route in routes) {
      if (route.childRouterConfig != null) {
        routers.add(route.childRouterConfig!);
      }
    }
    return routers;
  }

  List<RouterConfig> get collectAllRoutersIncludingParent => subRouters.fold(
      [this], (all, e) => all..addAll(e.collectAllRoutersIncludingParent));
}
