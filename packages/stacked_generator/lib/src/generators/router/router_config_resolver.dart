import 'package:analyzer/dart/constant/value.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/route_config/adaptive_route_config.dart';
import 'package:stacked_generator/src/generators/router/route_config/cupertino_route_config.dart';
import 'package:stacked_generator/src/generators/router/route_config/custom_route_config.dart';
import 'package:stacked_generator/utils.dart';
import 'package:source_gen/source_gen.dart';

import 'router_config.dart';

class RouterConfigResolver {
  final ImportResolver _importResolver;

  RouterConfigResolver(this._importResolver);

  Future<RouterConfig> resolve(ConstantReader stackedApp) async {
    var generateNavigationExt =
        stackedApp.peek('generateNavigationHelperExtension')?.boolValue ??
            false;
    var routeNamePrefix = stackedApp.peek('routePrefix')?.stringValue ?? '/';
    var routesClassName =
        stackedApp.peek('routesClassName')?.stringValue ?? 'Routes';

    final stackedRoutes = stackedApp.read('routes').listValue;

    var routerConfig = RouterConfig(
      globalRouteConfig: _extractGlobalRouteConfigOrNull(stackedApp),
      routerClassName: 'StackedRouter',
      routesClassName: routesClassName,
      routeNamePrefix: routeNamePrefix,
      generateNavigationHelper: generateNavigationExt,
    );

    final routes = await _resolveRoutes(routerConfig, stackedRoutes);
    return routerConfig.copyWith(routes: routes);
  }

  RouteConfig? _extractGlobalRouteConfigOrNull(ConstantReader stackedApp) {
    if (stackedApp.instanceOf(TypeChecker.fromRuntime(CupertinoRouter))) {
      return CupertinoRouteConfig();
    } else if (stackedApp.instanceOf(TypeChecker.fromRuntime(AdaptiveRouter))) {
      return AdaptiveRouteConfig();
    } else if (stackedApp.instanceOf(TypeChecker.fromRuntime(CustomRouter))) {
      return CustomRouteConfig(
        durationInMilliseconds:
            stackedApp.peek('durationInMilliseconds')?.intValue,
        reverseDurationInMilliseconds:
            stackedApp.peek('reverseDurationInMilliseconds')?.intValue,
        customRouteBarrierDismissible:
            stackedApp.peek('barrierDismissible')?.boolValue ?? false,
        customRouteOpaque: stackedApp.peek('opaque')?.boolValue ?? false,
        transitionBuilder: _extractCustomTransitionBuilderOrNull(stackedApp),
      );
    }
    return null;
  }

  CustomTransitionBuilder? _extractCustomTransitionBuilderOrNull(
      ConstantReader stackedApp) {
    final function =
        stackedApp.peek('transitionsBuilder')?.objectValue.toFunctionValue();

    if (function != null) {
      final displayName = function.displayName.replaceFirst(RegExp('^_'), '');

      final functionName = function.isStatic
          ? '${function.enclosingElement.displayName}.$displayName'
          : displayName;

      return CustomTransitionBuilder(
          functionName,
          function.enclosingElement.name != 'TransitionsBuilders'
              ? _importResolver.resolve(function)
              : null);
    }
    return null;
  }

  Future<List<RouteConfig>> _resolveRoutes(
    RouterConfig routerConfig,
    List<DartObject> routesList,
  ) async {
    final List<RouteConfig> routes = [];

    for (var entry in routesList) {
      final routeReader = ConstantReader(entry);

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
        route.routerConfig = subRouterConfig.copyWith(routes: routes);
      }
    }
    return routes;
  }
}
