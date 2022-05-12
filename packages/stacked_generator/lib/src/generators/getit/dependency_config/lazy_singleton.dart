import 'dependency_config.dart';
import 'package:stacked_generator/src/generators/extensions/environments_extract_extension.dart';
import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';

class LazySingletonDependency extends DependencyConfig {
  /// The static function to use for resolving a singleton instance
  final String? resolveFunction;

  const LazySingletonDependency({
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
    final hasResolveFunction = resolveFunction != null;
    final singletonInstanceToReturn =
        hasResolveFunction ? '$className.$resolveFunction()' : '$className()';
    return '$locatorName.registerLazySingleton${abstractedTypeClassName.surroundWithAngleBracketsOrReturnEmptyIfNull}(() => $singletonInstanceToReturn ${environments.getFromatedEnvs});';
  }
}
