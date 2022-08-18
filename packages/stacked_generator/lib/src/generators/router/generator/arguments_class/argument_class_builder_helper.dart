import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/route_config_resolver.dart';

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

  Constructor get argumentConstructer {
    return Constructor((b) => _composeConstructer(b));
  }

  void _composeConstructer(ConstructorBuilder b) {
    b..constant = true;

    route.parameters.forEach((param) {
      // Add the name and the default value
      final codeBuilderParameter = Parameter((parameterBuilder) {
        parameterBuilder
          ..name = param.name
          ..toThis = true
          ..named = true;

        // Assign default value
        if (param.defaultValueCode != null) {
          parameterBuilder
            ..defaultTo =
                refer(param.defaultValueCode!, param.type.import).code;
        }

        // Add required keyword
        if (param.isRequired || param.isPositional) {
          parameterBuilder..required = true;
        }
      });
      b..optionalParameters.add(codeBuilderParameter);
    });
  }
}
