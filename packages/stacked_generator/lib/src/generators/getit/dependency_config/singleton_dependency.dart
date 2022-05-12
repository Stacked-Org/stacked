import 'dependency_config.dart';
import 'package:stacked_generator/src/generators/extensions/environments_extract_extension.dart';

class SingletonDependency extends DependencyConfig {
  /// The static function to use for resolving a singleton instance
  final String? resolveFunction;

  const SingletonDependency({
    required String import,
    required String className,
    String? abstractedImport,
    String? abstractedTypeClassName,
    Set<String>? environments,
    this.resolveFunction,
  }) : super(
            import: import,
            className: className,
            abstractedImport: abstractedImport,
            abstractedTypeClassName: abstractedTypeClassName,
            environments: environments);

  @override
  String body(String locatorName) {
    final hasAbstratedType = abstractedTypeClassName != null;
    final abstractionType = hasAbstratedType ? '<abstractedTypeClassName>' : '';
    final hasResolveFunction = resolveFunction != null;
    final singletonInstanceToReturn =
        hasResolveFunction ? '$className.$resolveFunction()' : '$className()';
    return '$locatorName.registerSingleton$abstractionType($singletonInstanceToReturn  ${environments.getFromatedEnvs});';
  }
}
