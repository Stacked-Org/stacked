import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_app/ui/views/home/home_view.dart';
import 'package:stacked_app/ui/views/startup/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: StartupView),
  MaterialRoute(page: HomeView),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: BottomSheetService),
])
class App {}
