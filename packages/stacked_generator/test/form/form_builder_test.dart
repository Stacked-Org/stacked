import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/form_generator_util.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';
import 'package:test/test.dart';

import 'constant_test_helper.dart';

void main() {
  group('FormBuilderTest -', () {
    group('addImports -', () {
      test('when called should generate imports', () {
        FormBuilder builder = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [],
          ),
        );
        builder.addImports();
        expect(builder.serializeStringBuffer, ksFormImports);
      });
    });
    group('addValueMapKeys -', () {
      test('when called should generate keys for fields', () {
        FormBuilder builder = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'name'),
              DateFieldConfig(name: 'date'),
              DropdownFieldConfig(name: 'dropDown', items: []),
            ],
          ),
        );
        builder.addValueMapKeys();
        expect(builder.serializeStringBuffer,
            ksFormKeys('name', 'date', 'dropDown'));
      });
    });
    group('addDropdownItemsMap -', () {
      test('when called should generate drop down options map', () {
        FormBuilder builder = FormBuilder(
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
        builder.addDropdownItemsMap();
        expect(builder.serializeStringBuffer, ksDropdownItemsMap);
      });
    });

    group('addTextEditingControllerItemsMap -', () {
      test('when called should generate textEditing controllers map', () {
        FormBuilder builder = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'firstName'),
              TextFieldConfig(name: 'lastName'),
            ],
          ),
        );
        builder.addTextEditingControllerItemsMap();
        expect(builder.serializeStringBuffer, ksTextEditingControllerItemsMap);
      });
    });
    group('addTextEditingControllersForTextFields -', () {
      test('when called should generate the getters for textEditingControllers',
          () {
        FormBuilder builder = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'firstName'),
              TextFieldConfig(name: 'lastName'),
            ],
          ),
        );
        builder.addTextEditingControllersForTextFields();
        expect(builder.serializeStringBuffer,
            ksTextEditingControllerGettersForTextFields);
      });
    });
    group('addTextEditingControllersForTextFields -', () {
      test(
          'When provide a customTextEditingController, Should replace the default one',
          () {
        FormBuilder builder = FormBuilder(
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
        builder.addTextEditingControllersForTextFields();
        expect(builder.serializeStringBuffer,
            ksTextEditingControllerGettersForTextFields);
      });
    });
  });
}
