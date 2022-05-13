import 'package:recase/recase.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';

class FormUtilService extends BaseGenerator {
  final FormViewConfig formViewConfig;
  FormUtilService({required this.formViewConfig});

  List<FieldConfig> get fields => formViewConfig.fields;
  String get viewName => formViewConfig.viewName;

  void generateImports() {
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

  void generateValueMapKeys() {
    newLine();
    for (var field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          "const String ${_getFormKeyName(caseName)} = '${caseName.camelCase}';");
    }
    newLine();
  }

  void generateDropdownItemsMap() {
    newLine();
    for (final field in fields.onlyDropdownFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine(
        "const Map<String, String> ${caseName.pascalCase}ValueToTitleMap = {",
      );
      for (final item in field.items) {
        writeLine("'${item.value}': '${item.title}',");
      }
      if (field.items.isNotEmpty) writeLine('};');
    }
    // if (fields.isNotEmpty) writeLine('};');
    newLine();
  }

  void generateTextEditingControllerItemsMap() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    newLine();
    writeLine(
        "final Map<String, TextEditingController> _${viewName}TextEditingControllers = {");
    for (var field in fields.onlyTextFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine(
          "${_getFormKeyName(caseName)}: TextEditingController(${_getControllerInitialValue(field)}),");
    }
    writeLine("};");
    newLine();
  }

  void generateTextEditingControllersForTextFields() {
    for (final field in fields.onlyTextFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine(
          'TextEditingController get ${_getControllerName(field)} => _${viewName}TextEditingControllers[${_getFormKeyName(caseName)}]!;');
    }
  }

  void generateFocusNodesForTextFields() {
    for (final field in fields.onlyTextFieldConfigs) {
      writeLine('final FocusNode ${field.name}FocusNode = FocusNode();');
    }
  }

  void generateListenerRegistrationsForTextFields() {
    writeLine('''
              /// Registers a listener on every generated controller that calls [model.setData()]
              /// with the latest textController values
              void listenToFormUpdated(FormViewModel model) {
            ''');

    for (final field in fields.onlyTextFieldConfigs) {
      writeLine(
          '${_getControllerName(field)}.addListener(() => _updateFormData(model));');
    }
    writeLine('}');
    newLine();
  }

  void generateFormDataUpdateFunctionTorTextControllers() {
    writeLine('''
        /// Updates the formData on the FormViewModel
        void _updateFormData(FormViewModel model) => model.setData(
              model.formValueMap
                ..addAll({
            ''');

    for (final field in fields.onlyTextFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine(
          '${_getFormKeyName(caseName)}: ${_getControllerName(field)}.text,');
    }

    writeLine('''
              }),
          );
              ''');
  }

  void generateDisposeForTextControllers() {
    newLine();
    writeLine('''
      /// Calls dispose on all the generated controllers and focus nodes
      void disposeForm() {
        // The dispose function for a TextEditingController sets all listeners to null
          ''');

    for (final field in fields.onlyTextFieldConfigs) {
      writeLine('${_getControllerName(field)}.dispose();');
      writeLine('${_getFocusNodeName(field)}.dispose();');
    }

    writeLine('}');
  }

  void generateFormViewModelExtensionForGetters() {
    newLine();
    writeLine('extension ValueProperties on FormViewModel {');
    for (final field in fields) {
      final caseName = ReCase(field.name);
      final type = _getFormFieldValueType(field);
      writeLine(
          '$type? get ${caseName.camelCase}Value => this.formValueMap[${_getFormKeyName(caseName)}] as $type?;');
    }

    // Generate the getters that check whether a field is set or not
    newLine();
    for (final field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          'bool get has${caseName.pascalCase} => this.formValueMap.containsKey(${_getFormKeyName(caseName)});');
    }

    // Generate the getters that check whether a field has validation message or not
    newLine();
    for (final field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          'bool get has${caseName.pascalCase}ValidationMessage => this.fieldsValidationMessages[${_getFormKeyName(caseName)}]?.isNotEmpty ?? false;');
    }

    // Generate the getters that retrieve validation message
    newLine();
    for (final field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          'String? get ${caseName.camelCase}ValidationMessage => this.fieldsValidationMessages[${_getFormKeyName(caseName)}];');
    }

    writeLine('}');
  }

  void generateFormViewModelExtensionForMethods() {
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

    // Generate the setters for all fields validation message
    newLine();
    for (final field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          'set${caseName.pascalCase}ValidationMessage(String? validationMessage) => this.fieldsValidationMessages[${_getFormKeyName(caseName)}] = validationMessage;');
    }

    writeLine('}');
  }

  String _getFormFieldValueType(FieldConfig field) {
    return field is TextFieldConfig || field is DropdownFieldConfig
        ? 'String'
        : 'DateTime';
  }

  String _getFocusNodeName(FieldConfig field) => '${field.name}FocusNode';
  String _getControllerName(FieldConfig field) => '${field.name}Controller';
  String _getControllerInitialValue(TextFieldConfig field) =>
      field.initialValue != null ? "text:'${field.initialValue!}'" : "";
  String _getFormKeyName(ReCase caseName) => '${caseName.pascalCase}ValueKey';
}
