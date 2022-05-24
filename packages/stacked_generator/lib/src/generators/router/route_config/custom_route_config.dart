import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/router_config.dart';

import '../router_config.dart';

class CustomRouteConfig extends RouteConfig {
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
  final List<RouteConfig> children;
  final Set<String> imports;

  final int? durationInMilliseconds;
  final int? reverseDurationInMilliseconds;
  final bool customRouteOpaque;
  final bool customRouteBarrierDismissible;
  final CustomTransitionBuilder? transitionBuilder;
  CustomRouteConfig({
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
    this.children = const [],
    this.imports = const {},
    this.durationInMilliseconds,
    this.reverseDurationInMilliseconds,
    this.customRouteOpaque = true,
    this.customRouteBarrierDismissible = false,
    this.transitionBuilder,
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
          children: children,
        );
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
    int? durationInMilliseconds,
    int? reverseDurationInMilliseconds,
    bool? customRouteOpaque,
    bool? customRouteBarrierDismissible,
    CustomTransitionBuilder? transitionBuilder,
    String? cupertinoNavTitle,
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
    return CustomRouteConfig(
      durationInMilliseconds:
          durationInMilliseconds ?? this.durationInMilliseconds,
      reverseDurationInMilliseconds:
          reverseDurationInMilliseconds ?? this.reverseDurationInMilliseconds,
      customRouteOpaque: customRouteOpaque ?? this.customRouteOpaque,
      customRouteBarrierDismissible:
          customRouteBarrierDismissible ?? this.customRouteBarrierDismissible,
      transitionBuilder: transitionBuilder ?? this.transitionBuilder,
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
