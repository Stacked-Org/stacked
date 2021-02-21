// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedGetItGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/epoch_service.dart';
import '../services/information_service.dart';
import '../services/shared_preferences_service.dart';
import '../ui/bottom_nav/favorites/favorites_viewmodel.dart';
import '../ui/bottom_nav/history/history_viewmodel.dart';

final locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => InformationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => EpochService());
  locator.registerSingleton(HistoryViewModel());
  locator.registerSingleton(FavoritesViewModel());
  final sharedPreferencesService = await SharedPreferencesService.getInstance();
  locator.registerSingleton(sharedPreferencesService);
}
