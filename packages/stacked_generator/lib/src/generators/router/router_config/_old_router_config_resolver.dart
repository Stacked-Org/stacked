import 'package:analyzer/dart/constant/value.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/src/generators/router_2/resolvers/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';
import 'package:stacked_generator/src/generators/router_common/models/router_config.dart';

import '../../router_common/resolvers/type_resolver.dart';

// ignore: camel_case_types, unused_element
class _OLD_RouterConfigResolver {
  final TypeResolver _typeResolver;

  const _OLD_RouterConfigResolver(this._typeResolver);

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
      routes: [],
    );

    final extractedRoutes =
        await _resolveRoutes(routerConfig, routesDartObjects);

    return routerConfig.copyWith(routes: extractedRoutes);
  }

  Future<List<RouteConfig>> _resolveRoutes(
    RouterConfig routerConfig,
    List<DartObject> routesList,
  ) async {
    final List<RouteConfig> allRoutes = [];

    for (var routeDartObject in routesList) {
      final routeReader = ConstantReader(routeDartObject);
      var route = RouteConfigResolver(
              routerConfig.routeNamePrefix, routerConfig, _typeResolver)
          .resolve(
        routeReader,
        [],
      );

      final children = routeReader.peek('children')?.listValue;

      if (children?.isNotEmpty ?? false) {
        final childrenRoutes = await _resolveRoutes(
          routerConfig,
          children!,
          // parentClassName:
          //     route.className.toLowerCase() != route.name?.toLowerCase()
          //         ? (route.name ?? '').capitalize
          //         : route.className,
        );
        route = route.copyWith(children: childrenRoutes);
      }
      allRoutes.add(route);
    }
    return allRoutes;
  }
}
