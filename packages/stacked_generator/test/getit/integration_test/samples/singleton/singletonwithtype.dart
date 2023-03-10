import 'package:stacked_shared/stacked_shared.dart';

import '../../../../helpers/dumb_service.dart';

@StackedApp(
  routes: [],
  dependencies: [
    Singleton(
      classType: DumpService,
      asType: AbstractDumpService,
    ),
  ],
  locatorName: 'SingletonWithTypeLocator',
  locatorSetupName: 'setupSingletonWithTypeLocator',
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
