// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../services/epoch_service.dart';
import '../services/factory_service.dart';
import '../services/information_service.dart';
import '../ui/bottom_nav/favorites/favorites_viewmodel.dart';
import '../ui/bottom_nav/history/history_viewmodel.dart';

final exampleLocator = StackedLocator.instance;

Future<void> setupExampleLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  exampleLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  exampleLocator.registerLazySingleton(() => DialogService());
  exampleLocator.registerLazySingleton(() => BottomSheetService());
  exampleLocator
      .registerLazySingleton(() => NavigationService(), registerFor: {"dev"});
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
