import 'package:stacked_generator/src/generators/enums/serivce_type.dart';

class ServiceConfig {
  /// The import to use for the type of the service
  final String import;

  /// The actual name of the class to be registered
  final String className;

  /// The type of the service to register
  final ServiceType type;

  ServiceConfig({
    this.import,
    this.className,
    this.type,
  });
}
