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
    _generateDropdownItemsList(fields.onlyDropdownFieldConfigs);
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

  void _generateDropdownItemsList(List<DropdownFieldConfig> fields) {
    newLine();
    for (var field in fields) {
      final caseName = ReCase(field.name);
      writeLine("const List<String> ${caseName.pascalCase}Values = [");
      for (final item in field.items) {
        writeLine("'$item',");
      }
    }
    writeLine('];');
    newLine();
  }

  void _generateImports() {
    // write route imports
    final imports = <String>{
      "package:flutter/material.dart",
      "package:stacked/stacked.dart"
    };

    var validImports = imports.toSet();
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

    _generateTextEdittingControllersForTextFields(fields.onlyTextFieldConfigs);
    _generateFocusNodesForTextFields(fields.onlyTextFieldConfigs);
    _generateListenerRegistrationsForTextFields(fields.onlyTextFieldConfigs);
    _generateFormDataUpdateFunctionTorTextControllers(
        fields.onlyTextFieldConfigs);
    _generateDisposeForTextControllers(fields.onlyTextFieldConfigs);

    writeLine('}');
  }

  void _generateTextEdittingControllersForTextFields(
      List<TextFieldConfig> fields) {
    for (final field in fields) {
      writeLine(
          'final TextEditingController ${_getControllerName(field)} = TextEditingController();');
    }
  }

  void _generateFocusNodesForTextFields(List<TextFieldConfig> fields) {
    for (final field in fields) {
      writeLine('final FocusNode ${field.name}FocusNode = FocusNode();');
    }
  }

  void _generateListenerRegistrationsForTextFields(
      List<TextFieldConfig> fields) {
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

  void _generateFormDataUpdateFunctionTorTextControllers(
      List<TextFieldConfig> fields) {
    writeLine('''
        /// Updates the formData on the FormViewModel
        void _updateFormData(FormViewModel model) => model.setData(
              model.formValueMap
                ..addAll({
            ''');

    for (final field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          '${_getFormKeyName(caseName)}: ${_getControllerName(field)}.text,');
    }

    writeLine('''
              }),
          );
              ''');
  }

  void _generateDisposeForTextControllers(List<TextFieldConfig> fields) {
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
    _generateFormViewModelExtensionForGetters(fields);
    _generateFormViewModelExtensionForMethods(fields);
  }

  void _generateFormViewModelExtensionForGetters(List<FieldConfig> fields) {
    newLine();
    writeLine('extension ValueProperties on FormViewModel {');
    for (final field in fields) {
      final caseName = ReCase(field.name);
      final type = _getFormFieldValueType(field);
      writeLine(
          '$type get ${caseName.camelCase}Value => this.formValueMap[${_getFormKeyName(caseName)}];');
    }

    // Generate the getters that check whether a field is set or not
    newLine();
    newLine();
    for (final field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          'bool get has${caseName.pascalCase} => this.formValueMap.containsKey(${_getFormKeyName(caseName)});');
    }

    writeLine('}');
  }

  void _generateFormViewModelExtensionForMethods(List<FieldConfig> fields) {
    newLine();
    writeLine('extension Methods on FormViewModel {');

    // Generate the date pickers
    for (final field in fields.onlyDateFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine('''
          Future<void> select${caseName.pascalCase}(
              {required BuildContext context,
              required DateTime initialDate,
              required DateTime firstDate,
              required DateTime lastDate}) async {
            final selectedDate = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: firstDate,
                lastDate: lastDate);
            if (selectedDate != null) {
              this.setData(
                  this.formValueMap..addAll({${_getFormKeyName(caseName)}: selectedDate}));
            }
          }
    ''');
      newLine();
    }

    // Generate the drop down selected item setter
    for (final field in fields.onlyDropdownFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine('''
          void set${caseName.pascalCase}(String ${caseName.camelCase}) {
            this.setData(this.formValueMap..addAll({${_getFormKeyName(caseName)}: ${caseName.camelCase}}));
          }
    ''');
      newLine();
    }

    writeLine('}');
  }

  String _getFormFieldValueType(FieldConfig field) {
    return field is TextFieldConfig || field is DropdownFieldConfig
        ? 'String'
        : 'DateTime';
  }

  String _getControllerName(FieldConfig field) => '${field.name}Controller';

  String _getFormKeyName(ReCase caseName) => '${caseName.pascalCase}ValueKey';
}
