import 'package:get_it/get_it.dart';
import 'package:stacked_localisation/stacked_localisation.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => LocalisationService());
  locator.registerLazySingleton(() => NavigationService());
}
