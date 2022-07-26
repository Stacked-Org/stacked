import '../route_config/route_config.dart';

/// Extracts and holds router configs
/// to be used in [RouterClassGenerator]

class RouterConfig {
  final bool generateNavigationHelper;
  final List<RouteConfig> routes;
  final String routesClassName;
  final String? routeNamePrefix;
  final String routerClassName;

  RouterConfig({
    this.generateNavigationHelper = false,
    this.routes = const [],
    required this.routesClassName,
    this.routeNamePrefix,
    required this.routerClassName,
  });

  RouterConfig copyWith({
    bool? generateNavigationHelper,
    List<RouteConfig>? routes,
    String? routesClassName,
    String? routeNamePrefix,
    String? routerClassName,
  }) {
    return RouterConfig(
      generateNavigationHelper:
          generateNavigationHelper ?? this.generateNavigationHelper,
      routes: routes ?? this.routes,
      routesClassName: routesClassName ?? this.routesClassName,
      routeNamePrefix: routeNamePrefix ?? this.routeNamePrefix,
      routerClassName: routerClassName ?? this.routerClassName,
    );
  }

  List<RouteConfig> get routesIncludingTheirChildren => nestedRoutes(routes);

  List<RouteConfig> _allRoutes = [];
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
}
