// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedGetItGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/shared_preferences_service.dart';

final locator = GetIt.instance;

Future setupLocator() async {
  final sharedPreferencesService = await SharedPreferencesService.getInstance();
  locator.registerSingleton(sharedPreferencesService);

  locator.registerSingleton(NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerFactory(() => BottomSheetService());
}
