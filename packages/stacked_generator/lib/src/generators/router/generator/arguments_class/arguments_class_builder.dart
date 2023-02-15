import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/utils.dart';

import '../../route_config/route_config.dart';
import 'argument_class_builder_helper.dart';

class ArgumentsClassBuilder {
  final List<RouteConfig> routes;

  const ArgumentsClassBuilder({required this.routes});

  Iterable<Class> buildViewsArguments() {
    final routesWithParameters = routes.where(
      (route) => notQueryNorPath(route.parameters).isNotEmpty,
    );

    return routesWithParameters.map((route) {
      final argumentsBuilderHelper = ArgumentClassBuilderHelper(route);

      final parametersAsString =
          argumentsBuilderHelper.convertParametersToStrings.toString();

      return Class(
        (b) => b
          ..name = argumentsBuilderHelper.argumentClassName
          ..fields.addAll(argumentsBuilderHelper.convertParametersToClassFields)
          ..constructors.add(argumentsBuilderHelper.argumentConstructer)
          ..methods.add(
            Method.returnsVoid(
              (b) => b
                ..name = 'getParametersAsString'
                ..body = Code('return $parametersAsString'),
            ),
          ),
      );
    });
  }
}
