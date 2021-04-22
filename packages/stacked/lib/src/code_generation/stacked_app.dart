import 'package:stacked/src/code_generation/stacked_locator_annotations.dart';
import 'package:stacked/src/code_generation/stacked_logger_annotations.dart';
import 'package:stacked/src/code_generation/stacked_router_annotations.dart';

/// The annotation that defines a stacked application
class StackedApp {
  /// Defines all the routes that has to be generated for the onGenerateRoute function
  final List<StackedRoute> routes;

  /// Defines a list of services to be registered on the locator for use in the app
  final List<DependencyRegistration>? dependencies;

  /// Defines the logger to be generated in the app
  final StackedLogger? logger;

  const StackedApp({
    required this.routes,
    this.dependencies,
    this.logger,
  });
}
