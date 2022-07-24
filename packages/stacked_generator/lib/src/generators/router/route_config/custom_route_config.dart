import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router/models/route_parameter_config.dart';

import '../models/custom_transition_builder.dart';
import 'route_config.dart';

class CustomRouteConfig extends RouteConfig {
  final int? durationInMilliseconds;
  final int? reverseDurationInMilliseconds;
  final bool customRouteOpaque;
  final bool customRouteBarrierDismissible;
  final CustomTransitionBuilder? transitionBuilder;
  const CustomRouteConfig(
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
      this.durationInMilliseconds,
      this.reverseDurationInMilliseconds,
      this.customRouteOpaque = true,
      this.customRouteBarrierDismissible = false,
      this.transitionBuilder,
      super.parentClassName});

  @override
  Code registerRoute() {
    return super.registerRouteBloc(
      routeType: 'PageRouteBuilder',
      routeTypeImport: 'package:flutter/material.dart',
      usePageBuilder: true,
      extra: Block.of([
        if (!customRouteOpaque) Code('opaque:${customRouteOpaque.toString()},'),
        if (customRouteBarrierDismissible)
          Code(
              'barrierDismissible:${customRouteBarrierDismissible.toString()},'),
        if (transitionBuilder != null) ...[
          Code('transitionsBuilder: data.transition ?? '),
          Reference(transitionBuilder!.name, transitionBuilder!.import).code,
          Code(',')
        ],
        if (transitionBuilder == null)
          Code('''transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          },'''),
        if (durationInMilliseconds != null)
          Code(
              'transitionDuration: const Duration(milliseconds: ${durationInMilliseconds}),'),
        if (reverseDurationInMilliseconds != null)
          Code(
              'reverseTransitionDuration: const Duration(milliseconds: ${reverseDurationInMilliseconds}),'),
      ]),
    );
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
    return CustomRouteConfig(
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
