import 'package:test/test.dart';

import '../../helpers/common.dart';

void main() {
  group('factory -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/integration/factory/',
        fileName: 'factory.locator',
      );
    });
  });
  group('factorywithtype -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/integration/factory/',
        fileName: 'factorywithtype.locator',
      );
    });
  });
  group('factorywithparam -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/integration/factory/',
        fileName: 'factorywithparam.locator',
      );
    });
  });
}
