import 'package:stacked_generator/utils.dart';
import 'package:stacked_generator/src/generators/extensions/environments_extract_extension.dart';
import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';

import 'dependency_config.dart';

class FactoryParamDependency extends DependencyConfig {
  /// A set of parameters that are passed to the factory function.
  final Set<FactoryParameter>? params;

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
  String registerDependencies(String locatorName) {
    final factoryParamList = params?.where((element) => element.isFactoryParam);
    throwIf(
      factoryParamList?.isEmpty ?? true,
      "At least one paramter is requerd for FactoryWithParam registration ",
    );
    throwIf(
      factoryParamList!.length > 2,
      "Max number of factory params supported by get_it is 2",
    );

    final Set<String> constructorParams = {};
    final List<String> constructorParamTypes = [];
    factoryParamList.toList().asMap().forEach((index, paramConfig) {
      throwIf(
        !paramConfig.type!.contains("?"),
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
    if (factoryParamList.length == 1) {
      constructorParamTypes.add('dynamic');
    }

    final constructerParams = constructorParams.join(',');
    final constructerParamtypes = constructorParamTypes.join(',');

    return '$locatorName.registerFactoryParam<$className,$constructerParamtypes>${abstractedTypeClassName.surroundWithAngleBracketsOrReturnEmptyIfNull}((param1, param2) => $className($constructerParams)  ${environments.getFromatedEnvs});';
  }
}

class FactoryParameter {
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

  const FactoryParameter({
    this.type,
    this.name,
    this.isFactoryParam = false,
    this.isPositional = false,
    this.isRequired = false,
    this.defaultValueCode,
    this.imports,
  }) : assert(isFactoryParam == false || type != null);
}
