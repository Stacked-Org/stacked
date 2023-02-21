import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/route_config_resolver.dart';

import '../route_allocator.dart';
import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';

class ArgumentClassBuilderHelper {
  final RouteConfig route;

  const ArgumentClassBuilderHelper(this.route);

  String get argumentClassName => route.parentClassName != null
      ? 'Nested${route.argumentsHolderClassName}'
      : route.argumentsHolderClassName;

  List<Field> get convertParametersToClassFields {
    return route.parameters
        .map((param) => Field(
              (b) => b
                ..modifier = FieldModifier.final$
                ..name = param.name
                ..type = param is FunctionParamConfig
                    ? param.funRefer
                    : param.type.refer,
            ))
        .toList();
  }

  String get convertArgumentsToMap {
    Map<String, dynamic> obj = {};

    for (RouteParamConfig param in route.parameters) {
      obj['"${param.name}"'] = '"\$${param.name}"';
    }

    return obj.toString();
  }

  Constructor get argumentConstructer {
    return Constructor((b) => _composeConstructer(b));
  }

  void _composeConstructer(ConstructorBuilder b) {
    b.constant = true;

    for (final param in route.parameters) {
      // Add the name and the default value
      final codeBuilderParameter = Parameter((parameterBuilder) {
        parameterBuilder
          ..name = param.name
          ..toThis = true
          ..named = true;

        // Assign default value
        if (param.defaultValueCode != null) {
          parameterBuilder.defaultTo = refer(
            param.defaultValueCode!,
            _processDefaultValueCodeImport(param),
          ).code;
        }

        // Add required keyword
        if (param.isRequired || param.isPositional) {
          parameterBuilder.required = true;
        }
      });
      b.optionalParameters.add(codeBuilderParameter);
    }
  }

  /// Note: I didn't use this function in [NavigatorExtension] cause the import
  /// will be dublicated
  String? _processDefaultValueCodeImport(RouteParamConfig param) {
    final defaultImport = param.type.import;

    /// If defaultValueCode already has an import return it
    if (defaultImport != null) return defaultImport;

    /// If import is null check if any of the children arguments have imports
    /// we use the first cause normally they all have the same import
    final childArgumentsImport = param.type.typeArguments.isNotEmpty
        ? param.type.typeArguments.first.import
        : null;

    /// Add [kFlagToPreventAliasingTheImport] string to mark this import to not
    /// be aliased
    return childArgumentsImport + kFlagToPreventAliasingTheImport;
  }
}
