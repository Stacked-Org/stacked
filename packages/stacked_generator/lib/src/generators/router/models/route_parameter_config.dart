import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart' as _dartType;
import 'package:code_builder/code_builder.dart';
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
  final String? defaultValueCode;
  final bool isOptional;
  final bool isNamed;

  RouteParamConfig({
    required this.type,
    required this.name,
    this.isOptional = false,
    this.isNamed = false,
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
    if (paramType is _dartType.FunctionType) {
      return _resolveFunctionType(parameterElement);
    }
    var type = _typeResolver.resolveType(paramType);

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
      type: type,
      isNamed: parameterElement.isNamed,
      name: parameterElement.name.replaceFirst("_", ''),
      alias: paramAlias,
      isPositional: parameterElement.isPositional,
      isRequired: !parameterElement.isOptional,
      isPathParam: pathParam,
      isQueryParam: isQuery,
      isOptional: parameterElement.isOptional,
      defaultValueCode: parameterElement.defaultValueCode,
    );
  }

  RouteParamConfig _resolveFunctionType(ParameterElement parameterElement) {
    print('_resolveFunctionType');
    var functionType = parameterElement.type as _dartType.FunctionType;
    return FunctionParamConfig(
        returnType: _typeResolver.resolveType(functionType.returnType),
        type: _typeResolver.resolveType(functionType),
        params: functionType.parameters.map(resolve).toList(),
        name: parameterElement.name,
        defaultValueCode: parameterElement.defaultValueCode,
        isRequired: parameterElement.isRequiredNamed,
        isPositional: parameterElement.isPositional,
        isOptional: parameterElement.isOptional,
        isNamed: parameterElement.isNamed);
  }
}

class FunctionParamConfig extends RouteParamConfig {
  final ResolvedType returnType;
  final List<RouteParamConfig> params;
  FunctionParamConfig({
    required this.returnType,
    required this.params,
    required super.type,
    required super.name,
    super.alias,
    super.isPositional,
    super.isRequired,
    super.isPathParam = false,
    super.isQueryParam = false,
    super.defaultValueCode,
    super.isOptional,
    super.isNamed,
  });

  List<RouteParamConfig> get requiredParams =>
      params.where((p) => p.isPositional && !p.isOptional).toList();

  List<RouteParamConfig> get optionalParams =>
      params.where((p) => p.isPositional && p.isOptional).toList();

  List<RouteParamConfig> get namedParams =>
      params.where((p) => p.isNamed).toList(growable: false);

  FunctionType get funRefer => FunctionType((b) => b
    ..returnType = returnType.refer
    ..requiredParameters.addAll(requiredParams.map((e) => e.type.refer))
    ..optionalParameters.addAll(optionalParams.map((e) => e.type.refer))
    ..isNullable = type.isNullable
    ..namedParameters.addAll(
      {}..addEntries(namedParams.map(
          (e) => MapEntry(e.name, e.type.refer),
        )),
    ));
}
