import 'package:test/test.dart';

import '../helpers/dumb_service.dart';
import '../integration/singleton/singleton.locator.dart';

void main() {
  group('SingletonTest -', () {
    test('When forget to register singleton, Should throw AssertionError',
        () async {
      expect(() => singletonLocator<DumpService>(),
          throwsA(isA<AssertionError>()));
    });
    test('When register singleton, Should returnsNormally', () async {
      setupSingletonLocator();

      expect(() => singletonLocator<DumpService>(), returnsNormally);
    });
  });
}
