import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/utils.dart';
import 'dependency_param_config.dart';

const _factoryParamChecker = TypeChecker.fromRuntime(FactoryParam);

class DependencyParameterResolver {
  final ImportResolver _importResolver;

  const DependencyParameterResolver(this._importResolver);

  DependencyParamConfig resolve(ParameterElement parameterElement) {
    final paramType = parameterElement.type;

    final isFactoryParam =
        _factoryParamChecker.hasAnnotationOfExact(parameterElement);

    return DependencyParamConfig(
      isFactoryParam: isFactoryParam,
      type: toDisplayString(paramType, withNullability: true),
      name: parameterElement.name.replaceFirst("_", ''),
      isPositional: parameterElement.isPositional,
      isRequired: !parameterElement.isOptional,
      defaultValueCode: parameterElement.defaultValueCode,
      imports: _importResolver.resolveAll(paramType),
    );
  }
}
