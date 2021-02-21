import 'package:stacked_generator/src/generators/getit/service_config.dart';

/// Describes the configuration of a service to be registered with get_it
class ServicesConfig {
  /// A list of services to be registered with the get_it locator
  final List<ServiceConfig> services;

  ServicesConfig({this.services});
}
