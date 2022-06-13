import '../models/custom_transition_builder.dart';
import '../models/route_guard_config.dart';
import '../models/route_parameter_config.dart';
import 'route_config.dart';

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
  final List<RouteConfig> children;
  final bool hasConstConstructor;
  final Set<String> imports;
  final bool isChild;
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
    this.isChild = false,
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
          isChild: isChild,
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
      stringBuffer.write(
          'transitionsBuilder: data.transition ?? ${transitionBuilder!.name},');
    }
    if (transitionBuilder == null) {
      stringBuffer.write('''transitionsBuilder: data.transition??
              (context, animation, secondaryAnimation, child) {
            return child;
          }''');
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
    bool? isChild,
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
      isChild: isChild ?? this.isChild,

    );
  }
}
