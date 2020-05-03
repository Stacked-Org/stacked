// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:stacked_services/_dialog_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'asset:stacked_services/example/lib/services/thridparty_services_module.dart';
import 'package:stacked_services/_navigation_service.dart';
import 'package:stacked_services/_snackbar_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<DialogService>(() => DialogService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<NavigationService>(() => NavigationService());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigateionService);
  g.registerLazySingleton<SnackbarService>(() => SnackbarService());
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigateionService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
