import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/utils.dart';

const _factoryParamChecker = TypeChecker.fromRuntime(FactoryParam);

class DependencyParamConfig {
  final String? type;
  final String? name;
  final String? alias;
  final bool isPositional;
  final bool isRequired;
  final String? defaultValueCode;
  final Set<String>? imports;
  final bool isFactoryParam;

  DependencyParamConfig({
    this.type,
    this.name,
    this.alias,
    this.isFactoryParam = false,
    this.isPositional = false,
    this.isRequired = false,
    this.defaultValueCode,
    this.imports,
  });
}

class DependencyParameterResolver {
  final ImportResolver _importResolver;
  final Set<String> imports = {};

  DependencyParameterResolver(this._importResolver);

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
