import 'package:code_builder/code_builder.dart';
import 'package:stacked_generator/route_config_resolver.dart';
import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';
import 'package:stacked_generator/utils.dart';
import 'package:collection/collection.dart';

class NavigateExtensionClassBuilderHelper {
  Iterable<Method> buildNavigateToExtensionMethods(List<RouteConfig> routes) {
    return routes.map<Method>(extractNavigationMethodFromRoute);
  }

  Method extractNavigationMethodFromRoute(RouteConfig route) {
    final methodName = route.parentClassName != null
        ? 'navigateToNested${route.className.key}In${route.parentClassName}'
        : 'navigateTo${route.className.key}';

    final methodReturnType = route.isProcessedReturnTypeDynamic
        ? route.processedReturnType
        : '${route.processedReturnType}?';

    final viewArgumentsParameter =
        notQueryNorPath(route.parameters).map(_extractViewArgumentsParametrs);
    return Method((b) => b
      ..name = methodName
      ..modifier = MethodModifier.async
      ..returns = Reference('Future<$methodReturnType>')
      ..optionalParameters
          .addAll([...viewArgumentsParameter, ..._constParameters])
      ..body = _body(route));
  }

  /// The arguments provided to the view
  Parameter _extractViewArgumentsParametrs(RouteParamConfig param) {
    return Parameter((parameterBuilder) {
      parameterBuilder
        ..name = param.name
        ..type = Reference(param.type, param.imports?.firstOrNull)
        ..named = true;

      // Assign default value
      if (param.defaultValueCode != null) {
        parameterBuilder..defaultTo = literal(param.defaultValueCode!).code;
      }

      // Add required keyword
      if (param.isRequired || param.isPositional) {
        parameterBuilder..required = true;
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
          ..type = Reference('int?')),
        Parameter((b) => b
          ..name = 'preventDuplicates'
          ..type = Reference('bool')
          ..defaultTo = Code('true')),
        Parameter((b) => b
          ..name = 'parameters'
          ..type = Reference('Map<String, String>?')),
        Parameter(
          (b) => b
            ..name = 'transition'
            ..type = Reference(
                'Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?'),
        )
      ];

  Code _body(RouteConfig route) {
    final routesClassName = route.parentClassName != null
        ? route.parentClassName! + 'Routes'
        : 'Routes';
    return Block.of([
      Code('navigateTo(${routesClassName}.${route.name}, '),
      _assignArgumentClass(route),
      ..._constMethodBodyParameters,
    ]);
  }

  List<Code> get _constMethodBodyParameters => [
        Code('id: routerId,'),
        Code('preventDuplicates: preventDuplicates,'),
        Code('parameters: parameters,'),
        Code('transition: transition'),
        Code(');'),
      ];

  Code _assignArgumentClass(RouteConfig route) {
    if (route.parameters.isNotEmpty) {
      final argumentClassName = route.parentClassName != null
          ? 'Nested' + route.argumentsHolderClassName
          : route.argumentsHolderClassName;

      return Code(
          'arguments: ${argumentClassName}(${route.parameters.map((p) => '${p.name}: ${p.name}').join(',')}),');
    }
    return Code('');
  }
}
