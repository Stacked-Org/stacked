import 'package:recase/recase.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';

class FormGeneratorUtil extends BaseGenerator {
  final FormViewConfig formViewConfig;
  FormGeneratorUtil({required this.formViewConfig});

  List<FieldConfig> get fields => formViewConfig.fields;
  String get viewName => formViewConfig.viewName;

  @override
  String generate() {
    writeLine(
        "// ignore_for_file: public_member_api_docs,  constant_identifier_names, non_constant_identifier_names,unnecessary_this");

    generateImports();
    generateValueMapKeys();
    generateDropdownItemsMap();
    generateTextEditingControllerItemsMap();
    generateFocusNodeItemsMap();
    generateValidationFunctionsFromAnnotation();
    generateFormMixin();
    generateFormViewModelExtensions();
    return serializeStringBuffer;
  }

  void generateFormMixin() {
    writeLine("mixin \$${viewName} on StatelessWidget {");

    generateTextEditingControllersForTextFields();
    generateFocusNodesForTextFields();
    generateGetTextEditinController();
    generateGetFocuNode();
    generateListenerRegistrationsForTextFields();
    generateFormDataUpdateFunctionTorTextControllers();
    generateValidationDataUpdateFunctionTorTextControllers();
    generateGetValidationMessageForTextController();
    generateDisposeForTextControllers();

    writeLine('}');
  }

  void generateFormViewModelExtensions() {
    generateFormViewModelExtensionForGetters();
    generateFormViewModelExtensionForMethods();
  }

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
    packageImports.addAll(validationFileImports);
    sortAndGenerate(packageImports);
    newLine();

    var rest = validImports.difference({...dartImports, ...packageImports});
    sortAndGenerate(rest);
    newLine();
  }

  List<String> get validationFileImports {
    List<String> paths = [];
    for (var textFields in fields.onlyTextFieldConfigs) {
      if (textFields.validatorPath != null) {
        paths.add(textFields.validatorPath!);
      }
    }
    return paths;
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
    newLine();
  }

  void generateTextEditingControllerItemsMap() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    newLine();
    writeLine(
        "final Map<String, TextEditingController> _${viewName}TextEditingControllers = {};");
    newLine();
  }

  void generateFocusNodeItemsMap() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    newLine();
    writeLine("final Map<String, FocusNode> _${viewName}FocusNodes = {};");
    newLine();
  }

  void generateValidationFunctionsFromAnnotation() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    newLine();
    writeLine(
        "final Map<String, String? Function(String?)?> _${viewName}TextValidations = {");
    for (var field in fields.onlyTextFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine("${_getFormKeyName(caseName)}: ${field.validatorName},");
    }
    writeLine("};");
    newLine();
  }

  void generateTextEditingControllersForTextFields() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    for (final field in fields.onlyTextFieldConfigs) {
      final caseName = ReCase(field.name);
      final initialValue = hasFieldInitialValue(field)
          ? ",initialValue: '${field.initialValue!}'"
          : '';
      writeLine(
          'TextEditingController get ${_getControllerName(field)} => _getFormTextEditingController(${_getFormKeyName(caseName)}$initialValue);');
    }
  }

  void generateFocusNodesForTextFields() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    for (final field in fields.onlyTextFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine(
          'FocusNode get ${_getFocusNodeName(field)} => _getFormFocusNode(${_getFormKeyName(caseName)});');
    }
  }

  void generateGetTextEditinController() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    newLine();
    writeLine(''' 
      TextEditingController _getFormTextEditingController(String key,
        {String? initialValue}) {
          if (_${viewName}TextEditingControllers.containsKey(key)) {
        return _${viewName}TextEditingControllers[key]!;
      }
      _${viewName}TextEditingControllers[key] =
          TextEditingController(text: initialValue);
      return _${viewName}TextEditingControllers[key]!; }
    ''');
    newLine();
  }

  void generateGetFocuNode() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    writeLine(''' 
      FocusNode _getFormFocusNode(String key) {
        if (_${viewName}FocusNodes.containsKey(key)) {
        return _${viewName}FocusNodes[key]!;}
        _${viewName}FocusNodes[key] = FocusNode();
      return _${viewName}FocusNodes[key]!;
      }
    ''');
    newLine();
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
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    writeLine('''
        /// Updates the formData on the FormViewModel
        void _updateFormData(FormViewModel model) { model.setData(
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
          _updateValidationData(model);}
              ''');
  }

  void generateValidationDataUpdateFunctionTorTextControllers() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    writeLine('''
        /// Updates the fieldsValidationMessages on the FormViewModel
        void _updateValidationData(FormViewModel model) => model.setValidationMessages(
              {
            ''');

    for (final field in fields.onlyTextFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine(
          '${_getFormKeyName(caseName)}: _getValidationMessage(${_getFormKeyName(caseName)}),');
    }
    writeLine('''
              }
          );
              ''');
  }

  void generateGetValidationMessageForTextController() {
    if (fields.onlyTextFieldConfigs.isEmpty) return;
    writeLine('''
        /// Returns the validation message for the given key
        String? _getValidationMessage(String key) {
      final validatorForKey = _${viewName}TextValidations[key];
      if (validatorForKey == null) return null;
      String? validationMessageForKey =
            validatorForKey(_${viewName}TextEditingControllers[key]!.text);
      return validationMessageForKey;
      }
    ''');
  }

  void generateDisposeForTextControllers() {
    newLine();
    writeLine('''
      /// Calls dispose on all the generated controllers and focus nodes
      void disposeForm() {
        // The dispose function for a TextEditingController sets all listeners to null
          ''');
    if (fields.onlyTextFieldConfigs.isNotEmpty) {
      writeLine('''
      for (var controller in _${viewName}TextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _${viewName}FocusNodes.values) {
      focusNode.dispose();
    }
    ''');
      writeLine('_${viewName}TextEditingControllers.clear();');
      writeLine('_${viewName}FocusNodes.clear();');
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

  bool hasFieldInitialValue(TextFieldConfig field) {
    return field.initialValue != null && field.initialValue!.isNotEmpty;
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
