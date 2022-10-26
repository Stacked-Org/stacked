import 'package:analyzer/dart/constant/value.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/type_resolver.dart';

import 'router_config.dart';

class RouterConfigResolver {
  final TypeResolver _typeResolver;

  const RouterConfigResolver(this._typeResolver);

  Future<RouterConfig?> resolve(ConstantReader stackedApp) async {
    /// If routes is not provided return null
    if (!stackedApp.read('routes').isList) return null;

    final routesDartObjects = stackedApp.read('routes').listValue;
    final generateNavigationExt =
        stackedApp.peek('generateNavigationHelperExtension')?.boolValue ??
            false;
    final routeNamePrefix = stackedApp.peek('routePrefix')?.stringValue ?? '/';
    final routesClassName =
        stackedApp.peek('routesClassName')?.stringValue ?? 'Routes';

    final routerConfig = RouterConfig(
      routerClassName: 'StackedRouter',
      routesClassName: routesClassName,
      routeNamePrefix: routeNamePrefix,
      generateNavigationHelper: generateNavigationExt,
    );

    final extractedRoutes =
        await _resolveRoutes(routerConfig, routesDartObjects);

    return routerConfig.copyWith(routes: extractedRoutes);
  }

  Future<List<RouteConfig>> _resolveRoutes(
    RouterConfig routerConfig,
    List<DartObject> routesList, {
    String? parentClassName,
  }) async {
    final List<RouteConfig> allRoutes = [];

    for (var routeDartObject in routesList) {
      final routeReader = ConstantReader(routeDartObject);
      var route =
          await RouteConfigResolver(routerConfig.routeNamePrefix, _typeResolver)
              .resolve(routeReader, parentClassName: parentClassName);

      final children = routeReader.peek('children')?.listValue;

      if (children?.isNotEmpty ?? false) {
        final childrenRoutes = await _resolveRoutes(routerConfig, children!,
            parentClassName: route.className.key);
        route = route.copyWith(children: childrenRoutes);
      }
      allRoutes.add(route);
    }
    return allRoutes;
  }
}
