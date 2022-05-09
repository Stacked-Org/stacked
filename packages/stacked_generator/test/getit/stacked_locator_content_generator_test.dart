import 'package:stacked_generator/src/generators/enums/dependency_type.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config.dart';
import 'package:stacked_generator/src/generators/getit/dependency_param_config.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';
import 'package:stacked_generator/src/generators/getit/stacked_locator_content_generator.dart';
import 'package:test/test.dart';

import '../helpers/getit_constants.dart';

void main() {
  group('StackedLocatorContentGeneratorTest -', () {
    group('generate -', () {
      void callGeneratorWithServicesConfigAndExpectResult(
          ServicesConfig servicesConfig, dynamic expectedResult,
          {String? locatorName, String? locatorSetupName}) {
        final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
            servicesConfig: servicesConfig,
            locatorName: locatorName ?? 'filledstacksLocator',
            locatorSetupName:
                locatorSetupName ?? 'filledstacksLocatorSetupName');
        expect(stackedLocaterContentGenerator.generate(), expectedResult);
      }

      void callGeneratorWithServicesConfigAndExpectException(
          ServicesConfig servicesConfig, dynamic expectedResult) {
        final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
            servicesConfig: servicesConfig,
            locatorName: 'filledstacksLocator',
            locatorSetupName: 'filledstacksLocatorSetupName');
        expect(() => stackedLocaterContentGenerator.generate(), expectedResult);
      }

      test('with one dependency ', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              params: {DependencyParamConfig()})
        ]);
        callGeneratorWithServicesConfigAndExpectResult(
            servicesConfig, kStackedLocaterWithOneDependencyOutput,
            locatorName: 'ebraLocator',
            locatorSetupName: 'ebraLocatorSetupName');
      });
      test('with two dependencies', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              params: {DependencyParamConfig()}),
          DependencyConfig(
              import: 'importTwo',
              className: 'FireService',
              params: {DependencyParamConfig()})
        ]);

        callGeneratorWithServicesConfigAndExpectResult(
            servicesConfig, kStackedLocaterWithTwoDependenciesOutput);
      });
      test('with two dependencies and added DependencyParamConfig imports', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              params: {
                DependencyParamConfig(imports: {
                  'importsSetOne',
                  'importsSetTwo',
                })
              }),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(
            servicesConfig, kStackedLocaterWithOneDependencyOutputWithImports);
      });

      test('with one dependency that has abstractedImport', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              abstractedImport: 'abstractedImportOne',
              params: {DependencyParamConfig()}),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
            kStackedLocaterWithOneDependencyOutputWithAbstractedImport);
      });
      test('with one dependency that has abstractedTypeClassName', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              abstractedTypeClassName: 'abstractedTypeClassNamee',
              params: {DependencyParamConfig()}),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
            kStackedLocaterWithOneDependencyOutputWithAbstractedTypeClassName);
      });
      test('with one dependency that has environments', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              environments: {'dev', 'prod'},
              params: {DependencyParamConfig()}),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
            kStackedLocaterWithOneDependencyOutputWithEnviroments);
      });
      test(
          'with one dependency that has presolveFunction and type = DependencyType.PresolvedSingleton',
          () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              type: DependencyType.PresolvedSingleton,
              import: 'importOne',
              className: 'GeolocaorService',
              presolveFunction: 'staticPresolveFunction',
              params: {DependencyParamConfig()}),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
            kStackedLocaterWithOneDependencyOutputWithPresolveFunctionAndDependencyTypePresolvedSingleton);
      });
      test(
          'with one dependency that has presolveFunction and [type=DependencyType.Factory]',
          () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              type: DependencyType.Factory,
              import: 'importOne',
              className: 'GeolocaorService',
              params: {DependencyParamConfig()}),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
            kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactory);
      });
      test('''
with one dependency that has [type=DependencyType.FactoryWithParams] and params is null
, Should throw a null exception''', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
            type: DependencyType.FactoryWithParam,
            import: 'importOne',
            className: 'GeolocaorService',
          ),
        ]);

        callGeneratorWithServicesConfigAndExpectException(
            servicesConfig, throwsA(isA<TypeError>()));
      });
      test('''
with one dependency that has [type=DependencyType.FactoryWithParams] and params isempty
, Should throw a InvalidGeneratorInputException''', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              type: DependencyType.FactoryWithParam,
              import: 'importOne',
              className: 'GeolocaorService',
              params: {}),
        ]);

        callGeneratorWithServicesConfigAndExpectException(
            servicesConfig, throwsA(isA<InvalidGeneratorInputException>()));
      });
    });
  });
}
