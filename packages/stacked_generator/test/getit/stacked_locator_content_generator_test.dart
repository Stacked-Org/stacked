import 'package:stacked_generator/src/generators/getit/dependency_config.dart';
import 'package:stacked_generator/src/generators/getit/dependency_param_config.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';
import 'package:stacked_generator/src/generators/getit/stacked_locator_content_generator.dart';
import 'package:test/test.dart';

import '../helpers/getit_constants.dart';

void main() {
  group('StackedLocatorContentGeneratorTest -', () {
    test('test generating simple locator ', () {
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
          kStackedLocaterContentGeneratorResult);
    });
  });
}
