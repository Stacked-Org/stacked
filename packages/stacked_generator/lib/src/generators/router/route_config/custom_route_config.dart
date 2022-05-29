import '../models/custom_transition_builder.dart';
import '../models/route_guard_config.dart';
import '../models/route_parameter_config.dart';
import 'route_config.dart';

class CustomRouteConfig extends RouteConfig {
  final int? durationInMilliseconds;
  final int? reverseDurationInMilliseconds;
  final bool customRouteOpaque;
  final bool customRouteBarrierDismissible;
  final CustomTransitionBuilder? transitionBuilder;
  CustomRouteConfig({
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
    this.durationInMilliseconds,
    this.reverseDurationInMilliseconds,
    this.customRouteOpaque = true,
    this.customRouteBarrierDismissible = false,
    this.transitionBuilder,
  });
  @override
  Set<String> registerImports() {
    return {
      ...super.registerImports(),
      "package:flutter/material.dart",
      this.transitionBuilder?.import ?? ''
    }.takeWhile((value) => value.isNotEmpty).toSet();
  }

  @override
  String registerRoutes() {
    StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(super.registerArgs());
    stringBuffer.write(
        'return PageRouteBuilder<$processedReturnType>(pageBuilder: (context, animation, secondaryAnimation) => $joinedConstructerParams, settings: data,');

    if (!customRouteOpaque)
      stringBuffer.write('opaque:${customRouteOpaque.toString()},');

    if (customRouteBarrierDismissible) {
      stringBuffer.write(
          'barrierDismissible:${customRouteBarrierDismissible.toString()},');
    }
    if (transitionBuilder != null) {
      stringBuffer.write('transitionsBuilder: ${transitionBuilder!.name},');
    }
    if (durationInMilliseconds != null) {
      stringBuffer.write(
          'transitionDuration: const Duration(milliseconds: ${durationInMilliseconds}),');
    }
    if (reverseDurationInMilliseconds != null) {
      stringBuffer.write(
          'reverseTransitionDuration: const Duration(milliseconds: ${reverseDurationInMilliseconds}),');
    }
    stringBuffer.write(super.registerRoutes());
    return stringBuffer.toString();
  }

  CustomRouteConfig copyWith({
    String? name,
    String? pathName,
    String? className,
    bool? fullscreenDialog,
    bool? maintainState,
    String? returnType,
    List<RouteParamConfig>? parameters,
    List<RouteGuardConfig>? guards,
    bool? hasWrapper,
    List<RouteConfig>? children,
    bool? hasConstConstructor,
    Set<String>? imports,
    int? durationInMilliseconds,
    int? reverseDurationInMilliseconds,
    bool? customRouteOpaque,
    bool? customRouteBarrierDismissible,
    CustomTransitionBuilder? transitionBuilder,
  }) {
    return CustomRouteConfig(
      name: name ?? this.name,
      pathName: pathName ?? this.pathName,
      className: className ?? this.className,
      fullscreenDialog: fullscreenDialog ?? this.fullscreenDialog,
      maintainState: maintainState ?? this.maintainState,
      returnType: returnType ?? this.returnType,
      parameters: parameters ?? this.parameters,
      guards: guards ?? this.guards,
      hasWrapper: hasWrapper ?? this.hasWrapper,
      children: children ?? this.children,
      hasConstConstructor: hasConstConstructor ?? this.hasConstConstructor,
      imports: imports ?? this.imports,
      durationInMilliseconds:
          durationInMilliseconds ?? this.durationInMilliseconds,
      reverseDurationInMilliseconds:
          reverseDurationInMilliseconds ?? this.reverseDurationInMilliseconds,
      customRouteOpaque: customRouteOpaque ?? this.customRouteOpaque,
      customRouteBarrierDismissible:
          customRouteBarrierDismissible ?? this.customRouteBarrierDismissible,
      transitionBuilder: transitionBuilder ?? this.transitionBuilder,
    );
  }
}
