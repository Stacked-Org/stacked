import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/form_util_service.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';
import 'package:test/test.dart';

import 'constant_test_helper.dart';

void main() {
  group('FormGeneratorTest -', () {
    group('generateImport -', () {
      test('when called should generate imports', () {
        FormUtilService utilService = FormUtilService(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [],
          ),
        );
        utilService.generateImports();
        expect(utilService.stringBuffer.toString(), ksFormImports);
      });
    });
    group('generateValueMapKeys -', () {
      test('when called should generate keys for fields', () {
        FormUtilService utilService = FormUtilService(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'name'),
              DateFieldConfig(name: 'date'),
              DropdownFieldConfig(name: 'dropDown', items: []),
            ],
          ),
        );
        utilService.generateValueMapKeys();
        expect(utilService.stringBuffer.toString(),
            ksFormKeys('name', 'date', 'dropDown'));
      });
    });
    group(' generateDropdownItemsMap-', () {
      test('when called should generate drop down options map', () {
        FormUtilService utilService = FormUtilService(
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
        utilService.generateDropdownItemsMap();
        expect(utilService.stringBuffer.toString(), ksDropdownItemsMap);
      });
    });

    group('generateTextEditingControllerItemsMap -', () {
      test('when called should generate textEditing controllers map', () {
        FormUtilService utilService = FormUtilService(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'firstName'),
              TextFieldConfig(name: 'lastName'),
            ],
          ),
        );
        utilService.generateTextEditingControllerItemsMap();
        expect(utilService.stringBuffer.toString(),
            ksTextEditingControllerItemsMap);
      });
    });
    group('generateTextEdittingControllersForTextFields -', () {
      test('when called should generate the getters for textEditingControllers',
          () {
        FormUtilService utilService = FormUtilService(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [
              TextFieldConfig(name: 'firstName'),
              TextFieldConfig(name: 'lastName'),
            ],
          ),
        );
        utilService.generateTextEditingControllersForTextFields();
        expect(utilService.stringBuffer.toString(),
            ksTextEditingControllerGettersForTextFields);
      });
    });
  });
}
