import 'package:stacked_shared/src/code_generation/bottomsheets/stacked_bottomsheet.dart';
import 'package:stacked_shared/src/code_generation/dialogs/stacked_dialog.dart';

import 'locator/stacked_locator_annotations.dart';
import 'logger/stacked_logger_annotations.dart';
import 'router/stacked_router_annotations.dart';

/// The annotation that defines a stacked application
class StackedApp {
  /// Supply to the StackedApp annotation a locatorName. The default name will be "locator".
  final String locatorName;

  /// Supply the StackedApp annotation with a locatorSetupName. The default name will be setupLocator
  final String locatorSetupName;

  /// Defines all the routes that has to be generated for the onGenerateRoute function
  final List<StackedRoute> routes;

  /// Defines a list of services to be registered on the locator for use in the app
  final List<DependencyRegistration>? dependencies;

  /// Defines a list of dialogs to be registered using the setup_dialog_ui function
  final List<StackedDialog>? dialogs;

  /// Defines a list of bottomsheets to be registered using the setup_bottomsheet_ui function
  final List<StackedBottomsheet>? bottomsheets;

  /// Defines the logger to be generated in the app
  final StackedLogger? logger;

  const StackedApp({
    required this.routes,
    this.dialogs,
    this.bottomsheets,
    this.logger,
    this.dependencies,
    this.locatorName = 'locator',
    this.locatorSetupName = 'setupLocator',
  });
}
