import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_hooks_example/ui/views/home/home_view.dart';
import 'package:stacked_hooks_example/ui/views/startup/startup_view.dart';
import 'package:stacked_hooks_example/ui/views/with_stacked_hook/with_stacked_hook_view.dart';
import 'package:stacked_hooks_example/ui/views/without_stacked_hook/without_stacked_hook_view.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(routes: [
  MaterialRoute(page: StartupView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: WithStackedHookView),
  MaterialRoute(page: WithoutStackedHookView),
// @stacked-route
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: BottomSheetService),
  // @stacked-service
])
class App {}
