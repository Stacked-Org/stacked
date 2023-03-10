import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_shared/stacked_shared.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_parameter_config.dart';
import 'package:stacked_generator/utils.dart';

import '../../router_common/models/importable_type.dart';
import '../../router_common/models/route_config.dart';
import '../../router_common/models/router_config.dart';
import '../../router_common/resolvers/type_resolver.dart';
import 'route_config_resolver.dart';

/// Extracts and holds router configs

class RouterConfigResolver {
  final TypeResolver _typeResolver;
  late RouteConfig _globalRouteConfig;

  RouterConfigResolver(this._typeResolver);

  RouterConfig resolve(
    ConstantReader stackedApp,
    ClassElement clazz, {
    bool usesPartBuilder = false,
  }) {
    int routeType = RouteType.material;
    int? durationInMilliseconds;
    int? reverseDurationInMilliseconds;
    bool? customRouteOpaque;
    bool? customRouteBarrierDismissible;
    ResolvedType? transitionBuilder;
    ResolvedType? customRouteBuilder;
    if (stackedApp.instanceOf(const TypeChecker.fromRuntime(CupertinoRouter))) {
      routeType = RouteType.cupertino;
    } else if (stackedApp
        .instanceOf(const TypeChecker.fromRuntime(AdaptiveRouter))) {
      routeType = RouteType.adaptive;
    } else if (stackedApp
        .instanceOf(const TypeChecker.fromRuntime(CustomRouter))) {
      routeType = RouteType.custom;

      durationInMilliseconds =
          stackedApp.peek('durationInMilliseconds')?.intValue;
      reverseDurationInMilliseconds =
          stackedApp.peek('reverseDurationInMilliseconds')?.intValue;
      customRouteOpaque = stackedApp.peek('opaque')?.boolValue;
      customRouteBarrierDismissible =
          stackedApp.peek('barrierDismissible')?.boolValue;
      final function =
          stackedApp.peek('transitionsBuilder')?.objectValue.toFunctionValue();
      if (function != null) {
        transitionBuilder = _typeResolver.resolveFunctionType(function);
      }
      final customRouteBuilderValue =
          stackedApp.peek('customRouteBuilder')?.objectValue.toFunctionValue();
      if (customRouteBuilderValue != null) {
        customRouteBuilder =
            _typeResolver.resolveFunctionType(customRouteBuilderValue);
      }
    }

    final deferredLoading =
        stackedApp.peek('deferredLoading')?.boolValue ?? false;

    _globalRouteConfig = RouteConfig(
      routeType: routeType,
      fullscreenDialog: false,
      reverseDurationInMilliseconds: reverseDurationInMilliseconds,
      durationInMilliseconds: durationInMilliseconds,
      customRouteOpaque: customRouteOpaque,
      customRouteBarrierDismissible: customRouteBarrierDismissible,
      transitionBuilder: transitionBuilder,
      customRouteBuilder: customRouteBuilder,
      className: '',
      classImport: '',
      pathName: '',
      deferredLoading: deferredLoading,
    );

    var replaceInRouteName = stackedApp.peek('replaceInRouteName')?.stringValue;

    final routesDartObjects = stackedApp.read('routes').listValue;
    final generateNavigationExt =
        stackedApp.peek('generateNavigationHelperExtension')?.boolValue ??
            false;
    final routeNamePrefix = stackedApp.peek('routePrefix')?.stringValue ?? '/';

    final routesClassName =
        stackedApp.peek('routesClassName')?.stringValue ?? 'Routes';

    var routerConfig = RouterConfig(
      parentRouteConfig: _globalRouteConfig,
      routerClassName:
          usesPartBuilder ? '_\$${clazz.displayName}' : 'StackedRouter',
      routesClassName: routesClassName,
      element: clazz,
      replaceInRouteName: replaceInRouteName,
      routes: const [],
      deferredLoading: deferredLoading,
      generateNavigationHelper: generateNavigationExt,
      routeNamePrefix: routeNamePrefix,
    );

    var routes = _resolveRoutes(
      routerConfig,
      routesDartObjects,
      routeNamePrefix: routeNamePrefix,
    );

    return routerConfig.copyWith(routes: routes);
  }

  List<RouteConfig> _resolveRoutes(
    RouterConfig routerConfig,
    List<DartObject> routesList, {
    List<PathParamConfig> inheritedPathParams = const [],
    String? routeNamePrefix,
  }) {
    var routeResolver =
        RouteConfigResolver(routeNamePrefix, routerConfig, _typeResolver);
    final routes = <RouteConfig>[];
    for (var entry in routesList) {
      var routeReader = ConstantReader(entry);
      RouteConfig route;
      route = routeResolver.resolve(
        routeReader,
        inheritedPathParams,
        parentRouterConfig: routerConfig.parent,
      );

      var children = routeReader.peek('children')?.listValue;
      if (children?.isNotEmpty == true) {
        var subRouterConfig = routerConfig.copyWith(
          parent: routerConfig.copyWith(
            routesClassName: '${route.className}Routes',
            routerClassName: '${route.className}Router',
          ),
        );
        var nestedRoutes = _resolveRoutes(
          subRouterConfig,
          children!,
          inheritedPathParams: inheritedPathParams + route.pathParams,
        );
        route = route.copyWith(
          childRouterConfig: subRouterConfig.copyWith(routes: nestedRoutes),
          children: nestedRoutes,
          parentRouterConfig: routerConfig.parent,
        );
      }

      routes.add(route);
    }

    // to generate auto redirect for initial routes
    final initialPath = routerConfig.parent == null ? '/' : '';
    var initialRoute = routes.firstOrNull((r) => r.initial);
    if (initialRoute != null && !routes.any((r) => r.pathName == initialPath)) {
      routes.insert(
          0,
          RouteConfig(
            pathName: initialPath,
            redirectTo: initialRoute.pathName,
            className: '',
            classImport: '',
            fullMatch: true,
            routeType: RouteType.redirect,
            deferredLoading: false,
          ));
    }

    return routes;
  }
}
