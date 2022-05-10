// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked_core/stacked_core.dart';

import '../helpers/dumb_service.dart';

final factoryLocator = StackedLocator.instance;

void setupFactoryLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  factoryLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  factoryLocator.registerFactory(() => DumpService());
}
