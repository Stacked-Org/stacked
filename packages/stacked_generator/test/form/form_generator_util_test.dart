import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/form_generator_util.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';
import 'package:test/test.dart';

import 'constant_test_helper.dart';

void main() {
  group('FormGeneratorTest -', () {
    group('generateImport -', () {
      test('when called should generate imports', () {
        FormBuilder util = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [],
          ),
        );
        util.addImports();
        expect(util.serializeStringBuffer, ksFormImports);
      });
    });
    group('generateValueMapKeys -', () {
      test('when called should generate keys for fields', () {
        FormBuilder util = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'name'),
              DateFieldConfig(name: 'date'),
              DropdownFieldConfig(name: 'dropDown', items: []),
            ],
          ),
        );
        util.addValueMapKeys();
        expect(
            util.serializeStringBuffer, ksFormKeys('name', 'date', 'dropDown'));
      });
    });
    group(' generateDropdownItemsMap-', () {
      test('when called should generate drop down options map', () {
        FormBuilder util = FormBuilder(
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
        util.addDropdownItemsMap();
        expect(util.serializeStringBuffer, ksDropdownItemsMap);
      });
    });

    group('generateTextEditingControllerItemsMap -', () {
      test('when called should generate textEditing controllers map', () {
        FormBuilder util = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'firstName'),
              TextFieldConfig(name: 'lastName'),
            ],
          ),
        );
        util.addTextEditingControllerItemsMap();
        expect(util.serializeStringBuffer, ksTextEditingControllerItemsMap);
      });
    });
    group('generateTextEdittingControllersForTextFields -', () {
      test('when called should generate the getters for textEditingControllers',
          () {
        FormBuilder util = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'firstName'),
              TextFieldConfig(name: 'lastName'),
            ],
          ),
        );
        util.addTextEditingControllersForTextFields();
        expect(util.serializeStringBuffer,
            ksTextEditingControllerGettersForTextFields);
      });
    });
    group('generateCustomTextEditingController -', () {
      test(
          'When provide a customTextEditingController, Should replace the default one',
          () {
        FormBuilder util = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(
                name: 'firstName',
              ),
              TextFieldConfig(name: 'lastName'),
            ],
          ),
        );
        util.addTextEditingControllersForTextFields();
        expect(util.serializeStringBuffer,
            ksTextEditingControllerGettersForTextFields);
      });
    });
  });
}
