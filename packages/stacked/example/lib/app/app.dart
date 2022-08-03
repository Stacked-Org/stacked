import 'package:example/services/epoch_service.dart';
import 'package:example/services/factory_service.dart';
import 'package:example/services/information_service.dart';
import 'package:example/ui/bottom_nav/bottom_nav_example.dart';
import 'package:example/ui/bottom_nav/favorites/favorites_view.dart';
import 'package:example/ui/bottom_nav/favorites/favorites_viewmodel.dart';
import 'package:example/ui/bottom_nav/history/history_view.dart';
import 'package:example/ui/bottom_nav/history/history_viewmodel.dart';
import 'package:example/ui/bottom_nav/profile/profile_view.dart';
import 'package:example/ui/bottomsheets/generic_bottomsheet.dart';
import 'package:example/ui/details/details_view.dart';
import 'package:example/ui/form/example_form_view.dart';
import 'package:example/ui/home/home_view.dart';
import 'package:example/ui/multiple_futures_example/multiple_futures_example_view.dart';
import 'package:example/ui/nonreactive/nonreactive_view.dart';
import 'package:example/ui/stream_view/stream_counter_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../ui/dialogs/basic_dialog.dart';
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
      AdaptiveRoute(
        page: FavoritesView,
        children: [
          MaterialRoute(page: MultipleFuturesExampleView),
          CustomRoute(page: HistoryView),
        ],
      ),
      CustomRoute(page: HistoryView),
      CupertinoRoute(page: ProfileView),
    ]),
    MaterialRoute(page: StreamCounterView),
    CupertinoRoute<Map<String, List<String>>?>(page: DetailsView),
    // TODO: Change the name of the FormView to avoid type clashing
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
    // LazySingleton(
    //   classType: InformationService,
    //   dispose: disposeInformationService,
    // ),
    LazySingleton(
        classType: NavigationService,
        environments: {Environment.dev},
        instanceName: 'instance1'),
    LazySingleton(classType: EpochService),
    LazySingleton(
      classType: ThemeService,
      resolveUsing: ThemeService.getInstance,
    ),
    LazySingleton(classType: InformationService, instanceName: 'infoInstance1'),
    FactoryWithParam(classType: FactoryService),
    // singletons
    Singleton(classType: HistoryViewModel),
    Singleton(classType: FavoritesViewModel),
  ],
  logger: StackedLogger(),
  locatorName: 'exampleLocator',
  locatorSetupName: 'setupExampleLocator',
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
