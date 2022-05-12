import 'package:stacked_generator/utils.dart';
import 'package:stacked_generator/src/generators/extensions/environments_extract_extension.dart';

import 'dependency_config.dart';

class FactoryParamDependency extends DependencyConfig {
  /// A set of parameters that are passed to the factory function.
  final Set<DependencyParamConfig>? params;

  const FactoryParamDependency({
    required String import,
    required String className,
    String? abstractedImport,
    String? abstractedTypeClassName,
    Set<String>? environments,
    this.params,
  }) : super(
            import: import,
            className: className,
            abstractedImport: abstractedImport,
            abstractedTypeClassName: abstractedTypeClassName,
            environments: environments);
  Set<String> extraImports() {
    if (params == null) return {};
    return params!.map((e) => e.imports ?? {}).fold(
        {},
        (previousValue, element) => {
              ...previousValue,
              ...element,
            });
  }

  @override
  String body(String locatorName) {
    throwIf(
      params?.isEmpty ?? true,
      "At least one paramter is requerd for FactoryWithParam registration ",
    );
    throwIf(
      params!.length > 2,
      "Max number of factory params supported by get_it is 2",
    );

    final hasAbstratedType = abstractedTypeClassName != null;
    final abstractionType =
        hasAbstratedType ? '<$abstractedTypeClassName>' : '';
    final Set<String> constructorParams = {};
    final List<String> constructorParamTypes = [];
    this.params!.toList().asMap().forEach((index, paramConfig) {
      throwIf(
        paramConfig.type!.contains("?"),
        "Factory params must be nullable. Parameter ${paramConfig.name} is not nullable",
      );

      String getterName =
          "param${index + 1}${paramConfig.defaultValueCode != null ? ' ?? ${paramConfig.defaultValueCode}' : ''}";

      if (paramConfig.isPositional) {
        constructorParams.add(getterName);
      } else {
        constructorParams.add('${paramConfig.name}:$getterName');
      }

      constructorParamTypes.add('${paramConfig.type}');
    });
    if (this.params == 1) {
      constructorParamTypes.add('dynamic');
    }

    final constructerParams =
        constructorParams.toString().replaceAll(RegExp('[{}]'), '');
    final constructerParamtypes =
        constructorParamTypes.toString().replaceAll(RegExp(r'[\[\]]'), '');

    return '$locatorName.registerFactoryParam<$className,$constructerParamtypes>$abstractionType((param1, param2) => $className($constructerParams)  ${environments.getFromatedEnvs});';
  }
}

class DependencyParamConfig {
  /// Doesn't have an effect when isPositional=true
  final String? name;
  final bool isPositional;
  final bool isRequired;

  /// Can't figure out the perpose of this field
  final String? defaultValueCode;

  /// The required imports of the generated service
  final Set<String>? imports;

  /// Must contains a '?' mark(nullable type)
  final String? type;

  /// When set this to [true] make sure that [type] is not null
  final bool isFactoryParam;

  DependencyParamConfig({
    this.type,
    this.name,
    this.isFactoryParam = false,
    this.isPositional = false,
    this.isRequired = false,
    this.defaultValueCode,
    this.imports,
  }) : assert(isFactoryParam == false || type != null);
}
