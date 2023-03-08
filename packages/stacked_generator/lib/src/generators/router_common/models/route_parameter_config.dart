import 'package:analyzer/dart/element/element.dart' show ParameterElement;
import 'package:code_builder/code_builder.dart' as code;

import 'importable_type.dart';

const reservedVarNames = ['children'];

const validPathParamTypes = [
  'String',
  'int',
  'double',
  'num',
  'bool',
  'dynamic'
];

/// holds constructor parameter info to be used
/// in generating route parameters.

class ParamConfig {
  final ResolvedType type;
  final String name;
  final String? alias;
  final bool isPositional;
  final bool isOptional;
  final bool hasRequired;
  final bool isRequired;
  final bool isNamed;
  final bool isPathParam;
  final bool isQueryParam;
  final String? defaultValueCode;
  final ParameterElement? element;
  final bool isInheritedPathParam;

  ParamConfig({
    required this.type,
    required this.name,
    this.element,
    this.isNamed = true,
    this.isPositional = false,
    this.hasRequired = false,
    this.isOptional = true,
    this.isRequired = false,
    this.isPathParam = false,
    this.isQueryParam = false,
    this.isInheritedPathParam = false,
    this.alias,
    this.defaultValueCode,
  });

  String get getterName {
    switch (type) {
      default:
        return 'value';
    }
  }

  String get paramName => alias ?? name;

  String getSafeName() {
    if (reservedVarNames.contains(name)) {
      return "${name}0";
    } else {
      return name;
    }
  }

  String get getterMethodName {
    switch (type.name) {
      case 'String':
        return type.isNullable ? 'optString' : 'getString';
      case 'int':
        return type.isNullable ? 'optInt' : 'getInt';
      case 'double':
        return type.isNullable ? 'optDouble' : 'getDouble';
      case 'num':
        return type.isNullable ? 'optNum' : 'getNum';
      case 'bool':
        return type.isNullable ? 'optBool' : 'getBool';
      default:
        return 'get';
    }
  }
}

class FunctionParamConfig extends ParamConfig {
  final ResolvedType returnType;
  final List<ParamConfig> params;

  FunctionParamConfig({
    required this.returnType,
    this.params = const [],
    required super.type,
    required super.name,
    super.alias,
    required super.isPositional,
    required super.hasRequired,
    required super.isOptional,
    required super.isNamed,
    required super.element,
    required bool isRequired,
    super.defaultValueCode,
  }) : super(
          isPathParam: false,
          isQueryParam: false,
          isRequired: isRequired,
          isInheritedPathParam: false,
        );

  List<ParamConfig> get requiredParams =>
      params.where((p) => p.isPositional && !p.isOptional).toList();

  List<ParamConfig> get optionalParams =>
      params.where((p) => p.isPositional && p.isOptional).toList();

  List<ParamConfig> get namedParams =>
      params.where((p) => p.isNamed).toList(growable: false);

  code.FunctionType get funRefer => code.FunctionType((b) => b
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

class PathParamConfig {
  final String name;
  final bool isOptional;

  const PathParamConfig({required this.name, required this.isOptional});
}
