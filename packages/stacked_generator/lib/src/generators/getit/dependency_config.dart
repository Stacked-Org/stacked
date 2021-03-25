import 'package:stacked_generator/src/generators/enums/dependency_type.dart';
import 'package:recase/recase.dart';

class DependencyConfig {
  /// The import to use for the type of the service
  final String import;

  /// The import to use for the abstracted service type
  final String? abstractedImport;

  /// The actual name of the class to be registered
  final String? className;

  /// The abstracted class name of the class to be registered
  final String? abstractedTypeClassName;

  /// The type of the service to register
  final DependencyType? type;

  /// The static function to use for presolving the service
  final String? presolveFunction;

  /// The static function to use for resolving a singleton instance
  final String? resolveFunction;

  DependencyConfig({
    required this.import,
    this.abstractedImport,
    this.className,
    this.abstractedTypeClassName,
    this.type,
    this.presolveFunction,
    this.resolveFunction,
  });

  /// Returns a camel case version o the [className]
  String get camelCaseClassName => ReCase(className).camelCase;
}
