// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:new_architecture/services/cloud_storage_service.dart';
import 'package:new_architecture/services/dialog_service.dart';
import 'package:new_architecture/services/epoch_service.dart';
import 'package:new_architecture/services/firebase_authentication.dart';
import 'package:new_architecture/services/information_service.dart';
import 'package:new_architecture/services/shared_preferences_services.dart';
import 'package:new_architecture/manager/authentication_manager.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<CloudStorageService>(() => CloudStorageService());
  g.registerLazySingleton<DialogService>(() => DialogService());
  g.registerLazySingleton<EpochService>(() => EpochService());
  g.registerLazySingleton<FirebaseAuthentication>(
      () => FirebaseAuthentication());
  g.registerLazySingleton<InformationService>(() => InformationService());
  g.registerLazySingleton<SharedPreferencesServices>(
      () => SharedPreferencesServices());
  g.registerLazySingleton<AuthenticationManager>(() => AuthenticationManager(
      g<FirebaseAuthentication>(), g<CloudStorageService>()));
}
