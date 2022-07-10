import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/forms/form_builder.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';

/// A generator that creates the form code based on the configs passed in
class StackedFormContentGenerator implements BaseGenerator {
  final FormViewConfig _formViewConfig;
  const StackedFormContentGenerator(this._formViewConfig);

  @override
  String generate() {
    final formBuilder = FormBuilder(formViewConfig: _formViewConfig)
        .addHeaderComment()
        .addImports()
        .addValueMapKeys()
        .addDropdownItemsMap()
        .addTextEditingControllerItemsMap()
        .addFocusNodeItemsMap()
        .addValidationFunctionsFromAnnotation()
        .addMixinSignature()
        .addTextEditingControllersForTextFields()
        .addGetCustomTextEditingController()
        .addFocusNodesForTextFields()
        .addGetTextEditinController()
        .addGetFocuNode()
        .addListenerRegistrationsForTextFields()
        .addManualValidation()
        .addFormDataUpdateFunctionTorTextControllers()
        .addValidationDataUpdateFunctionTorTextControllers()
        .addGetValidationMessageForTextController()
        .addDisposeForTextControllers()
        .addClosingBracket()
        .addFormViewModelExtensionForGetters()
        .addFormViewModelExtensionForMethods();

    return formBuilder.serializeStringBuffer;
  }
}
