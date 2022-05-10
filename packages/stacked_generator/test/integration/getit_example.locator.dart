// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked_core/stacked_core.dart';

import 'services/geoService.dart';

final exampleLocator = StackedLocator.instance;

void setupExampleLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  exampleLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  exampleLocator.registerLazySingleton(() => GeoService());
}
