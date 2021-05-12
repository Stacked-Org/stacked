// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../services/epoch_service.dart';
import '../services/information_service.dart';
import '../ui/bottom_nav/favorites/favorites_viewmodel.dart';
import '../ui/bottom_nav/history/history_viewmodel.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => InformationService());
  locator
      .registerLazySingleton(() => NavigationService(), registerFor: {"dev"});
  locator.registerLazySingleton(() => EpochService());
  locator.registerLazySingleton(() => ThemeService.getInstance());
  locator.registerSingleton(HistoryViewModel());
  locator.registerSingleton(FavoritesViewModel());
}
