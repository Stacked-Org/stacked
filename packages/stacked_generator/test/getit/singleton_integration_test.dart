import 'package:test/test.dart';

import '../helpers/common.dart';

void main() {
  group('singletonTest -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
          'stacked_generator|test/integration/singleton/singleton.locator.dart',
          'singleton.locator',
          '/stacked_generator/test/integration/singleton/singleton.locator.dart');
    });
  });
  group('singletonTestWithType -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
          'stacked_generator|test/integration/singleton/singletonwithtype.locator.dart',
          'singletonwithtype.locator',
          '/stacked_generator/test/integration/singleton/singletonwithtype.locator.dart');
    });
  });
}
