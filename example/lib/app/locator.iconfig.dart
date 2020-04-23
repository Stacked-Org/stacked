// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:new_architecture/services/epoch_service.dart';
import 'package:new_architecture/services/information_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<EpochService>(() => EpochService());
  g.registerLazySingleton<InformationService>(() => InformationService());
}
