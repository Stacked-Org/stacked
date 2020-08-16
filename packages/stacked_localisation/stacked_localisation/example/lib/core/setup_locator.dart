import 'package:get_it/get_it.dart';
import 'package:stacked_localisation/stacked_localisation.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  var localisationService = LocalisationService();
  await localisationService.initialise();
  locator.registerSingleton(localisationService);

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
}
