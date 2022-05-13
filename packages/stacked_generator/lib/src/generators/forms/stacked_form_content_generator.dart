import 'package:stacked_generator/src/generators/forms/form_util_service.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';

/// A generator that creates the form code based on the configs passed in
class StackedFormContentGenerator extends FormUtilService {
  final FormViewConfig formViewConfig;
  StackedFormContentGenerator(this.formViewConfig)
      : super(formViewConfig: formViewConfig);

  String generate() {
    writeLine("// ignore_for_file: public_member_api_docs");

    // TODO: All of these functions can be moved into a separate util class or service
    // and can then be unit tested to avoid simple mistakes. BUT, that's for later.
    generateImports();
    generateValueMapKeys();
    generateDropdownItemsMap();
    generateTextEditingControllerItemsMap();
    _generateFormMixin();
    _generateFormViewModelExtensions();

    return stringBuffer.toString();
  }

  void _generateFormMixin() {
    writeLine("mixin \$$viewName on StatelessWidget {");

    generateTextEditingControllersForTextFields();
    generateFocusNodesForTextFields();
    generateListenerRegistrationsForTextFields();
    generateFormDataUpdateFunctionTorTextControllers();
    generateDisposeForTextControllers();

    writeLine('}');
  }

  void _generateFormViewModelExtensions() {
    generateFormViewModelExtensionForGetters();
    generateFormViewModelExtensionForMethods();
  }
}
