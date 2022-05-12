import 'dependency_config.dart';
import 'package:stacked_generator/src/generators/extensions/environments_extract_extension.dart';

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
  String body(String locatorName) {
    final hasAbstratedType = abstractedTypeClassName != null;
    final abstractionType =
        hasAbstratedType ? '<$abstractedTypeClassName>' : '';

    return '$locatorName.registerFactory$abstractionType(() => $className()  ${environments.getFromatedEnvs});';
  }
}
