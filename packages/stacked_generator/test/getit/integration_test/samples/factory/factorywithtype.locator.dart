// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked_core/stacked_core.dart';

import '../../../../helpers/dumb_service.dart';

final factorywithtypeLocator = StackedLocator.instance;

Future<void> setupFactorywithtypeLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  factorywithtypeLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  factorywithtypeLocator
      .registerFactory<AbstractDumpService>(() => DumpService());
}
