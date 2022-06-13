import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/utils.dart';

import 'models/route_guard_config.dart';
import 'models/route_parameter_config.dart';
import 'route_config/route_config.dart';

const TypeChecker stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

// extracts route configs from class fields
class RouteConfigResolver {
  final String? routeNamePrefex;
  final ImportResolver _importResolver;

  const RouteConfigResolver(
    this.routeNamePrefex,
    this._importResolver,
  );

  Future<RouteConfig> resolve(ConstantReader stackedRoute,
      {bool isChild = false}) async {
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
        pathName = '${routeNamePrefex}${toKababCase(className)}';
      }
    }

    final returnType = stackedRoute.objectValue.type;

    var baseRouteConfig = RouteConfig(
      hasWrapper: classElement.allSupertypes
          .map<String>((el) => toDisplayString(el))
          .contains('StackedRouteWrapper'),
      returnType: toDisplayString(returnType!),
      pathName: pathName,
      name:
          stackedRoute.peek('name')?.stringValue ?? toLowerCamelCase(className),
      maintainState: stackedRoute.peek('maintainState')?.boolValue ?? true,
      imports: imports,
      guards: extractedGuards ?? [],
      className: className,
      fullscreenDialog:
          stackedRoute.peek('fullscreenDialog')?.boolValue ?? false,
      isChild: isChild,
    );

    /// Check if a return type is provided for example [MaterialRoute<int>()]
    /// and adds the import for that type other wise is will default to dynamic which
    /// doesn't needs an import
    if (baseRouteConfig.processedReturnType != 'dynamic') {
      imports.addAll(_importResolver.resolveAll(returnType));
    }

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
          baseRouteConfig = baseRouteConfig.copyWith(parameters: [
            ...baseRouteConfig.parameters,
            paramResolver.resolve(p)
          ]);
        }
      }
    }
    return baseRouteConfig.toSpecificType(stackedRoute, _importResolver);
  }
}
