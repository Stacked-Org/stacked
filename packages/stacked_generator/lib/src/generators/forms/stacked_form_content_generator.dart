import 'package:recase/recase.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';

/// A generator that creates the form code based on the configs passed in
class StackedFormContentGenerator extends BaseGenerator {
  final FormViewConfig _formViewConfig;

  StackedFormContentGenerator(this._formViewConfig);

  String generate() {
    writeLine("// ignore_for_file: public_member_api_docs");

    final fields = _formViewConfig.fields;

    // TODO: All of these functions can be moved into a separate util class or service
    // and can then be unit tested to avoid simple mistakes. BUT, that's for later.
    _generateImports();
    _generateValueMapKeys(fields);
    _generateFormMixin();
    _generateFormViewModelExtensions(fields);

    return stringBuffer.toString();
  }

  void _generateValueMapKeys(List<FieldConfig> fields) {
    newLine();
    for (var field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          "const String ${_getFormKeyName(caseName)} = '${caseName.camelCase}';");
    }
    newLine();
  }

  void _generateImports() {
    // write route imports
    final imports = <String>{
      "package:flutter/material.dart",
      "package:stacked/stacked.dart"
    };

    var validImports = imports.where((import) => import != null).toSet();
    var dartImports =
        validImports.where((element) => element.startsWith('dart')).toSet();
    sortAndGenerate(dartImports);
    newLine();

    var packageImports =
        validImports.where((element) => element.startsWith('package')).toSet();
    sortAndGenerate(packageImports);
    newLine();

    var rest = validImports.difference({...dartImports, ...packageImports});
    sortAndGenerate(rest);
    newLine();
  }

  void _generateFormMixin() {
    final fields = _formViewConfig.fields;
    final formName = _formViewConfig.viewName;
    writeLine("mixin \$$formName on StatelessWidget {");

    _generateTextEdittingControllers(fields);
    _generateFocusNodes(fields);
    _generateListenerRegistrations(fields);
    _generateFormDataUpdateFunction(fields);
    _generateDisposeForControllers(fields);

    writeLine('}');
  }

  void _generateTextEdittingControllers(List<FieldConfig> fields) {
    for (final field in fields) {
      writeLine(
          'final TextEditingController ${_getControllerName(field)} = TextEditingController();');
    }
  }

  void _generateFocusNodes(List<FieldConfig> fields) {
    for (final field in fields) {
      writeLine('final FocusNode ${field.name}FocusNode = FocusNode();');
    }
  }

  void _generateListenerRegistrations(List<FieldConfig> fields) {
    writeLine('''
              /// Registers a listener on every generated controller that calls [model.setData()]
              /// with the latest textController values
              void listenToFormUpdated(FormViewModel model) {
            ''');

    for (final field in fields) {
      writeLine(
          '${_getControllerName(field)}.addListener(() => _updateFormData(model));');
    }
    writeLine('}');
    newLine();
  }

  void _generateFormDataUpdateFunction(List<FieldConfig> fields) {
    writeLine('''
        /// Updates the formData on the FormViewModel
        void _updateFormData(FormViewModel model) => model.setData(
              {
            ''');

    for (final field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          '${_getFormKeyName(caseName)}: ${_getControllerName(field)}.text,');
    }

    writeLine('''
                },
              );
              ''');
  }

  void _generateDisposeForControllers(List<FieldConfig> fields) {
    newLine();
    writeLine('''
      /// Calls dispose on all the generated controllers and focus nodes
      void disposeForm() {
        // The dispose function for a TextEditingController sets all listeners to null
          ''');

    for (final field in fields) {
      writeLine('${_getControllerName(field)}.dispose();');
    }

    writeLine('}');
  }

  void _generateFormViewModelExtensions(List<FieldConfig> fields) {
    newLine();
    writeLine('extension ValueProperties on FormViewModel {');
    for (final field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          'String get ${caseName.camelCase}Value => this.formValueMap[${_getFormKeyName(caseName)}];');
    }
    writeLine('}');
  }

  String _getControllerName(FieldConfig field) => '${field.name}Controller';

  String _getFormKeyName(ReCase caseName) => '${caseName.pascalCase}ValueKey';
}
