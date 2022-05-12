import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/factory_dependency.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/factory_param_dependency.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/lazy_singleton.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/presolve_singleton_dependency.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/singleton_dependency.dart';

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

      void callGeneratorWithServicesConfigAndExpectException<T>(
          ServicesConfig servicesConfig,
          [String? exceptionMessage]) {
        final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
            servicesConfig: servicesConfig,
            locatorName: 'filledstacksLocator',
            locatorSetupName: 'filledstacksLocatorSetupName');
        expect(
          () => stackedLocaterContentGenerator.generate(),
          throwsA(predicate<dynamic>((e) => e is T && exceptionMessage == null
              ? true
              : e.message == exceptionMessage)),
        );
      }

      group('PresolvedSingleton -', () {
        test(
            'with one DependencyConfig that has presolveFunction and type = DependencyType.PresolvedSingleton',
            () {
          final servicesConfig = ServicesConfig(services: [
            PresolveSingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
              presolveFunction: 'staticPresolveFunction',
            ),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithPresolveFunctionAndDependencyTypePresolvedSingleton);
        });
      });
      group('Factory -', () {
        test(
            'with one DependencyConfig that has presolveFunction and [type=DependencyType.Factory]',
            () {
          final servicesConfig = ServicesConfig(services: [
            FactoryDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactory);
        });
      });
      group('FactoryWithParam -', () {
        test('When params is null, Should throw a null exception', () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ]);

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(servicesConfig,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test(
            'When params isEmpty, Should throw a InvalidGeneratorInputException',
            () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
                import: 'importOne', className: 'GeolocaorService', params: {}),
          ]);

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(servicesConfig,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test('''
When params is not empty but DependencyParamConfig type is null
, Should throw a InvalidGeneratorInputException''', () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {DependencyParamConfig()}),
          ]);

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(servicesConfig,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test('''
When params is not empty and DependencyParamConfig type is empty,
, Should throw a InvalidGeneratorInputException that atleast one [DependencyParamConfig] 
needs to have isFactoryParam needs to be true''', () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {DependencyParamConfig(type: '')}),
          ]);

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(servicesConfig,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test('''
When params is not empty and DependencyParamConfig type doesn't have a question mark '?'
, Should throw a InvalidGeneratorInputException that factory needs to be nullable''',
            () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(servicesConfig,
              "Factory params must be nullable. Parameter null is not nullable");
        });
        test('''
When params is not empty and DependencyParamConfig type have a question mark '?'
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParams);
        });
        test('''
When params is not empty and DependencyParamConfig type is newType? and default value is shit
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    defaultValueCode: 'shit',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndDefaultValue);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig type is newType? and isPositional=true
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    isPositional: true,
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndIsPositionalIsTrue);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig type is newType? and default value is shit and isPositional=true
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    isPositional: true,
                    defaultValueCode: 'shit',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndDefaultValueIsshitAndIsPositionalIsTrue);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig type is newType? and name is hello
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    name: 'hello',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndIsNameIsHello);
        });
      });
      group('Singleton -', () {
        test('with one DependencyConfig ', () {
          final servicesConfig = ServicesConfig(services: [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            )
          ]);
          callGeneratorWithServicesConfigAndExpectResult(
              servicesConfig, kStackedLocaterWithOneDependencyOutput,
              locatorName: 'ebraLocator',
              locatorSetupName: 'ebraLocatorSetupName');
        });
        test('with two dependencies', () {
          final servicesConfig = ServicesConfig(services: [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
            SingletonDependency(
              import: 'importTwo',
              className: 'FireService',
            )
          ]);

          callGeneratorWithServicesConfigAndExpectResult(
              servicesConfig, kStackedLocaterWithTwoDependenciesOutput);
        });
        test('with two dependencies and added DependencyParamConfig imports',
            () {
          final servicesConfig = ServicesConfig(services: [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithImports);
        });

        test('with one DependencyConfig that has abstractedImport', () {
          final servicesConfig = ServicesConfig(services: [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
              abstractedImport: 'abstractedImportOne',
            ),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithAbstractedImport);
        });
        test('with one DependencyConfig that has abstractedTypeClassName', () {
          final servicesConfig = ServicesConfig(services: [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
              abstractedTypeClassName: 'abstractedTypeClassNamee',
            ),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithAbstractedTypeClassName);
        });
        test('with one DependencyConfig that has environments', () {
          final servicesConfig = ServicesConfig(services: [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
              environments: {'dev', 'prod'},
            ),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithEnviroments);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.Singleton],
 Should ignors all [params] DependencyParamConfig and generate the same code''',
            () {
          final servicesConfig = ServicesConfig(services: [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ]);

          final servicesConfigWithEmptyParams = ServicesConfig(services: [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeSinglton);
          callGeneratorWithServicesConfigAndExpectResult(
              servicesConfigWithEmptyParams,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeSinglton);
        });
      });
      group('LazySingleton -', () {
        test('''
with one DependencyConfig that has [type=DependencyType.LazySingleton],
 Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            LazySingletonDependency(
                import: 'importOne', className: 'GeolocaorService'),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeLazySinglton);
        });
      });
    });
  });
}
