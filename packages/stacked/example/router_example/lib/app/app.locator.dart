// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/navigation/router_service.dart';
import 'package:stacked_themes/src/theme_service.dart';

import '../services/epoch_service.dart';
import '../services/factory_service.dart';
import '../services/information_service.dart';
import '../ui/bottom_nav/favorites/favorites_viewmodel.dart';
import '../ui/bottom_nav/history/history_viewmodel.dart';
import 'app.router.dart';

final exampleLocator = StackedLocator.instance;

Future<void> setupExampleLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
  StackedRouterWeb? stackedRouter,
}) async {
// Register environments
  exampleLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  exampleLocator.registerLazySingleton(() => DialogService());
  exampleLocator.registerLazySingleton(() => BottomSheetService());
  exampleLocator.registerLazySingleton(() => RouterService());
  if (stackedRouter == null) {
    throw Exception(
        'Stacked is building to use the Router (Navigator 2.0) navigation but no stackedRouter is supplied. Pass the stackedRouter to the setupLocator function in main.dart');
  }

  exampleLocator<RouterService>().setRouter(stackedRouter);

  exampleLocator.registerLazySingleton(() => NavigationService(),
      registerFor: {"dev"}, instanceName: 'instance1');
  exampleLocator.registerLazySingleton(() => EpochService());
  exampleLocator.registerLazySingleton(() => ThemeService.getInstance());
  exampleLocator.registerLazySingleton(() => InformationService());
  exampleLocator.registerLazySingleton(() => InformationService(),
      instanceName: 'infoInstance1');
  exampleLocator.registerFactoryParam<FactoryService, String?, double?>(
      (param1, param2) => FactoryService(param1, data2: param2));
  exampleLocator.registerSingleton(HistoryViewModel());
  exampleLocator.registerSingleton(FavoritesViewModel());
}
