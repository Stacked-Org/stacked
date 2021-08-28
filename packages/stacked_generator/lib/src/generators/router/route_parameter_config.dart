import 'package:analyzer/dart/element/element.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/utils.dart';

final pathParamChecker = TypeChecker.fromRuntime(PathParam);
final queryParamChecker = TypeChecker.fromRuntime(QueryParam);

/// holds constructor parameter info to be used
/// in generating route parameters.
class RouteParamConfig {
  final String? type;
  final String? name;
  final String? alias;
  final bool isPositional;
  final bool isRequired;
  final bool? isPathParam;
  final bool? isQueryParam;
  final String? defaultValueCode;
  final Set<String>? imports;

  RouteParamConfig({
    this.type,
    this.name,
    this.alias,
    this.isPositional = false,
    this.isRequired = false,
    this.isPathParam,
    this.isQueryParam,
    this.defaultValueCode,
    this.imports,
  });

  String get getterName {
    switch (type) {
      case 'String':
        return 'getString';
      case 'int':
        return 'getInt';
      case 'double':
        return 'getDouble';
      case 'num':
        return 'getNum';
      case 'bool':
        return 'getBool';
      case 'String?':
        return 'optString';
      case 'int?':
        return 'optInt';
      case 'double?':
        return 'optDouble';
      case 'num?':
        return 'optNum';
      case 'bool?':
        return 'optBool';
      default:
        return 'value';
    }
  }

  String? get paramName => alias ?? name;
}

class RouteParameterResolver {
  final ImportResolver _importResolver;
  final Set<String> imports = {};

  RouteParameterResolver(this._importResolver);

  Future<RouteParamConfig> resolve(ParameterElement parameterElement) async {
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
        type: toDisplayString(paramType, withNullability: true),
        name: parameterElement.name.replaceFirst("_", ''),
        alias: paramAlias,
        isPositional: parameterElement.isPositional,
        isRequired: !parameterElement.isOptional,
        isPathParam: pathParam,
        isQueryParam: isQuery,
        defaultValueCode: parameterElement.defaultValueCode,
        imports: _importResolver.resolveAll(paramType));
  }
}
