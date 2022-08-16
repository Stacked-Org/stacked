import 'package:analyzer/dart/element/element.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/resolved_type.dart';
import 'package:stacked_generator/type_resolver.dart';

final pathParamChecker = TypeChecker.fromRuntime(PathParam);
final queryParamChecker = TypeChecker.fromRuntime(QueryParam);

/// holds constructor parameter info to be used
/// in generating route parameters.
class RouteParamConfig {
  final ResolvedType type;
  final String name;
  final String? alias;
  final bool isPositional;
  final bool isRequired;
  final bool? isPathParam;
  final bool? isQueryParam;
  // TODO: this support only [String] type for now, should make it dynamic
  final String? defaultValueCode;

  RouteParamConfig({
    required this.type,
    required this.name,
    this.alias,
    this.isPositional = false,
    this.isRequired = false,
    this.isPathParam,
    this.isQueryParam,
    this.defaultValueCode,
  });

  String get getterName {
    switch (type) {
      default:
        return 'value';
    }
  }

  String? get paramName => alias ?? name;
}

class RouteParameterResolver {
  final TypeResolver _typeResolver;
  final Set<String> imports = {};

  RouteParameterResolver(this._typeResolver);

  RouteParamConfig resolve(ParameterElement parameterElement) {
    final paramType = parameterElement.type;

    var pathParam = pathParamChecker.hasAnnotationOfExact(parameterElement);
    var paramAlias;
    if (pathParam) {
      paramAlias = pathParamChecker
          .firstAnnotationOf(parameterElement)
          ?.getField('name')
          ?.toStringValue();
    }
    var isQuery = queryParamChecker.hasAnnotationOfExact(parameterElement);
    if (isQuery) {
      paramAlias = queryParamChecker
          .firstAnnotationOf(parameterElement)
          ?.getField('name')
          ?.toStringValue();
    }

    return RouteParamConfig(
      type: _typeResolver.resolveType(paramType),
      name: parameterElement.name.replaceFirst("_", ''),
      alias: paramAlias,
      isPositional: parameterElement.isPositional,
      isRequired: !parameterElement.isOptional,
      isPathParam: pathParam,
      isQueryParam: isQuery,
      defaultValueCode: parameterElement.defaultValueCode,
    );
  }
}
