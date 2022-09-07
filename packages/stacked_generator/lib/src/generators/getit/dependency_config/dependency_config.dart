import 'package:recase/recase.dart';

abstract class DependencyConfig {
  /// The import to use for the type of the service
  final String import;

  /// The actual name of the class to be registered
  final String className;

  /// This is used when you want to register
  /// two implementation for the Same interface
  final String? instanceName;

  /// The import to use for the abstracted service type
  final String? abstractedImport;

  final Set<String>? environments;

  /// The abstracted class name of the class to be registered
  final String? abstractedTypeClassName;
  const DependencyConfig({
    required this.import,
    required this.className,
    this.abstractedImport,
    this.environments,
    this.instanceName,
    this.abstractedTypeClassName,
  });

  String registerDependencies(String locatorName);

  /// Returns a camel case version o the [className]
  String get camelCaseClassName => ReCase(className).camelCase;
}
