import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';
import 'package:stacked_generator/src/generators/router/route_config/route_config_factory.dart';
import 'package:stacked_generator/type_resolver.dart';
import 'package:stacked_generator/utils.dart';

import 'models/route_parameter_config.dart';
import 'route_config/route_config.dart';

const TypeChecker stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

// extracts route configs from class fields
class RouteConfigResolver {
  final String? routeNamePrefex;
  final TypeResolver _typeResolver;

  const RouteConfigResolver(
    this.routeNamePrefex,
    this._typeResolver,
  );

  Future<RouteConfig> resolve(ConstantReader stackedRoute,
      {String? parentClassName}) async {
    final dartType = stackedRoute.read('page').typeValue;
    throwIf(
      dartType.element is! ClassElement,
      '${toDisplayString(dartType)} is not a class element',
      element: dartType.element!,
    );

    final classElement = dartType.element as ClassElement;
    final import = _typeResolver.resolveImport(classElement);
    final classNameWithImport = MapEntry(toDisplayString(dartType), import!);

    String? pathName = stackedRoute.peek('path')?.stringValue;
    if (pathName == null) {
      if (stackedRoute.peek('initial')?.boolValue == true) {
        pathName = '/';
      } else {
        pathName = '$routeNamePrefex${classNameWithImport.key.toKababCase}';
      }
    }

    final returnType = stackedRoute.objectValue.type;

    /// Check if a return type is provided for example [MaterialRoute<int>()]
    /// and adds the import for that type other wise is will default to dynamic which
    /// doesn't needs an import
    // if (processedReturnType(toDisplayString(returnType!)) != 'dynamic') {
    //   imports.addAll(_importResolver.resolveAll(returnType));
    // }

    final constructor = classElement.unnamedConstructor;

    var params = constructor?.parameters;

    bool hasConstConstructor = false;
    List<RouteParamConfig> parameters = [];
    if (params?.isNotEmpty == true) {
      if (constructor!.isConst &&
          params!.length == 1 &&
          toDisplayString(params.first.type) == 'Key') {
        hasConstConstructor = true;
      } else {
        final paramResolver = RouteParameterResolver(_typeResolver);
        for (ParameterElement p in constructor.parameters) {
          parameters.add(paramResolver.resolve(p));
        }
      }
    }
    return RouteConfigFactory(
            parentClassName: parentClassName,
            parameters: parameters,
            hasWrapper: classElement.allSupertypes
                .map<String>((el) => toDisplayString(el))
                .contains('StackedRouteWrapper'),
            returnType: toDisplayString(returnType!),
            pathName: pathName,
            name: stackedRoute.peek('name')?.stringValue ??
                toLowerCamelCase(classNameWithImport.key),
            maintainState:
                stackedRoute.peek('maintainState')?.boolValue ?? true,
            className: classNameWithImport,
            fullscreenDialog:
                stackedRoute.peek('fullscreenDialog')?.boolValue ?? false,
            hasConstConstructor: hasConstConstructor)
        .fromResolver(stackedRoute);
  }
}
