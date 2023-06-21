import 'package:example/services/epoch_service.dart';
import 'package:example/services/factory_service.dart';
import 'package:example/services/information_service.dart';
import 'package:example/services/native_actions_service.dart';
import 'package:example/services/shared_preferences_service.dart';
import 'package:example/ui/bottom_nav/bottom_nav_example.dart';
import 'package:example/ui/bottom_nav/favorites/favorites_view.dart';
import 'package:example/ui/bottom_nav/favorites/favorites_viewmodel.dart';
import 'package:example/ui/bottom_nav/history/history_view.dart';
import 'package:example/ui/bottom_nav/history/history_viewmodel.dart';
import 'package:example/ui/bottom_nav/profile/profile_view.dart';
import 'package:example/ui/bottomsheets/generic_bottomsheet.dart';
import 'package:example/ui/dialogs/basic_dialog.dart';
import 'package:example/ui/form/example_form_view.dart';
import 'package:example/ui/home/home_view.dart';
import 'package:example/ui/multiple_futures_example/multiple_futures_example_view.dart';
import 'package:example/ui/nonreactive/nonreactive_view.dart';
import 'package:example/ui/stream_view/stream_counter_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_shared/stacked_shared.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'custom_route_transition.dart';

@StackedApp(
  bottomsheets: [
    StackedBottomsheet(classType: GenericBottomSheet),
  ],
  dialogs: [
    StackedDialog(classType: BasicDialog),
  ],
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: BottomNavExample, children: [
      RedirectRoute(path: '', redirectTo: 'favorites'),
      AdaptiveRoute(
        path: 'favourites',
        page: FavoritesView,
        children: [
          MaterialRoute(page: MultipleFuturesExampleView),
          CustomRoute(page: HistoryView),
        ],
      ),
      CustomRoute(
        page: HistoryView,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      ),
      CupertinoRoute(page: ProfileView),
    ]),
    MaterialRoute(page: StreamCounterView),
    MaterialRoute(page: ExampleFormView),
    CustomRoute(
      page: NonReactiveView,
      transitionsBuilder: CustomRouteTransition.sharedAxis,
    ),
  ],
  dependencies: [
    // Lazy singletons
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(
      classType: RouterService,
    ),
    LazySingleton(
      classType: NavigationService,
      environments: {Environment.dev},
      instanceName: 'instance1',
    ),
    LazySingleton(classType: EpochService),
    LazySingleton(
      classType: ThemeService,
      resolveUsing: ThemeService.getInstance,
    ),
    LazySingleton(classType: InformationService),
    LazySingleton(classType: InformationService, instanceName: 'infoInstance1'),
    FactoryWithParam(classType: FactoryService),
    // Singletons
    Singleton(classType: HistoryViewModel),
    Singleton(classType: FavoritesViewModel),

    InitializableSingleton(classType: SharedPreferencesService),
    // Presolve(
    //   classType: SharedPreferencesService,
    //   presolveUsing: SharedPreferencesService.getInstance,
    // ),
    InitializableSingleton(classType: NativeActionsService),
    // Presolve(
    //   classType: NativeActionsService,
    //   presolveUsing: NativeActionsService.getInstance,
    // ),
  ],
  logger: StackedLogger(),
  locatorName: 'exampleLocator',
  locatorSetupName: 'setupExampleLocator',
)
class App {
  /// This class has no puporse besides housing the annotation that generates the required functionality
}
