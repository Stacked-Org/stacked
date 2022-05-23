import 'package:analyzer/dart/constant/value.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/utils.dart';
import 'package:source_gen/source_gen.dart';

import 'router_config.dart';

class RouterConfigResolver {
  final ImportResolver _importResolver;

  RouterConfigResolver(this._importResolver);

  Future<RouterConfig> resolve(ConstantReader stackedApp) async {
    final generateNavigationExt =
        stackedApp.peek('generateNavigationHelperExtension')?.boolValue ??
            false;
    final routeNamePrefix = stackedApp.peek('routePrefix')?.stringValue ?? '/';
    final routesClassName =
        stackedApp.peek('routesClassName')?.stringValue ?? 'Routes';

    final stackedRoutes = stackedApp.read('routes').listValue;

    var routerConfig = RouterConfig(
      routerClassName: 'StackedRouter',
      routesClassName: routesClassName,
      routeNamePrefix: routeNamePrefix,
      generateNavigationHelper: generateNavigationExt,
    );

    final routes = await _resolveRoutes(routerConfig, stackedRoutes);
    return routerConfig.copyWith(routes: routes);
  }

  Future<List<RouteConfig>> _resolveRoutes(
    RouterConfig routerConfig,
    List<DartObject> routesList,
  ) async {
    final List<RouteConfig> routes = [];

    for (var routeDartObject in routesList) {
      final routeReader = ConstantReader(routeDartObject);

      final route = await RouteConfigResolver(routerConfig, _importResolver)
          .resolve(routeReader);

      routes.add(route);

      final children = routeReader.peek('children')?.listValue;
      if (children?.isNotEmpty ?? false) {
        final capitalizedRouteName = capitalize(route.name);
        final subRouterConfig = routerConfig.copyWith(
          routerClassName: '${capitalizedRouteName}Router',
          routesClassName: '${capitalizedRouteName}Routes',
        );
        final routes = await _resolveRoutes(subRouterConfig, children!);
        route.copyWith(routerConfig: subRouterConfig.copyWith(routes: routes));
      }
    }
    return routes;
  }
}
