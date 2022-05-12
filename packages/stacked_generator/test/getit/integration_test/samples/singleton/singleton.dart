import 'package:stacked_core/stacked_core.dart';

import '../../../../helpers/dumb_service.dart';

@StackedApp(
  routes: [],
  dependencies: [
    Singleton(classType: DumpService),
  ],
  locatorName: 'SingletonLocator',
  locatorSetupName: 'setupSingletonLocator',
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
