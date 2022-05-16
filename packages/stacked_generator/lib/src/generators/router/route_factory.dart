import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';

import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/utils.dart';

class RouteFactory {
  final DartType dartType;
  final ImportResolver importResolver;
  final String? routeNamePrefix;
  final ConstantReader stackedRoute;
  final RouteConfig routeConfig;
  final RouteConfig? globalRouteConfig;
  const RouteFactory({
    required this.dartType,
    required this.importResolver,
    required this.routeNamePrefix,
    required this.stackedRoute,
    required this.routeConfig,
    this.globalRouteConfig,
  });

  RouteConfig build() {
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
  }

  addImports() {
    final classElement = dartType.element as ClassElement;

    final import = importResolver.resolve(classElement);
    if (import != null) {
      routeConfig.imports.add(import);
    }
  }

  addClassName() {
    routeConfig.className = toDisplayString(dartType);
  }

  checkIfNotClassElement() {
    throwIf(
      dartType.element is! ClassElement,
      '${toDisplayString(dartType)} is not a class element',
      element: dartType.element!,
    );
  }

  setPath() {
    var path = stackedRoute.peek('path')?.stringValue;
    if (path == null) {
      if (stackedRoute.peek('initial')?.boolValue == true) {
        path = '/';
      } else {
        path = '$routeNamePrefix${toKababCase(routeConfig.className!)}';
      }
    }
    routeConfig.pathName = path;
  }

  setFullScreenDialog() {
    routeConfig.fullscreenDialog =
        stackedRoute.peek('fullscreenDialog')?.boolValue;
  }

  setMaintainState() {
    routeConfig.maintainState = stackedRoute.peek('maintainState')?.boolValue;
  }

  setGuards() {
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
  }

  setReturnType() {
    final returnType = stackedRoute.objectValue.type;
    routeConfig.returnType = toDisplayString(returnType!);
  }

  addAdditionalImports() {
    final returnType = stackedRoute.objectValue.type;
    if (routeConfig.returnType != 'dynamic') {
      routeConfig.imports.addAll(importResolver.resolveAll(returnType!));
    }
  }

  setName() {
    routeConfig.name = stackedRoute.peek('name')?.stringValue ??
        toLowerCamelCase(routeConfig.className!);
  }

  hasWrapper() {
    final classElement = dartType.element as ClassElement;

    routeConfig.hasWrapper = classElement.allSupertypes
        .map<String>((el) => toDisplayString(el))
        .contains('StackedRouteWrapper');
  }

  Future<void> setParameter() async {
    final classElement = dartType.element as ClassElement;

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
  }
}
