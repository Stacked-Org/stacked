import 'package:new_architecture/services/shared_preferences_service.dart';
import 'package:new_architecture/ui/bottom_nav/bottom_nav_example.dart';
import 'package:new_architecture/ui/home/home_view.dart';
import 'package:new_architecture/ui/stream_view/stream_counter_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeView, initial: true),
  MaterialRoute(page: BottomNavExample),
  MaterialRoute(page: StreamCounterView),
], services: [
  Presolve(
    service: SharedPreferencesService,
    presolveUsing: SharedPreferencesService.getInstance,
  ),
  Singleton(service: NavigationService),
  LazySingleton(service: DialogService),
  Factory(service: BottomSheetService),
])
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
