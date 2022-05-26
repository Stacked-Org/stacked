import 'package:analyzer/dart/element/element.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/utils.dart';

import 'router_config.dart';

const TypeChecker stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

// extracts route configs from class fields
class RouteConfigResolver {
  final RouterConfig _routerConfig;
  final ImportResolver _importResolver;

  const RouteConfigResolver(this._routerConfig, this._importResolver);

  Future<RouteConfig> resolve(ConstantReader stackedRoute) async {
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
          import: _importResolver.resolve((guard.element)!));
    }).toList();

    final classElement = dartType.element as ClassElement;
    final className = toDisplayString(dartType);

    final import = _importResolver.resolve(classElement);
    if (import != null) imports.add(import);

    String? pathName = stackedRoute.peek('path')?.stringValue;
    if (pathName == null) {
      if (stackedRoute.peek('initial')?.boolValue == true) {
        pathName = '/';
      } else {
        pathName = '${_routerConfig.routeNamePrefix}${toKababCase(className)}';
      }
    }

    final returnType = stackedRoute.objectValue.type;

    if (returnType != null && returnType != 'dynamic') {
      imports.addAll(_importResolver.resolveAll(returnType));
    }

    var baseRouteConfig = RouteConfig(
        hasWrapper: classElement.allSupertypes
            .map<String>((el) => toDisplayString(el))
            .contains('StackedRouteWrapper'),
        returnType: toDisplayString(returnType!),
        pathName: pathName,
        name: stackedRoute.peek('name')?.stringValue ??
            toLowerCamelCase(className),
        maintainState: stackedRoute.peek('maintainState')?.boolValue ?? true,
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
        baseRouteConfig = baseRouteConfig.copyWith(hasConstConstructor: true);
      } else {
        final paramResolver = RouteParameterResolver(_importResolver);
        for (ParameterElement p in constructor.parameters) {
          baseRouteConfig.copyWith(parameters: [
            ...baseRouteConfig.parameters,
            paramResolver.resolve(p)
          ]);
        }
      }
    }
    return baseRouteConfig.toSpecificType(stackedRoute, _importResolver);
  }
}
