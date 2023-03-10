// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_shared/stacked_shared.dart';

import '../../../../helpers/dumb_service.dart';

final factoryWithTwoParamLocator = StackedLocator.instance;

Future<void> setupFactoryWithTwoParamLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  factoryWithTwoParamLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  factoryWithTwoParamLocator.registerFactoryParam<DumpServiceWithParams,
          String?, int?>(
      (param1, param2) => DumpServiceWithParams(name: param1, value: param2));
}
