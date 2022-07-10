import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/dependency_config.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/factory_dependency.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/factory_param_dependency.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/lazy_singleton.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/presolve_singleton_dependency.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config/singleton_dependency.dart';

import 'package:stacked_generator/src/generators/getit/stacked_locator_content_generator.dart';
import 'package:test/test.dart';

import '../../helpers/test_constants/getit_constants.dart';

void main() {
  group('StackedLocatorContentGeneratorTest -', () {
    group('generate -', () {
      void callGeneratorWithServicesConfigAndExpectResult(
          List<DependencyConfig> dependencies, dynamic expectedResult,
          {String? locatorName, String? locatorSetupName}) {
        final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
            dependencies: dependencies,
            locatorName: locatorName ?? 'filledstacksLocator',
            locatorSetupName:
                locatorSetupName ?? 'filledstacksLocatorSetupName');
        expect(stackedLocaterContentGenerator.generate(), expectedResult);
      }

      void callGeneratorWithServicesConfigAndExpectException<T>(
          List<DependencyConfig> dependencies,
          [String? exceptionMessage]) {
        final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
            dependencies: dependencies,
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
          final dependencies = [
            PresolveSingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
              presolveFunction: 'staticPresolveFunction',
            ),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithPresolveFunctionAndDependencyTypePresolvedSingleton);
        });
      });
      group('Factory -', () {
        test(
            'with one DependencyConfig that has presolveFunction and [type=DependencyType.Factory]',
            () {
          final dependencies = [
            FactoryDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactory);
        });
      });
      group('FactoryWithParam -', () {
        test('When params is null, Should throw InvalidGeneratorInputException',
            () {
          final dependencies = [
            FactoryParamDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ];

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(dependencies,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test(
            'When params isEmpty, Should throw a InvalidGeneratorInputException',
            () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne', className: 'GeolocaorService', params: {}),
          ];

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(dependencies,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test('''
When params is not empty but DependencyParamConfig type is null
, Should throw a InvalidGeneratorInputException''', () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {FactoryParameter()}),
          ];

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(dependencies,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test('''
When params is not empty and DependencyParamConfig type is empty,
, Should throw a InvalidGeneratorInputException that atleast one [DependencyParamConfig] 
needs to have isFactoryParam needs to be true''', () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {FactoryParameter(type: '')}),
          ];

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(dependencies,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test('''
When params is not empty and DependencyParamConfig type doesn't have a question mark '?'
, Should throw a InvalidGeneratorInputException that factory needs to be nullable''',
            () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  FactoryParameter(
                    type: 'newType',
                    isFactoryParam: true,
                  ),
                }),
          ];

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(dependencies,
              "Factory params must be nullable. Parameter null is not nullable");
        });
        test('''
When params is not empty and DependencyParamConfig type have a question mark '?'
, Should generate code''', () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  FactoryParameter(
                    type: 'newType?',
                    isFactoryParam: true,
                  ),
                }),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParams);
        });
        test('''
When params is not empty and DependencyParamConfig type is newType? and default value is shit
, Should generate code''', () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  FactoryParameter(
                    type: 'newType?',
                    defaultValueCode: 'shit',
                    isFactoryParam: true,
                  ),
                }),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndDefaultValue);
        });
        test('''
When params is not empty and DependencyParamConfig type is 
newType? and isPositional=true, Should generate code''', () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  FactoryParameter(
                    type: 'newType?',
                    isPositional: true,
                    isFactoryParam: true,
                  ),
                }),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndIsPositionalIsTrue);
        });
        test('''
When params is not empty and DependencyParamConfig type is newType? 
and default value is shit and isPositional=true, Should generate code''', () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  FactoryParameter(
                    type: 'newType?',
                    isPositional: true,
                    defaultValueCode: 'shit',
                    isFactoryParam: true,
                  ),
                }),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndDefaultValueIsshitAndIsPositionalIsTrue);
        });
        test('''
When params is not empty and DependencyParamConfig 
type is newType? and name is hello, Should generate code''', () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  FactoryParameter(
                    type: 'newType?',
                    name: 'hello',
                    isFactoryParam: true,
                  ),
                }),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndIsNameIsHello);
        });
        test('''
When provide two FactoryParamDependency, Should generate code''', () {
          final dependencies = [
            FactoryParamDependency(
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  FactoryParameter(
                    type: 'newType?',
                    name: 'hello',
                    isFactoryParam: true,
                  ),
                  FactoryParameter(
                    type: 'freshType?',
                    name: 'helloThere',
                    isFactoryParam: true,
                  ),
                }),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndTwoFactoryParam);
        });
      });
      group('Singleton -', () {
        test('with one DependencyConfig ', () {
          final dependencies = [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            )
          ];
          callGeneratorWithServicesConfigAndExpectResult(
              dependencies, kStackedLocaterWithOneDependencyOutput,
              locatorName: 'ebraLocator',
              locatorSetupName: 'ebraLocatorSetupName');
        });
        test('with two dependencies', () {
          final dependencies = [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
            SingletonDependency(
              import: 'importTwo',
              className: 'FireService',
            )
          ];

          callGeneratorWithServicesConfigAndExpectResult(
              dependencies, kStackedLocaterWithTwoDependenciesOutput);
        });
        test('with two dependencies and added DependencyParamConfig imports',
            () {
          final dependencies = [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ];

          callGeneratorWithServicesConfigAndExpectResult(
              dependencies, kStackedLocaterWithOneDependencyOutputWithImports);
        });

        test('with one DependencyConfig that has abstractedImport', () {
          final dependencies = [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
              abstractedImport: 'abstractedImportOne',
            ),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithAbstractedImport);
        });
        test('with one DependencyConfig that has abstractedTypeClassName', () {
          final dependencies = [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
              abstractedTypeClassName: 'abstractedTypeClassNamee',
            ),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithAbstractedTypeClassName);
        });
        test('with one DependencyConfig that has environments', () {
          final dependencies = [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
              environments: {'dev', 'prod'},
            ),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithEnviroments);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.Singleton],
 Should ignors all [params] DependencyParamConfig and generate the same code''',
            () {
          final dependencies = [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ];

          final dependenciesWithEmptyParams = [
            SingletonDependency(
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeSinglton);
          callGeneratorWithServicesConfigAndExpectResult(
              dependenciesWithEmptyParams,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeSinglton);
        });
      });
      group('LazySingleton -', () {
        test('''
with one DependencyConfig that has [type=DependencyType.LazySingleton],
 Should generate code''', () {
          final dependencies = [
            LazySingletonDependency(
                import: 'importOne', className: 'GeolocaorService'),
          ];

          callGeneratorWithServicesConfigAndExpectResult(dependencies,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeLazySinglton);
        });
      });
    });
  });
}
