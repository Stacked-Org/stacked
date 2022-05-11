import 'package:test/test.dart';

import '../../helpers/common.dart';

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
  group('singletonwithtype -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/integration/singleton/',
        fileName: 'singletonwithtype.locator',
      );
    });
  });
  group('singletonwithresolve -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/integration/singleton/',
        fileName: 'singletonwithresolve.locator',
      );
    });
  });
  group('lazysingleton -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/integration/singleton/',
        fileName: 'lazysingleton.locator',
      );
    });
  });
}
