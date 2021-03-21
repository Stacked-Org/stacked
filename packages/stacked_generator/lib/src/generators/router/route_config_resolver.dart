import 'package:analyzer/dart/element/element.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/utils.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

// extracts route configs from class fields
class RouteConfigResolver {
  final RouterConfig _routerConfig;
  final ImportResolver _importResolver;

  RouteConfigResolver(this._routerConfig, this._importResolver);

  Future<RouteConfig> resolve(ConstantReader stackedRoute) async {
    final routeConfig = RouteConfig();
    final type = stackedRoute.read('page').typeValue;
    
    final classElement = type.element as ClassElement;

    final import = _importResolver.resolve(classElement);
    if (import != null) {
      routeConfig.imports.add(import);
    }
    routeConfig.className = toDisplayString(type);
    var path = stackedRoute.peek('path')?.stringValue;
    if (path == null) {
      if (stackedRoute.peek('initial')?.boolValue == true) {
        path = '/';
      } else {
        path =
            '${_routerConfig.routeNamePrefix}${toKababCase(routeConfig.className)}';
      }
    }
    routeConfig.pathName = path;

    throwIf(
      type.element is! ClassElement,
      '${toDisplayString(type)} is not a class element',
      element: type.element,
    );

    await _extractRouteMetaData(routeConfig, stackedRoute);

    routeConfig.name = stackedRoute.peek('name')?.stringValue ??
        toLowerCamelCase(routeConfig.className);

    routeConfig.hasWrapper = classElement.allSupertypes
        .map<String>((el) => toDisplayString(el))
        .contains('StackedRouteWrapper');

    final constructor = classElement.unnamedConstructor;

    var params = constructor?.parameters;
    if (params?.isNotEmpty == true) {
      if (constructor.isConst &&
          params.length == 1 &&
          toDisplayString(params.first.type) == 'Key') {
        routeConfig.hasConstConstructor = true;
      } else {
        final paramResolver = RouteParameterResolver(_importResolver);
        routeConfig.parameters = [];
        for (ParameterElement p in constructor.parameters) {
          routeConfig.parameters.add(await paramResolver.resolve(p));
        }
      }
    }
    // _validatePathParams(routeConfig, classElement);
    return routeConfig;
  }

  Future<void> _extractRouteMetaData(
      RouteConfig routeConfig, ConstantReader stackedRoute) async {
    routeConfig.fullscreenDialog =
        stackedRoute.peek('fullscreenDialog')?.boolValue;
    routeConfig.maintainState = stackedRoute.peek('maintainState')?.boolValue;

    stackedRoute
        .peek('guards')
        ?.listValue
        ?.map((g) => g.toTypeValue())
        ?.forEach((guard) {
      routeConfig.guards.add(RouteGuardConfig(
          type: toDisplayString(guard),
          import: _importResolver.resolve(guard.element)));
    });

    final returnType = stackedRoute.objectValue.type.typeArguments.first;
    routeConfig.returnType = toDisplayString(returnType);

    if (routeConfig.returnType != 'dynamic') {
      routeConfig.imports.addAll(_importResolver.resolveAll(returnType));
    }

    if (stackedRoute.instanceOf(TypeChecker.fromRuntime(MaterialRoute))) {
      routeConfig.routeType = RouteType.material;
    } else if (stackedRoute.instanceOf(TypeChecker.fromRuntime(CupertinoRoute))) {
      routeConfig.routeType = RouteType.cupertino;
      routeConfig.cupertinoNavTitle = stackedRoute.peek('title')?.stringValue;
    } else if (stackedRoute.instanceOf(TypeChecker.fromRuntime(AdaptiveRoute))) {
      routeConfig.routeType = RouteType.adaptive;
      routeConfig.cupertinoNavTitle =
          stackedRoute.peek('cupertinoPageTitle')?.stringValue;
    } else if (stackedRoute.instanceOf(TypeChecker.fromRuntime(CustomRoute))) {
      routeConfig.routeType = RouteType.custom;
      routeConfig.durationInMilliseconds =
          stackedRoute.peek('durationInMilliseconds')?.intValue;
      routeConfig.customRouteOpaque = stackedRoute.peek('opaque')?.boolValue;
      routeConfig.customRouteBarrierDismissible =
          stackedRoute.peek('barrierDismissible')?.boolValue;
      final function =
          stackedRoute.peek('transitionsBuilder')?.objectValue?.toFunctionValue();
      if (function != null) {
        final displayName = function.displayName.replaceFirst(RegExp('^_'), '');
        final functionName = (function.isStatic &&
                function.enclosingElement?.displayName != null)
            ? '${function.enclosingElement.displayName}.$displayName'
            : displayName;

        var import;
        if (function.enclosingElement?.name != 'TransitionsBuilders') {
          import = _importResolver.resolve(function);
        }
        routeConfig.transitionBuilder =
            CustomTransitionBuilder(functionName, import);
      }
    } else {
      var globConfig = _routerConfig.globalRouteConfig;
      routeConfig.routeType = globConfig.routeType;
      if (globConfig.routeType == RouteType.custom) {
        routeConfig.transitionBuilder = globConfig.transitionBuilder;
        routeConfig.durationInMilliseconds = globConfig.durationInMilliseconds;
        routeConfig.customRouteBarrierDismissible =
            globConfig.customRouteBarrierDismissible;
        routeConfig.customRouteOpaque = globConfig.customRouteOpaque;
      }
    }
  }
}
