// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked_core/stacked_core.dart';

import '../../helpers/dumb_service.dart';

final singletonWithTypeLocator = StackedLocator.instance;

Future<void> setupSingletonWithTypeLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  singletonWithTypeLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  singletonWithTypeLocator
      .registerSingleton<AbstractDumpService>(DumpService());
}
