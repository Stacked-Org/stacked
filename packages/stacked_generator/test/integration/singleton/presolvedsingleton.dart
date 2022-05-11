import 'package:stacked_core/stacked_core.dart';

import '../../helpers/dumb_service.dart';

@StackedApp(
  routes: [],
  dependencies: [
    Presolve(classType: DumpService, presolveUsing: DumpService.presolve),
  ],
  locatorName: 'PresolvedsingletonLocator',
  locatorSetupName: 'setupPresolvedsingletonLocator',
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
