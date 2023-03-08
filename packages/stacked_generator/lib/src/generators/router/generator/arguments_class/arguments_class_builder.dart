import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';
import 'package:stacked_generator/utils.dart';

import 'argument_class_builder_helper.dart';

class ArgumentsClassBuilder {
  final List<RouteConfig> routes;

  const ArgumentsClassBuilder({required this.routes});

  Iterable<Class> buildViewsArguments(DartEmitter emitter) {
    final routesWithParameters = routes.where(
      (route) => notQueryNorPath(route.parameters).isNotEmpty,
    );

    return routesWithParameters.map((route) {
      final argumentsBuilderHelper = ArgumentClassBuilderHelper(route);

      final argumentsAsMap = argumentsBuilderHelper.convertArgumentsToMap;

      return Class(
        (b) => b
          ..name = argumentsBuilderHelper.argumentClassName
          ..fields.addAll(argumentsBuilderHelper.convertParametersToClassFields)
          ..constructors
              .add(argumentsBuilderHelper.argumentConstructer(emitter))
          ..methods.addAll([
            Method(
              (b) => b
                ..annotations.add(refer('override'))
                ..name = 'toString'
                ..body = Code("return '$argumentsAsMap';")
                ..returns = TypeReference(
                  (b) => b..symbol = 'String',
                ),
            ),
          ]),
      );
    });
  }
}
