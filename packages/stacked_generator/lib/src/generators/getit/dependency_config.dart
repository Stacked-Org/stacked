import 'package:stacked_generator/src/generators/enums/dependency_type.dart';
import 'package:recase/recase.dart';
import 'dependency_param_config.dart';

/// Todo: refactor  to use factories instead of this nonesense
/// for example the [params] is not needed unless DependencyType is FactoryWithParam
class DependencyConfig {
  /// The import to use for the type of the service
  @Deprecated(
      'Should removed in future, We already have imports from [DependencyParamConfig]')
  final String? import;

  /// The import to use for the abstracted service type
  final String? abstractedImport;

  /// The actual name of the class to be registered
  final String className;

  /// The abstracted class name of the class to be registered
  final String? abstractedTypeClassName;

  /// The type of the service to register
  final DependencyType? type;

  /// The static function to use for presolving the service
  final String? presolveFunction;

  /// The static function to use for resolving a singleton instance
  final String? resolveFunction;

  final Set<String>? environments;

  final Set<DependencyParamConfig>? params;

  DependencyConfig({
    this.type,
    this.params,
    this.environments,
    required this.import,
    required this.className,
    this.abstractedImport,
    this.abstractedTypeClassName,
    this.presolveFunction,
    this.resolveFunction,
  });

  /// Returns a camel case version o the [className]
  String get camelCaseClassName => ReCase(className).camelCase;
}
