import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';
import 'package:stacked_generator/src/generators/router_2/code_builder/route_info_builder.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_config.dart';
import 'package:stacked_generator/src/generators/router_common/models/route_parameter_config.dart';
import 'package:stacked_generator/utils.dart';

class NavigateExtensionClassBuilderHelper {
  Iterable<Method> buildNavigateToExtensionMethods(
    List<RouteConfig> routes,
    DartEmitter emitter,
  ) {
    return [
      ...routes.map<Method>(
          (route) => extractNavigateToMethodFromRoute(route, emitter)),
      ...routes.map<Method>(
          (route) => extractReplaceWithMethodFromRoute(route, emitter)),
    ];
  }

  Method extractNavigateToMethodFromRoute(
          RouteConfig route, DartEmitter emitter) =>
      _extractNavigationMethod(
        navigationMethod: 'navigateTo',
        route: route,
        emitter: emitter,
      );

  Method extractReplaceWithMethodFromRoute(
          RouteConfig route, DartEmitter emitter) =>
      _extractNavigationMethod(
        navigationMethod: 'replaceWith',
        route: route,
        emitter: emitter,
      );

  Method _extractNavigationMethod({
    required String navigationMethod,
    required RouteConfig route,
    required DartEmitter emitter,
  }) {
    final methodName = route.parentClassName != null
        ? '${navigationMethod}Nested${route.name?.capitalize}In${route.parentClassName}'
        : '$navigationMethod${route.name?.capitalize}';

    final methodReturnType = route.isProcessedReturnTypeDynamic
        ? route.processedReturnType
        : '${route.processedReturnType}?';

    final viewArgumentsParameter = notQueryNorPath(route.parameters)
        .map((parameter) => _extractViewArgumentsParametrs(parameter, emitter));

    return Method((b) => b
      ..name = methodName
      ..modifier = MethodModifier.async
      ..returns = Reference('Future<$methodReturnType>')
      ..optionalParameters
          .addAll([...viewArgumentsParameter, ..._constParameters])
      ..body = _body(
        route: route,
        methodReturnType: methodReturnType,
        navigationMethod: navigationMethod,
      ));
  }

  /// The arguments provided to the view
  Parameter _extractViewArgumentsParametrs(
      ParamConfig param, DartEmitter emitter) {
    return Parameter((parameterBuilder) {
      parameterBuilder
        ..name = param.name
        ..type =
            param is FunctionParamConfig ? param.funRefer : param.type.refer
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
  }

  /// These are the parameters that exists on every call
  ///
  /// int? routerId,
  /// bool preventDuplicates = true,
  /// Map<String, String>? parameters,
  /// Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  List<Parameter> get _constParameters => [
        Parameter((b) => b
          ..name = 'routerId'
          ..type = const Reference('int?')),
        Parameter((b) => b
          ..name = 'preventDuplicates'
          ..type = const Reference('bool')
          ..defaultTo = const Code('true')),
        Parameter((b) => b
          ..name = 'parameters'
          ..type = const Reference('Map<String, String>?')),
        Parameter(
          (b) => b
            ..name = 'transition'
            ..type = const Reference(
                'Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?'),
        )
      ];

  Code _body({
    required RouteConfig route,
    required String methodReturnType,
    required String navigationMethod,
  }) {
    final routesClassName = route.parentRouterConfig != null
        ? route.parentRouterConfig!.routesClassName
        : 'Routes';
    return Block.of([
      Code(
          'return $navigationMethod<$methodReturnType>($routesClassName.${route.name}, '),
      _assignArgumentClass(route),
      ..._constMethodBodyParameters,
    ]);
  }

  List<Code> get _constMethodBodyParameters => [
        const Code('id: routerId,'),
        const Code('preventDuplicates: preventDuplicates,'),
        const Code('parameters: parameters,'),
        const Code('transition: transition'),
        const Code(');'),
      ];

  Code _assignArgumentClass(RouteConfig route) {
    if (route.parameters.isNotEmpty) {
      final argumentClassName = route.parentClassName != null
          ? 'Nested${route.argumentsHolderClassName}'
          : route.argumentsHolderClassName;

      return Code(
          'arguments: $argumentClassName(${route.parameters.map((p) => '${p.name}: ${p.name}').join(',')}),');
    }
    return const Code('');
  }
}
