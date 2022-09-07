import 'package:stacked_generator/src/generators/bottomsheets/bottomsheet_config.dart';
import 'package:stacked_generator/src/generators/bottomsheets/generate/bottomsheet_class_generator.dart';
import 'package:test/test.dart';

import '../helpers/test_constants/bottomsheets_constants.dart';

void main() {
  group('BottomsheetClassGeneratorTest -', () {
    group('generate -', () {
      test('When empty', () {
        final generator = BottomsheetClassGenerator([]);
        expect(generator.generate(), kBottomsheetsEmpty);
      });
      test('When change locator name', () {
        final generator =
            BottomsheetClassGenerator([], locatorName: 'customLocator');
        expect(generator.generate(), kBottomsheetsWithCustomNamedLocator);
      });
      test('One bottomsheet', () {
        final generator = BottomsheetClassGenerator([
          const BottomsheetConfig(
              import: 'one.dart', bottomsheetClassName: 'BasicBottomsheet')
        ]);
        expect(generator.generate(), kOneBottomsheet);
      });
      test('Two bottomsheets', () {
        final generator = BottomsheetClassGenerator([
          const BottomsheetConfig(
              import: 'one.dart', bottomsheetClassName: 'BasicBottomsheet'),
          const BottomsheetConfig(
              import: 'two.dart', bottomsheetClassName: 'ComplexBottomsheet')
        ]);

        expect(generator.generate(), kTwoBottomsheets);
      });
    });
  });
}
