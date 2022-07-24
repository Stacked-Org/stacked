import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router/models/route_parameter_config.dart';

import 'route_config.dart';

class MaterialRouteConfig extends RouteConfig {
  const MaterialRouteConfig(
      {required super.name,
      required super.pathName,
      required super.className,
      super.fullscreenDialog,
      super.maintainState,
      super.returnType,
      super.parameters,
      super.hasWrapper,
      super.hasConstConstructor,
      super.children,
      super.imports,
      super.parentClassName});

  @override
  Code registerRoutes() {
    return Block.of([
      Code('return '),
      Reference('MaterialPageRoute', 'package:flutter/material.dart').code,
      Code(
          '<$processedReturnType>(builder: (context) => $joinedConstructerParams, settings: data,'),
      super.registerRoutes(),
    ]);
  }

  @override
  RouteConfig copyWith(
      {String? name,
      String? pathName,
      MapEntry<String, String>? className,
      bool? fullscreenDialog,
      bool? maintainState,
      String? returnType,
      List<RouteParamConfig>? parameters,
      bool? hasWrapper,
      List<RouteConfig>? children,
      bool? hasConstConstructor,
      Set<String>? imports,
      String? parentClassName}) {
    return MaterialRouteConfig(
      name: name ?? this.name,
      pathName: pathName ?? this.pathName,
      className: className ?? this.className,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      maintainState: maintainState ?? this.maintainState,
      returnType: returnType ?? this.returnType,
      parameters: parameters ?? this.parameters,
      hasWrapper: hasWrapper ?? this.hasWrapper,
      children: children ?? this.children,
      hasConstConstructor: hasConstConstructor ?? this.hasConstConstructor,
      imports: imports ?? this.imports,
      parentClassName: parentClassName ?? this.parentClassName,
    );
  }
}
