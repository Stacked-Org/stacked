import 'package:stacked/stacked_annotations.dart';
import 'package:playground/ui/views/home/home_view.dart';
import 'package:playground/ui/views/startup/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';

// @stacked-import

@StackedApp(routes: [
  MaterialRoute(page: StartupView),
  MaterialRoute(page: HomeView),

// @stacked-route
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: BottomSheetService),
])
class App {}
