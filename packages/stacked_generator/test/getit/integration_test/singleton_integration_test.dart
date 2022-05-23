import 'package:test/test.dart';

import '../../helpers/common.dart';

void main() {
  group('singleton -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/getit/integration_test/samples/singleton/',
        fileName: 'singleton.locator',
      );
    });
  });
  group('singletonwithtype -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/getit/integration_test/samples/singleton/',
        fileName: 'singletonwithtype.locator',
      );
    });
  });
  group('singletonwithresolve -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/getit/integration_test/samples/singleton/',
        fileName: 'singletonwithresolve.locator',
      );
    });
  });
  group('lazysingleton -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/getit/integration_test/samples/singleton/',
        fileName: 'lazysingleton.locator',
      );
    });
  });
  group('presolvedsingleton -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/getit/integration_test/samples/singleton/',
        fileName: 'presolvedsingleton.locator',
      );
    });
  });
}
