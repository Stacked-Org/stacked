import 'package:test/test.dart';

import '../helpers/common.dart';

void main() {
  group('singleton -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/integration/singleton/',
        fileName: 'singleton.locator',
      );
    });
  });
  group('singletonTestWithType -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/integration/singleton/',
        fileName: 'singletonwithtype.locator',
      );
    });
  });
  group('singletonTestWithResolve -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/integration/singleton/',
        fileName: 'singletonwithresolve.locator',
      );
    });
  });
}
