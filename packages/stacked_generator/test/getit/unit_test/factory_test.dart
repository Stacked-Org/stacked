import 'package:stacked_core/stacked_core.dart';
import 'package:test/test.dart';

import '../../helpers/dumb_service.dart';
import '../integration_test/samples/factory/factory.locator.dart';
import '../integration_test/samples/factory/factorywithtype.locator.dart';

void main() {
  group('FactoryTest -', () {
    /// unregiseter all the services before every test cause [StackedLocator] is a factory
    setUp(StackedLocator.instance.reset);
    test('When forget to register factory, Should throw AssertionError',
        () async {
      expect(
          () => factoryLocator<DumpService>(), throwsA(isA<AssertionError>()));
    });
    test('When register factory, Should returnsNormally', () async {
      setupFactoryLocator();

      expect(() => factoryLocator<DumpService>(), returnsNormally);
    });
    test(
        'When register factory with type, Should call it by the type not the implementation',
        () async {
      setupFactorywithtypeLocator();
      expect(
          () => factoryLocator<DumpService>(), throwsA(isA<AssertionError>()));
      expect(() => factoryLocator<AbstractDumpService>(), returnsNormally);
    });
    test(
        'When request multiple instances of a service, Should get a new one for every request',
        () {
      setupFactoryLocator();
      final firstInstance = factoryLocator<DumpService>();
      final secondInstance = factoryLocator<DumpService>();
      expect(firstInstance == secondInstance, isFalse);
    });
  });
}
