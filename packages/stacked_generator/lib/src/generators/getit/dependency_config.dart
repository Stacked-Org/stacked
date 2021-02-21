import 'package:stacked_generator/src/generators/enums/dependency_type.dart';
import 'package:recase/recase.dart';

class DependencyConfig {
  /// The import to use for the type of the service
  final String import;

  /// The actual name of the class to be registered
  final String className;

  /// The type of the service to register
  final DependencyType type;

  /// The static function to use for presolving the service
  final String presolveFunction;

  DependencyConfig({
    this.import,
    this.className,
    this.type,
    this.presolveFunction,
  });

  /// Returns a camel case version o the [className]
  String get camelCaseClassName => ReCase(className).camelCase;
}
