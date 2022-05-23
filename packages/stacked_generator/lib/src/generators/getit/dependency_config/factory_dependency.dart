import 'dependency_config.dart';
import 'package:stacked_generator/src/generators/extensions/environments_extract_extension.dart';
import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';

class FactoryDependency extends DependencyConfig {
  const FactoryDependency({
    required String import,
    required String className,
    String? abstractedImport,
    String? abstractedTypeClassName,
    Set<String>? environments,
  }) : super(
            import: import,
            className: className,
            abstractedImport: abstractedImport,
            abstractedTypeClassName: abstractedTypeClassName,
            environments: environments);

  @override
  String registerDependencies(String locatorName) {
    return '$locatorName.registerFactory${abstractedTypeClassName.surroundWithAngleBracketsOrReturnEmptyIfNull}(() => $className()  ${environments.getFromatedEnvs});';
  }
}
