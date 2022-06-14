import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/forms/form_generator_util.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';

/// A generator that creates the form code based on the configs passed in
class StackedFormContentGenerator implements BaseGenerator {
  final FormViewConfig _formViewConfig;
  StackedFormContentGenerator(this._formViewConfig);

  @override
  String generate() {
    final formGeneratorUtil = FormGeneratorUtil(formViewConfig: _formViewConfig)
      ..writeHeaderComment()
      ..generateImports()
      ..generateValueMapKeys()
      ..generateDropdownItemsMap()
      ..generateTextEditingControllerItemsMap()
      ..generateFocusNodeItemsMap()
      ..generateValidationFunctionsFromAnnotation()
      ..writeMixinSignature()
      ..generateTextEditingControllersForTextFields()
      ..generateGetCustomTextEditingController()
      ..generateFocusNodesForTextFields()
      ..generateGetTextEditinController()
      ..generateGetFocuNode()
      ..generateListenerRegistrationsForTextFields()
      ..generateFormDataUpdateFunctionTorTextControllers()
      ..generateValidationDataUpdateFunctionTorTextControllers()
      ..generateGetValidationMessageForTextController()
      ..generateDisposeForTextControllers()
      ..closeBracket()
      ..generateFormViewModelExtensionForGetters()
      ..generateFormViewModelExtensionForMethods();

    return formGeneratorUtil.serializeStringBuffer;
  }
}
