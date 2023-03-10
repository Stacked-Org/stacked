import 'package:stacked_shared/stacked_shared.dart';

import '../../../../helpers/dumb_service.dart';

@StackedApp(
  routes: [],
  dependencies: [
    FactoryWithParam(
      classType: DumpServiceWithOneParam,
    ),
  ],
  locatorName: 'FactoryWithOneParamLocator',
  locatorSetupName: 'setupFactoryWithOneParamLocator',
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
