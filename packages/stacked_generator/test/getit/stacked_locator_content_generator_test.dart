import 'package:stacked_generator/src/generators/enums/dependency_type.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config.dart';
import 'package:stacked_generator/src/generators/getit/dependency_param_config.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';
import 'package:stacked_generator/src/generators/getit/stacked_locator_content_generator.dart';
import 'package:test/test.dart';

import '../helpers/getit_constants.dart';

void main() {
  group('StackedLocatorContentGeneratorTest -', () {
    test('test generating locator with one dependency ', () {
      final servicesConfig = ServicesConfig(services: [
        DependencyConfig(
            import: 'importOne',
            className: 'GeolocaorService',
            params: {DependencyParamConfig()})
      ]);
      final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
          servicesConfig: servicesConfig,
          locatorName: 'ebraLocator',
          locatorSetupName: 'ebraLocatorSetupName');
      expect(stackedLocaterContentGenerator.generate(),
          kStackedLocaterWithOneDependencyOutput);
    });
    test('test generating locator with two dependencies', () {
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
      final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
          servicesConfig: servicesConfig,
          locatorName: 'filledstacksLocator',
          locatorSetupName: 'filledstacksLocatorSetupName');
      expect(stackedLocaterContentGenerator.generate(),
          kStackedLocaterWithTwoDependenciesOutput);
    });
    test(
        'test generating locator with two dependencies with added DependencyParamConfig imports',
        () {
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
      final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
          servicesConfig: servicesConfig,
          locatorName: 'filledstacksLocator',
          locatorSetupName: 'filledstacksLocatorSetupName');
      expect(stackedLocaterContentGenerator.generate(),
          kStackedLocaterWithOneDependencyOutputWithImports);
    });

    test(
        'test generating locator with one dependency that has abstractedImport',
        () {
      final servicesConfig = ServicesConfig(services: [
        DependencyConfig(
            import: 'importOne',
            className: 'GeolocaorService',
            abstractedImport: 'abstractedImportOne',
            params: {DependencyParamConfig()}),
      ]);
      final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
          servicesConfig: servicesConfig,
          locatorName: 'filledstacksLocator',
          locatorSetupName: 'filledstacksLocatorSetupName');
      expect(stackedLocaterContentGenerator.generate(),
          kStackedLocaterWithOneDependencyOutputWithAbstractedImport);
    });
    test(
        'test generating locator with one dependency that has abstractedTypeClassName',
        () {
      final servicesConfig = ServicesConfig(services: [
        DependencyConfig(
            import: 'importOne',
            className: 'GeolocaorService',
            abstractedTypeClassName: 'abstractedTypeClassNamee',
            params: {DependencyParamConfig()}),
      ]);
      final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
          servicesConfig: servicesConfig,
          locatorName: 'filledstacksLocator',
          locatorSetupName: 'filledstacksLocatorSetupName');
      expect(stackedLocaterContentGenerator.generate(),
          kStackedLocaterWithOneDependencyOutputWithAbstractedTypeClassName);
    });
    test('test generating locator with one dependency that has environments',
        () {
      final servicesConfig = ServicesConfig(services: [
        DependencyConfig(
            import: 'importOne',
            className: 'GeolocaorService',
            environments: {'dev', 'prod'},
            params: {DependencyParamConfig()}),
      ]);
      final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
          servicesConfig: servicesConfig,
          locatorName: 'filledstacksLocator',
          locatorSetupName: 'filledstacksLocatorSetupName');
      expect(stackedLocaterContentGenerator.generate(),
          kStackedLocaterWithOneDependencyOutputWithEnviroments);
    });
    test(
        'test generating locator with one dependency that has presolveFunction and type = DependencyType.PresolvedSingleton',
        () {
      final servicesConfig = ServicesConfig(services: [
        DependencyConfig(
            type: DependencyType.PresolvedSingleton,
            import: 'importOne',
            className: 'GeolocaorService',
            presolveFunction: 'staticPresolveFunction',
            params: {DependencyParamConfig()}),
      ]);
      final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
          servicesConfig: servicesConfig,
          locatorName: 'filledstacksLocator',
          locatorSetupName: 'filledstacksLocatorSetupName');
      expect(stackedLocaterContentGenerator.generate(),
          kStackedLocaterWithOneDependencyOutputWithPresolveFunctionAndDependencyTypePresolvedSingleton);
    });
  });
}
