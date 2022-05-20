import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';

import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/utils.dart';

import '../router_config.dart';
import 'adaptive_route_config.dart';
import 'cupertino_route_config.dart';
import 'custom_route_config.dart';
import 'material_route_config.dart';

/// holds the extracted route configs
/// to be used in [RouterClassGenerator]

class RouteConfig {
  final String name;
  final String pathName;
  final String className;
  final bool fullscreenDialog;
  final bool maintainState;
  final String? returnType;
  final List<RouteParamConfig>? parameters;
  final List<RouteGuardConfig> guards;
  final bool? hasWrapper;
  final RouterConfig? routerConfig;
  final bool hasConstConstructor;
  final Set<String> imports;
  const RouteConfig({
    required this.name,
    required this.pathName,
    required this.className,
    this.fullscreenDialog = false,
    this.maintainState = false,
    this.returnType,
    this.parameters,
    this.guards = const [],
    this.hasWrapper,
    this.routerConfig,
    this.hasConstConstructor = false,
    this.imports = const {},
  });

  String get argumentsHolderClassName {
    return '${className}Arguments';
  }

  // String registerImports();

  String? get templateName {
    return pathName.contains(":") ? '_$name' : name;
  }

  List<RouteParamConfig> get notQueryAndNotPath {
    return parameters?.where((p) {
          throwIf(p.isPathParam == null || p.isQueryParam == null,
              ExceptionMessages.isPathParamAndIsQueryParamShouldNotBeNull);
          return !p.isPathParam! && !p.isQueryParam!;
        }).toList() ??
        [];
  }

  factory RouteConfig.fromStackedApp(
    ConstantReader stackedRoute,
    ImportResolver importResolver,
    RouterConfig routerConfig,
  ) {
    if (stackedRoute.instanceOf(TypeChecker.fromRuntime(MaterialRoute))) {
      return MaterialRouteConfig.fromStackedApp(
          stackedRoute, importResolver, routerConfig);
    } else if (stackedRoute
        .instanceOf(TypeChecker.fromRuntime(CupertinoRoute))) {
      return CupertinoRouteConfig.fromStackedApp(
          stackedRoute, importResolver, routerConfig);
    } else if (stackedRoute
        .instanceOf(TypeChecker.fromRuntime(AdaptiveRoute))) {
      return AdaptiveRouteConfig.fromStackedApp(
          stackedRoute, importResolver, routerConfig);
    } else if (stackedRoute.instanceOf(TypeChecker.fromRuntime(CustomRoute))) {
      return CustomRouteConfig.fromStackedApp(
          stackedRoute, importResolver, routerConfig);
    } else {
      return MaterialRouteConfig.fromStackedApp(
          stackedRoute, importResolver, routerConfig);
    }
  }

  RouteConfig copyWith({
    String? name,
    String? pathName,
    String? className,
    bool? fullscreenDialog,
    bool? maintainState,
    String? returnType,
    List<RouteParamConfig>? parameters,
    List<RouteGuardConfig>? guards,
    bool? hasWrapper,
    RouterConfig? routerConfig,
    bool? hasConstConstructor,
    Set<String>? imports,
  }) {
    return RouteConfig(
      name: name ?? this.name,
      pathName: pathName ?? this.pathName,
      className: className ?? this.className,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      maintainState: maintainState ?? this.maintainState,
      returnType: returnType ?? this.returnType,
      parameters: parameters ?? this.parameters,
      guards: guards ?? this.guards,
      hasWrapper: hasWrapper ?? this.hasWrapper,
      routerConfig: routerConfig ?? this.routerConfig,
      hasConstConstructor: hasConstConstructor ?? this.hasConstConstructor,
      imports: imports ?? this.imports,
    );
  }
}
