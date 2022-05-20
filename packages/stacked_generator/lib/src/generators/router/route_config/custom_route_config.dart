import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/router_config.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen/src/constants/reader.dart';

import 'package:stacked_generator/import_resolver.dart';
import '../../../../utils.dart';
import '../router_config.dart';

class CustomRouteConfig extends RouteConfig {
  final int? durationInMilliseconds;
  final int? reverseDurationInMilliseconds;
  final bool customRouteOpaque;
  final bool customRouteBarrierDismissible;
  final CustomTransitionBuilder? transitionBuilder;
  final String? cupertinoNavTitle;

  /// super constructed fields
  final String name;
  final String pathName;
  final String className;
  final bool fullscreenDialog;
  final bool maintainState;
  final String? returnType;
  final List<RouteParamConfig>? parameters;
  final List<RouteGuardConfig> guards;
  final bool hasWrapper;
  final bool hasConstConstructor;
  final RouterConfig? routerConfig;
  final Set<String> imports;
  CustomRouteConfig({
    required this.name,
    required this.pathName,
    required this.className,
    this.fullscreenDialog = false,
    this.maintainState = false,
    this.returnType,
    this.parameters,
    this.guards = const [],
    this.hasWrapper = false,
    this.hasConstConstructor = false,
    this.routerConfig,
    this.imports = const {},
    this.durationInMilliseconds,
    this.reverseDurationInMilliseconds,
    this.customRouteOpaque = false,
    this.customRouteBarrierDismissible = false,
    this.transitionBuilder,
    this.cupertinoNavTitle,
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
  String registerImports() {
    return "package:stacked/stacked.dart";
  }

  // TODO: move this code to the routeconfig super class
  factory CustomRouteConfig.fromStackedApp(
    ConstantReader stackedRoute,
    ImportResolver importResolver,
    RouterConfig routerConfig,
  ) {
    final dartType = stackedRoute.read('page').typeValue;
    throwIf(
      dartType.element is! ClassElement,
      '${toDisplayString(dartType)} is not a class element',
      element: dartType.element!,
    );
    Set<String> imports = {};

    final extractedGuards = stackedRoute.peek('guards')?.listValue.where((g) {
      final guard = g.toTypeValue();
      return guard != null && guard.element != null;
    }).map((g) {
      final guard = g.toTypeValue();
      return RouteGuardConfig(
          type: toDisplayString(guard!),
          import: importResolver.resolve((guard.element)!));
    }).toList();

    final classElement = dartType.element as ClassElement;
    final className = toDisplayString(dartType);

    final import = importResolver.resolve(classElement);
    if (import != null) imports.add(import);

    String? pathName = stackedRoute.peek('path')?.stringValue;
    if (pathName == null) {
      if (stackedRoute.peek('initial')?.boolValue == true) {
        pathName = '/';
      } else {
        pathName = '${routerConfig.routeNamePrefix}${toKababCase(className)}';
      }
    }

    final returnType = stackedRoute.objectValue.type;

    if (returnType != null && returnType != 'dynamic') {
      imports.addAll(importResolver.resolveAll(returnType));
    }

    var customRouteConfig = CustomRouteConfig(
        durationInMilliseconds:
            stackedRoute.peek('durationInMilliseconds')?.intValue,
        reverseDurationInMilliseconds:
            stackedRoute.peek('reverseDurationInMilliseconds')?.intValue,
        customRouteOpaque: stackedRoute.peek('opaque')?.boolValue ?? false,
        customRouteBarrierDismissible:
            stackedRoute.peek('barrierDismissible')?.boolValue ?? false,
        hasWrapper: classElement.allSupertypes
            .map<String>((el) => toDisplayString(el))
            .contains('StackedRouteWrapper'),
        returnType: toDisplayString(returnType!),
        pathName: pathName,
        name: stackedRoute.peek('name')?.stringValue ??
            toLowerCamelCase(className),
        maintainState: stackedRoute.peek('maintainState')?.boolValue ?? false,
        imports: imports,
        guards: extractedGuards ?? [],
        className: className,
        fullscreenDialog:
            stackedRoute.peek('fullscreenDialog')?.boolValue ?? false);
    final constructor = classElement.unnamedConstructor;

    var params = constructor?.parameters;
    if (params?.isNotEmpty == true) {
      if (constructor!.isConst &&
          params!.length == 1 &&
          toDisplayString(params.first.type) == 'Key') {
        customRouteConfig =
            customRouteConfig.copyWith(hasConstConstructor: true);
      } else {
        final paramResolver = RouteParameterResolver(importResolver);
        for (ParameterElement p in constructor.parameters) {
          customRouteConfig.copyWith(parameters: [
            ...?customRouteConfig.parameters,
            paramResolver.resolve(p)
          ]);
        }
      }
    }

    final function =
        stackedRoute.peek('transitionsBuilder')?.objectValue.toFunctionValue();
    if (function != null) {
      final displayName = function.displayName.replaceFirst(RegExp('^_'), '');
      final functionName = function.isStatic
          ? '${function.enclosingElement.displayName}.$displayName'
          : displayName;

      var import;
      if (function.enclosingElement.name != 'TransitionsBuilders') {
        import = importResolver.resolve(function);
      }
      customRouteConfig = customRouteConfig.copyWith(
          transitionBuilder: CustomTransitionBuilder(functionName, import));
    }
    return customRouteConfig;
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
    RouterConfig? routerConfig,
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
      cupertinoNavTitle: cupertinoNavTitle ?? this.cupertinoNavTitle,
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
