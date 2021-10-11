import 'package:analyzer/dart/constant/value.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/utils.dart';
import 'package:source_gen/source_gen.dart';

/// Extracts and holds router configs
/// to be used in [RouterClassGenerator]

class RouterConfig {
  final bool? generateNavigationHelper;
  final List<RouteConfig>? routes;
  final RouteConfig? globalRouteConfig;
  final String? routesClassName;
  final String? routeNamePrefix;
  final String? routerClassName;

  RouterConfig({
    this.generateNavigationHelper,
    this.routes,
    this.globalRouteConfig,
    this.routesClassName,
    this.routeNamePrefix,
    this.routerClassName,
  });

  RouterConfig copyWith({
    bool? generateNavigationHelper,
    List<RouteConfig>? routes,
    RouteConfig? globalRouteConfig,
    String? routesClassName,
    String? routeNamePrefix,
    String? routerClassName,
  }) {
    return RouterConfig(
      generateNavigationHelper:
          generateNavigationHelper ?? this.generateNavigationHelper,
      routes: routes ?? this.routes,
      globalRouteConfig: globalRouteConfig ?? this.globalRouteConfig,
      routesClassName: routesClassName ?? this.routesClassName,
      routeNamePrefix: routeNamePrefix ?? this.routeNamePrefix,
      routerClassName: routerClassName ?? this.routerClassName,
    );
  }

  List<RouterConfig?> get subRouters =>
      routes
          ?.where((e) => e.routerConfig != null)
          .map((e) => e.routerConfig)
          .toList() ??
      [];

  List<RouterConfig> get collectAllRoutersIncludingParent => subRouters.fold(
      [this], (all, e) => all..addAll(e!.collectAllRoutersIncludingParent));

  @override
  String toString() {
    return 'RouterConfig{routes: $routes, routesClassName: $routesClassName, routerClassName: $routerClassName}';
  }
}

class RouterConfigResolver {
  final ImportResolver _importResolver;

  RouterConfigResolver(this._importResolver);

  Future<RouterConfig> resolve(ConstantReader stackedApp) async {
    var globalRouteConfig = RouteConfig();
    if (stackedApp.instanceOf(TypeChecker.fromRuntime(CupertinoRouter))) {
      globalRouteConfig.routeType = RouteType.cupertino;
    } else if (stackedApp.instanceOf(TypeChecker.fromRuntime(AdaptiveRouter))) {
      globalRouteConfig.routeType = RouteType.adaptive;
    } else if (stackedApp.instanceOf(TypeChecker.fromRuntime(CustomRouter))) {
      globalRouteConfig.routeType = RouteType.custom;
      globalRouteConfig.durationInMilliseconds =
          stackedApp.peek('durationInMilliseconds')?.intValue;
      globalRouteConfig.reverseDurationInMilliseconds =
          stackedApp.peek('reverseDurationInMilliseconds')?.intValue;
      globalRouteConfig.customRouteOpaque =
          stackedApp.peek('opaque')?.boolValue;
      globalRouteConfig.customRouteBarrierDismissible =
          stackedApp.peek('barrierDismissible')?.boolValue;
      final function =
          stackedApp.peek('transitionsBuilder')?.objectValue.toFunctionValue();
      if (function != null) {
        final displayName = function.displayName.replaceFirst(RegExp('^_'), '');
        final functionName = function.isStatic
            ? '${function.enclosingElement.displayName}.$displayName'
            : displayName;

        var import;
        if (function.enclosingElement.name != 'TransitionsBuilders') {
          import = _importResolver.resolve(function);
        }
        globalRouteConfig.transitionBuilder =
            CustomTransitionBuilder(functionName, import);
      }
    }
    var generateNavigationExt =
        stackedApp.peek('generateNavigationHelperExtension')?.boolValue ??
            false;
    var routeNamePrefix = stackedApp.peek('routePrefix')?.stringValue ?? '/';
    var routesClassName =
        stackedApp.peek('routesClassName')?.stringValue ?? 'Routes';

    final stackedRoutes = stackedApp.read('routes').listValue;

    var routerConfig = RouterConfig(
      globalRouteConfig: globalRouteConfig,
      routerClassName: 'StackedRouter',
      routesClassName: routesClassName,
      routeNamePrefix: routeNamePrefix,
      generateNavigationHelper: generateNavigationExt,
    );

    var routes = await _resolveRoutes(routerConfig, stackedRoutes);
    return routerConfig.copyWith(routes: routes);
  }

  Future<List<RouteConfig>> _resolveRoutes(
    RouterConfig routerConfig,
    List<DartObject> routesList,
  ) async {
    var routeResolver = RouteConfigResolver(routerConfig, _importResolver);
    final routes = <RouteConfig>[];
    for (var entry in routesList) {
      var routeReader = ConstantReader(entry);
      RouteConfig route;
      route = await routeResolver.resolve(routeReader);
      routes.add(route);

      var children = routeReader.peek('children')?.listValue;
      if (children?.isNotEmpty == true) {
        var name = capitalize(route.name);
        var subRouterConfig = routerConfig.copyWith(
          routerClassName: '${name}Router',
          routesClassName: '${name}Routes',
        );
        var routes = await _resolveRoutes(subRouterConfig, children!);
        route.routerConfig = subRouterConfig.copyWith(routes: routes);
      }
    }
    return routes;
  }
}
