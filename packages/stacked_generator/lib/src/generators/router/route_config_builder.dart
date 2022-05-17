import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';

import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/utils.dart';

class RouteConfigBuilder {
  final DartType dartType;
  final ImportResolver importResolver;
  final ConstantReader stackedRoute;
  final RouteConfig routeConfig;
  const RouteConfigBuilder({
    required this.dartType,
    required this.importResolver,
    required this.stackedRoute,
    required this.routeConfig,
  });

  ClassElement get classElement => dartType.element as ClassElement;

  RouteConfigBuilder addType(RouteConfig? globalRouteConfig) {
    if (stackedRoute.instanceOf(TypeChecker.fromRuntime(MaterialRoute))) {
      routeConfig.routeType = RouteType.material;
    } else if (stackedRoute
        .instanceOf(TypeChecker.fromRuntime(CupertinoRoute))) {
      routeConfig.routeType = RouteType.cupertino;
      routeConfig.cupertinoNavTitle = stackedRoute.peek('title')?.stringValue;
    } else if (stackedRoute
        .instanceOf(TypeChecker.fromRuntime(AdaptiveRoute))) {
      routeConfig.routeType = RouteType.adaptive;
      routeConfig.cupertinoNavTitle =
          stackedRoute.peek('cupertinoPageTitle')?.stringValue;
    } else if (stackedRoute.instanceOf(TypeChecker.fromRuntime(CustomRoute))) {
      routeConfig.routeType = RouteType.custom;
      routeConfig.durationInMilliseconds =
          stackedRoute.peek('durationInMilliseconds')?.intValue;
      routeConfig.reverseDurationInMilliseconds =
          stackedRoute.peek('reverseDurationInMilliseconds')?.intValue;
      routeConfig.customRouteOpaque = stackedRoute.peek('opaque')?.boolValue;
      routeConfig.customRouteBarrierDismissible =
          stackedRoute.peek('barrierDismissible')?.boolValue;
      final function = stackedRoute
          .peek('transitionsBuilder')
          ?.objectValue
          .toFunctionValue();
      if (function != null) {
        final displayName = function.displayName.replaceFirst(RegExp('^_'), '');
        final functionName = function.isStatic
            ? '${function.enclosingElement.displayName}.$displayName'
            : displayName;

        var import;
        if (function.enclosingElement.name != 'TransitionsBuilders') {
          import = importResolver.resolve(function);
        }
        routeConfig.transitionBuilder =
            CustomTransitionBuilder(functionName, import);
      }
    } else {
      routeConfig.routeType =
          globalRouteConfig?.routeType ?? RouteType.material;
      if (globalRouteConfig?.routeType == RouteType.custom) {
        routeConfig.transitionBuilder = globalRouteConfig?.transitionBuilder;
        routeConfig.durationInMilliseconds =
            globalRouteConfig?.durationInMilliseconds;
        routeConfig.reverseDurationInMilliseconds =
            globalRouteConfig?.reverseDurationInMilliseconds;
        routeConfig.customRouteBarrierDismissible =
            globalRouteConfig?.customRouteBarrierDismissible;
        routeConfig.customRouteOpaque = globalRouteConfig?.customRouteOpaque;
      }
    }
    return this;
  }

  RouteConfigBuilder addImports() {
    final import = importResolver.resolve(classElement);
    if (import != null) {
      routeConfig.imports.add(import);
    }
    return this;
  }

  RouteConfigBuilder addClassName() {
    routeConfig.className = toDisplayString(dartType);
    return this;
  }

  RouteConfigBuilder checkIfNotClassElement() {
    throwIf(
      dartType.element is! ClassElement,
      '${toDisplayString(dartType)} is not a class element',
      element: dartType.element!,
    );
    return this;
  }

  RouteConfigBuilder addPathName(String? routeNamePrefix) {
    var path = stackedRoute.peek('path')?.stringValue;
    if (path == null) {
      if (stackedRoute.peek('initial')?.boolValue == true) {
        path = '/';
      } else {
        path = '$routeNamePrefix${toKababCase(routeConfig.className!)}';
      }
    }
    routeConfig.pathName = path;
    return this;
  }

  RouteConfigBuilder addFullScreenDialog() {
    routeConfig.fullscreenDialog =
        stackedRoute.peek('fullscreenDialog')?.boolValue;
    return this;
  }

  RouteConfigBuilder addMaintainState() {
    routeConfig.maintainState = stackedRoute.peek('maintainState')?.boolValue;
    return this;
  }

  RouteConfigBuilder addGuards() {
    stackedRoute
        .peek('guards')
        ?.listValue
        .map((g) => g.toTypeValue())
        .forEach((guard) {
      if (guard != null && guard.element != null) {
        routeConfig.guards.add(RouteGuardConfig(
            type: toDisplayString(guard),
            import: importResolver.resolve((guard.element)!)));
      }
    });
    return this;
  }

  RouteConfigBuilder addReturnTypeAndIfNotDynamicAddAddtionalImports() {
    final returnType = stackedRoute.objectValue.type;
    routeConfig.returnType = toDisplayString(returnType!);
    if (routeConfig.returnType != 'dynamic') {
      routeConfig.imports.addAll(importResolver.resolveAll(returnType));
    }
    return this;
  }

  RouteConfigBuilder addName() {
    routeConfig.name = stackedRoute.peek('name')?.stringValue ??
        toLowerCamelCase(routeConfig.className!);
    return this;
  }

  RouteConfigBuilder setHasWrapper() {
    routeConfig.hasWrapper = classElement.allSupertypes
        .map<String>((el) => toDisplayString(el))
        .contains('StackedRouteWrapper');
    return this;
  }

  Future<RouteConfigBuilder> addParameters() async {
    final constructor = classElement.unnamedConstructor;

    var params = constructor?.parameters;
    if (params?.isNotEmpty == true) {
      if (constructor!.isConst &&
          params!.length == 1 &&
          toDisplayString(params.first.type) == 'Key') {
        routeConfig.hasConstConstructor = true;
      } else {
        final paramResolver = RouteParameterResolver(importResolver);
        routeConfig.parameters = [];
        for (ParameterElement p in constructor.parameters) {
          routeConfig.parameters?.add(await paramResolver.resolve(p));
        }
      }
    }
    return this;
  }
}
