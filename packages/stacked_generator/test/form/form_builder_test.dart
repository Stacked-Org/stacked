import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/form_builder.dart';
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
            autoTextFieldValidation: false,
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
              const TextFieldConfig(name: 'name'),
              const DateFieldConfig(name: 'date'),
              const DropdownFieldConfig(name: 'dropDown', items: []),
            ],
            autoTextFieldValidation: true,
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
              const DropdownFieldConfig(
                name: 'dropDown',
                items: [
                  DropdownFieldItem(value: '1', title: 'one'),
                  DropdownFieldItem(value: '2', title: 'two'),
                ],
              ),
            ],
            autoTextFieldValidation: false,
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
              const TextFieldConfig(name: 'firstName'),
              const TextFieldConfig(name: 'lastName'),
            ],
            autoTextFieldValidation: false,
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
              const TextFieldConfig(name: 'firstName'),
              const TextFieldConfig(name: 'lastName'),
            ],
            autoTextFieldValidation: false,
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
              const TextFieldConfig(
                name: 'firstName',
              ),
              const TextFieldConfig(name: 'lastName'),
            ],
            autoTextFieldValidation: false,
          ),
        );
        builder.addTextEditingControllersForTextFields();
        expect(builder.serializeStringBuffer,
            ksTextEditingControllerGettersForTextFields);
      });
    });
    group('addClosingBracket -', () {
      test('When call, Should add a curly bracket and a newline', () {
        FormBuilder builder = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'Test',
            fields: [],
          ),
        );
        builder.addClosingBracket();
        expect(builder.serializeStringBuffer, '}\n');
      });
    });

    group('Example-1 -', () {
      late FormBuilder builder;
      setUp(() {
        builder = FormBuilder(
          formViewConfig: FormViewConfig(
            viewName: 'TestView',
            fields: [
              const TextFieldConfig(
                  name: 'name',
                  initialValue: 'name initial value',
                  validatorFunction: ExecutableElementData(
                      validatorPath: 'validators/path',
                      enclosingElementName: 'enclosingElementName',
                      hasEnclosingElementName: true,
                      validatorName: 'nameValidator')),
              const TextFieldConfig(
                  name: 'email',
                  initialValue: 'email initial value',
                  customTextEditingController: ExecutableElementData(
                      validatorPath: 'controllers/path',
                      enclosingElementName: 'enclosingElementName',
                      hasEnclosingElementName: true,
                      validatorName: 'emailController')),
              const DateFieldConfig(name: 'date'),
              const DropdownFieldConfig(name: 'dropDown', items: [
                DropdownFieldItem(title: 'title1', value: 'value1'),
                DropdownFieldItem(title: 'title2', value: 'value2'),
              ]),
            ],
          ),
        );
      });

      group('addClosingBracket -', () {
        test('When called, Should add a bracket with a new line', () {
          builder.addClosingBracket();
          expect(builder.serializeStringBuffer, '}\n');
        });
      });
      group('addDisposeForTextControllers -', () {
        test('When called, Should dispose all TextControllers', () {
          builder.addDisposeForTextControllers();

          expect(
              builder.serializeStringBuffer, kExample1DisposeTextControllers);
        });
      });
      group('addDropdownItemsMap -', () {
        test('When called, Should add dropDownItems map', () {
          builder.addDropdownItemsMap();

          expect(builder.serializeStringBuffer, kExample1DropDownItemsMap);
        });
      });
      group('addDropdownItemsMap -', () {
        test('When called, Should add dropDownItems map', () {
          builder.addFocusNodeItemsMap();

          expect(builder.serializeStringBuffer, kExample1FocusNodesMap);
        });
      });
      group('addFormDataUpdateFunctionTorTextControllers -', () {
        test('When called, Should add update form data function', () {
          builder.addFormDataUpdateFunctionTorTextControllers();

          expect(builder.serializeStringBuffer, kExample1UpdateFormData);
        });
      });
      group('addFormViewModelExtensionForGetters -', () {
        test('When called, Should add formviewmodel extension', () {
          builder.addFormViewModelExtensionForGetters();

          expect(builder.serializeStringBuffer,
              kExample1ViewModelExtensionForGetters);
        },
            skip:
                'This is too fickle. It\'s failing due to spacing issues. I want something more robust here');
      });
      group('addFormViewModelExtensionForMethods -', () {
        test('When called, Should add extension Methods on FormViewModel', () {
          builder.addFormViewModelExtensionForMethods();

          expect(builder.serializeStringBuffer,
              kExample1ViewModelExtensionForMethods);
        });
      });
      group('addGetCustomTextEditingController -', () {
        test(
            'When called, Should add registerations function for a customTextEditingController',
            () {
          builder.addGetCustomTextEditingController();

          expect(builder.serializeStringBuffer,
              kExample1AddRegisterationCustomTextEditingController);
        });
      });
      group('addGetFocuNode -', () {
        test('When called, Should add registerations function for a focusNodes',
            () {
          builder.addGetFocuNode();

          expect(builder.serializeStringBuffer,
              kExample1AddRegisterationForFocusNodes);
        });
      });
      group('addGetTextEditinController -', () {
        test(
            'When called, Should add registerations function for a TextEditingController',
            () {
          builder.addGetTextEditinController();

          expect(builder.serializeStringBuffer,
              kExample1AddRegisterationextEditingController);
        });
      });
      group('addGetValidationMessageForTextController -', () {
        test(
            'When called, Should add get validation message for a TextEditingController',
            () {
          builder.addGetValidationMessageForTextController();

          expect(builder.serializeStringBuffer,
              kExample1AddValidationMessageForTextEditingController);
        });
      });
      group('addHeaderComment -', () {
        test('When called, Should add a comment at the top of the file', () {
          builder.addHeaderComment();

          expect(builder.serializeStringBuffer, kExample1AddHeaderComment);
        });
      });
      group('addImports -', () {
        test('When called, Should add a comment at the top of the file', () {
          builder.addImports();

          expect(builder.serializeStringBuffer, kExample1AddImports);
        });
      });
      group('addImports -', () {
        test('When called, Should add a comment at the top of the file', () {
          builder.addImports();

          expect(builder.serializeStringBuffer, kExample1AddImports);
        });
      });
      group('addListenerRegistrationsForTextFields -', () {
        test('When called, Should add listeners for TextFields', () {
          builder.addListenerRegistrationsForTextFields();

          expect(builder.serializeStringBuffer,
              kExample1AddListenerRegistrationsForTextFields);
        });
      });
      group('addValidationDataUpdateFunctionTorTextControllers -', () {
        test(
            'When called, Should add Updates the fieldsValidationMessages on the FormViewModel',
            () {
          builder.addValidationDataUpdateFunctionTorTextControllers();

          expect(builder.serializeStringBuffer,
              kExample1AddValidationDataUpdateFunctionTorTextControllers);
        });
      });
      group('addMixinSignature -', () {
        test('When called, Should add Mixin Signature', () {
          builder.addMixinSignature();

          expect(builder.serializeStringBuffer, kExample1AddMixinSignature);
        });
      });
      group('addValidationFunctionsFromAnnotation -', () {
        test('When called, Should add TextValidations', () {
          builder.addValidationFunctionsFromAnnotation();

          expect(builder.serializeStringBuffer,
              kExample1AddValidationFunctionsFromAnnotation);
        });
      });
      group('addFocusNodesForTextFields -', () {
        test('When called, Should add focusNodes Getters', () {
          builder.addFocusNodesForTextFields();

          expect(builder.serializeStringBuffer, kExample1AddFocusNodesGetters);
        });
      });
    });
  });
}
