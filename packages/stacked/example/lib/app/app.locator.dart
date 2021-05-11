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
  final stacked = StackedLocator(
      environment: environment, environmentFilter: environmentFilter);
  stacked.registerLazySingleton(() => DialogService(), registerFor: {"dev"});
  stacked.registerLazySingleton(() => BottomSheetService());
  stacked.registerLazySingleton(() => InformationService());
  stacked.registerLazySingleton(() => NavigationService());
  stacked.registerLazySingleton(() => EpochService());
  stacked.registerLazySingleton(() => ThemeService.getInstance());
  stacked.registerSingleton(HistoryViewModel());
  stacked.registerSingleton(FavoritesViewModel());
}
