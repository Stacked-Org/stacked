import '../models/route_guard_config.dart';
import '../models/route_parameter_config.dart';
import 'route_config.dart';

class MaterialRouteConfig extends RouteConfig {
  const MaterialRouteConfig({
    required super.name,
    required super.pathName,
    required super.className,
    super.fullscreenDialog,
    super.maintainState,
    super.returnType,
    super.parameters,
    super.guards,
    super.hasWrapper,
    super.hasConstConstructor,
    super.children,
    super.imports,
  });

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
    List<RouteConfig>? children,
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
      children: children ?? this.children,
      imports: imports ?? this.imports,
    );
  }
}
