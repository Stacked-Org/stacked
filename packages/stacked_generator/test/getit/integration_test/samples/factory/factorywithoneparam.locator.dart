// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked_core/stacked_core.dart';

import '../../../../helpers/dumb_service.dart';

final factoryWithOneParamLocator = StackedLocator.instance;

Future<void> setupFactoryWithOneParamLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  factoryWithOneParamLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  factoryWithOneParamLocator.registerFactoryParam<
      DumpServiceWithOneParam,
      String?,
      dynamic>((param1, param2) => DumpServiceWithOneParam(name: param1));
}
