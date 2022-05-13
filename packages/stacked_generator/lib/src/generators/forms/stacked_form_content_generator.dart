import 'package:stacked_generator/src/generators/forms/form_generator_util.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';

/// A generator that creates the form code based on the configs passed in
class StackedFormContentGenerator {
  final FormViewConfig _formViewConfig;
  StackedFormContentGenerator(this._formViewConfig) : super();

  late FormGeneratorUtil _util;

  String generate() {
    _util = FormGeneratorUtil(formViewConfig: _formViewConfig);
    _util.writeLine("// ignore_for_file: public_member_api_docs");

    _util.generateImports();
    _util.generateValueMapKeys();
    _util.generateDropdownItemsMap();
    _util.generateTextEditingControllerItemsMap();
    _generateFormMixin();
    _generateFormViewModelExtensions();

    return _util.stringBuffer.toString();
  }

  void _generateFormMixin() {
    _util.writeLine("mixin \$${_util.viewName} on StatelessWidget {");

    _util.generateTextEditingControllersForTextFields();
    _util.generateFocusNodesForTextFields();
    _util.generateListenerRegistrationsForTextFields();
    _util.generateFormDataUpdateFunctionTorTextControllers();
    _util.generateDisposeForTextControllers();

    _util.writeLine('}');
  }

  void _generateFormViewModelExtensions() {
    _util.generateFormViewModelExtensionForGetters();
    _util.generateFormViewModelExtensionForMethods();
  }
}
