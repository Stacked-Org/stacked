import 'package:test/test.dart';

import '../../helpers/common.dart';

void main() {
  group('factory -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/getit/integration_test/samples/factory/',
        fileName: 'factory.locator',
      );
    });
  });
  group('factorywithtype -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/getit/integration_test/samples/factory/',
        fileName: 'factorywithtype.locator',
      );
    });
  });
  group('factorywithoneparam -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/getit/integration_test/samples/factory/',
        fileName: 'factorywithoneparam.locator',
      );
    });
  });
  group('factorywithtwoparam -', () {
    test('has no compile issue', () async {
      await checkCodeForCompilationError(
        generatorName: 'stacked_generator',
        relativePath: 'test/getit/integration_test/samples/factory/',
        fileName: 'factorywithtwoparam.locator',
      );
    });
  });
}
