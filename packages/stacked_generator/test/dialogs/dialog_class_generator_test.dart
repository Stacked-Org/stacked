import 'package:stacked_generator/src/generators/dialogs/dialog_config.dart';
import 'package:stacked_generator/src/generators/dialogs/generate/dialog_class_generator.dart';
import 'package:test/test.dart';

import '../helpers/dialog_constant.dart';

void main() {
  group('DialogClassGeneratorTest -', () {
    group('generate -', () {
      test('When empty', () {
        final generator = DialogClassGenerator([]);
        expect(generator.generate(), kDialogsEmpty);
      });
      test('When change locator name', () {
        final generator =
            DialogClassGenerator([], locatorName: 'customLocator');
        expect(generator.generate(), kDialogsWithCustomNamedLocator);
      });
      test('One dialog', () {
        final generator = DialogClassGenerator(
            [DialogConfig(import: 'one.dart', dialogClassName: 'BasicDialog')]);
        expect(generator.generate(), kOneDialog);
      });
      test('Two dialogs', () {
        final generator = DialogClassGenerator([
          DialogConfig(import: 'one.dart', dialogClassName: 'BasicDialog'),
          DialogConfig(import: 'two.dart', dialogClassName: 'ComplexDialog')
        ]);

        expect(generator.generate(), kTwoDialogs);
      });
    });
  });
}
