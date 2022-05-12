import 'dependency_config.dart';
import 'package:stacked_generator/src/generators/extensions/environments_extract_extension.dart';

class PresolveSingletonDependency extends DependencyConfig {
  /// The static function to use for presolving the service
  final String? presolveFunction;

  const PresolveSingletonDependency({
    required String import,
    required String className,
    String? abstractedImport,
    String? abstractedTypeClassName,
    Set<String>? environments,
    this.presolveFunction,
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

    return '''
        final $camelCaseClassName = await $className.$presolveFunction();
        $locatorName.registerSingleton$abstractionType($camelCaseClassName  ${environments.getFromatedEnvs});
        ''';
  }
}
