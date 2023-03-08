import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router_2/code_builder/route_info_builder.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_parameter_config.dart';

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

    for (ParamConfig param in route.parameters) {
      obj['"${param.name}"'] = '"\$${param.name}"';
    }

    return obj.toString();
  }

  Constructor argumentConstructer(DartEmitter emitter) {
    return Constructor((b) => _composeConstructer(b, emitter));
  }

  void _composeConstructer(
    ConstructorBuilder b,
    DartEmitter emitter,
  ) {
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
          parameterBuilder.defaultTo =
              buildCorrectDefaultCode(parameter: param, emitter: emitter);
        }

        // Add required keyword
        if (param.isRequired || param.isPositional) {
          parameterBuilder.required = true;
        }
      });
      b.optionalParameters.add(codeBuilderParameter);
    }
  }
}
