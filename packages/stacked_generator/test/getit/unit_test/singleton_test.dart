import 'package:stacked_shared/stacked_shared.dart';
import 'package:test/test.dart';

import '../../helpers/dumb_service.dart';
import '../integration_test/samples/singleton/singleton.locator.dart';
import '../integration_test/samples/singleton/singletonwithtype.locator.dart';

void main() {
  group('SingletonTest -', () {
    /// unregiseter all the services before every test cause [StackedLocator] is a singleton
    setUp(StackedLocator.instance.reset);
    test('When forget to register singleton, Should throw AssertionError',
        () async {
      expect(() => singletonLocator<DumpService>(),
          throwsA(isA<AssertionError>()));
    });
    test('When register singleton, Should returnsNormally', () async {
      setupSingletonLocator();

      expect(() => singletonLocator<DumpService>(), returnsNormally);
    });
    test(
        'When register singleton with type, Should call it by the type not the implementation',
        () async {
      setupSingletonWithTypeLocator();

      expect(() => singletonLocator<DumpService>(),
          throwsA(isA<AssertionError>()));
      expect(() => singletonLocator<AbstractDumpService>(), returnsNormally);
    });
    test(
        'When request multiple instances of a service, Should be get the same object',
        () {
      setupSingletonLocator();
      final firstInstance = singletonLocator<DumpService>();
      final secondInstance = singletonLocator<DumpService>();
      expect(firstInstance == secondInstance, isTrue);
    });
  });
}
