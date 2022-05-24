import 'package:stacked_generator/route_config_resolver.dart';

import '../router_config.dart';

class MaterialRouteConfig extends RouteConfig {
  final String name;
  final String pathName;
  final String className;
  final bool fullscreenDialog;
  final bool maintainState;
  final String? returnType;
  final List<RouteParamConfig> parameters;
  final List<RouteGuardConfig> guards;
  final bool hasWrapper;
  final bool hasConstConstructor;
  final RouterConfig? routerConfig;
  final Set<String> imports;
  MaterialRouteConfig({
    required this.name,
    required this.pathName,
    required this.className,
    this.fullscreenDialog = false,
    this.maintainState = true,
    this.returnType,
    this.parameters = const [],
    this.guards = const [],
    this.hasWrapper = false,
    this.hasConstConstructor = false,
    this.routerConfig,
    this.imports = const {},
  }) : super(
          imports: imports,
          hasConstConstructor: hasConstConstructor,
          name: name,
          pathName: pathName,
          className: className,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          returnType: returnType,
          parameters: parameters,
          guards: guards,
          hasWrapper: hasWrapper,
          routerConfig: routerConfig,
        );

  @override
  Set<String> registerImports() {
    return {...super.registerImports(), "package:flutter/material.dart"};
  }

  @override
  String registerRoutes() {
    StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(super.registerArgs());
    stringBuffer.write(
        'return MaterialPageRoute<$processedReturnType>(builder: (context) => $joinedConstructerParams, settings: data,');
    stringBuffer.write(super.registerRoutes());
    return stringBuffer.toString();
  }

  MaterialRouteConfig copyWith({
    String? name,
    String? pathName,
    String? className,
    bool? fullscreenDialog,
    bool? maintainState,
    String? returnType,
    List<RouteParamConfig>? parameters,
    List<RouteGuardConfig>? guards,
    bool? hasWrapper,
    bool? hasConstConstructor,
    RouterConfig? routerConfig,
    Set<String>? imports,
  }) {
    return MaterialRouteConfig(
      name: name ?? this.name,
      pathName: pathName ?? this.pathName,
      className: className ?? this.className,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      maintainState: maintainState ?? this.maintainState,
      returnType: returnType ?? this.returnType,
      parameters: parameters ?? this.parameters,
      guards: guards ?? this.guards,
      hasWrapper: hasWrapper ?? this.hasWrapper,
      hasConstConstructor: hasConstConstructor ?? this.hasConstConstructor,
      routerConfig: routerConfig ?? this.routerConfig,
      imports: imports ?? this.imports,
    );
  }
}
