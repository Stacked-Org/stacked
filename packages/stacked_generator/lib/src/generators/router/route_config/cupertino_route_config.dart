import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen/src/constants/reader.dart';

import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/router/router_config.dart';

import '../../../../utils.dart';
import '../router_config.dart';

class CupertinoRouteConfig extends RouteConfig {
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

  final String? cupertinoNavTitle;

  const CupertinoRouteConfig({
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
  factory CupertinoRouteConfig.fromStackedApp(ConstantReader stackedRoute,
      ImportResolver importResolver, RouterConfig routerConfig) {
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

    var cupertinoRouteConfig = CupertinoRouteConfig(
        cupertinoNavTitle: stackedRoute.peek('title')?.stringValue,
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
        cupertinoRouteConfig =
            cupertinoRouteConfig.copyWith(hasConstConstructor: true);
      } else {
        final paramResolver = RouteParameterResolver(importResolver);
        for (ParameterElement p in constructor.parameters) {
          cupertinoRouteConfig.copyWith(parameters: [
            ...?cupertinoRouteConfig.parameters,
            paramResolver.resolve(p)
          ]);
        }
      }
    }
    return cupertinoRouteConfig;
  }

  CupertinoRouteConfig copyWith({
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
    String? cupertinoNavTitle,
  }) {
    return CupertinoRouteConfig(
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
      cupertinoNavTitle: cupertinoNavTitle ?? this.cupertinoNavTitle,
    );
  }
}
