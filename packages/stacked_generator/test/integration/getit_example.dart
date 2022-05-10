import 'package:stacked_core/stacked_core.dart';

import 'services/geoService.dart';

@StackedApp(
  routes: [],
  dependencies: [
    LazySingleton(classType: GeoService),
  ],
  locatorName: 'exampleLocator',
  locatorSetupName: 'setupExampleLocator',
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
