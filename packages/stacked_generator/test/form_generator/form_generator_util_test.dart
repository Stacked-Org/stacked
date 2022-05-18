import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/form_generator_util.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';
import 'package:test/test.dart';

import 'constant_test_helper.dart';

void main() {
  group('FormGeneratorTest -', () {
    group('generateImport -', () {
      test('when called should generate imports', () {
        FormGeneratorUtil util = FormGeneratorUtil(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [],
          ),
        );
        util.generateImports();
        expect(util.stringBuffer.toString(), ksFormImports);
      });
    });
    group('generateValueMapKeys -', () {
      test('when called should generate keys for fields', () {
        FormGeneratorUtil util = FormGeneratorUtil(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'name'),
              DateFieldConfig(name: 'date'),
              DropdownFieldConfig(name: 'dropDown', items: []),
            ],
          ),
        );
        util.generateValueMapKeys();
        expect(util.stringBuffer.toString(),
            ksFormKeys('name', 'date', 'dropDown'));
      });
    });
    group(' generateDropdownItemsMap-', () {
      test('when called should generate drop down options map', () {
        FormGeneratorUtil util = FormGeneratorUtil(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              DropdownFieldConfig(
                name: 'dropDown',
                items: [
                  DropdownFieldItem(value: '1', title: 'one'),
                  DropdownFieldItem(value: '2', title: 'two'),
                ],
              ),
            ],
          ),
        );
        util.generateDropdownItemsMap();
        expect(util.stringBuffer.toString(), ksDropdownItemsMap);
      });
    });

    group('generateTextEditingControllerItemsMap -', () {
      test('when called should generate textEditing controllers map', () {
        FormGeneratorUtil util = FormGeneratorUtil(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'firstName'),
              TextFieldConfig(name: 'lastName'),
            ],
          ),
        );
        util.generateTextEditingControllerItemsMap();
        expect(util.stringBuffer.toString(),
            ksTextEditingControllerItemsMap);
      });
    });
    group('generateTextEdittingControllersForTextFields -', () {
      test('when called should generate the getters for textEditingControllers',
          () {
        FormGeneratorUtil util = FormGeneratorUtil(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'firstName'),
              TextFieldConfig(name: 'lastName'),
            ],
          ),
        );
        util.generateTextEditingControllersForTextFields();
        expect(util.stringBuffer.toString(),
            ksTextEditingControllerGettersForTextFields);
      });
    });
  });
}
