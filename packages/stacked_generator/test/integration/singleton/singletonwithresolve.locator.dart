// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked_core/stacked_core.dart';

import '../../helpers/dumb_service.dart';

final singletonLocator = StackedLocator.instance;

void setupSingletonLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  singletonLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  singletonLocator.registerSingleton(DumpService.getInstance());
}
