import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/views/first_screen.dart';
import '../ui/views/home_screen.dart';
import '../ui/views/second_screen.dart';

@StackedApp(
  dependencies: [
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
  ],
  routes: [
    MaterialRoute(
      page: HomeScreen,
      name: 'homeScreenRoute',
      initial: true,
    ),
    MaterialRoute(
      page: FirstScreen,
      name: 'firstScreenRoute',
    ),
    MaterialRoute(
      page: SecondScreen,
      name: 'secondScreenRoute',
    ),
  ],
)
class App extends StackedApp {}
