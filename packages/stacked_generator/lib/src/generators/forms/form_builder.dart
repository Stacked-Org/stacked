import 'package:recase/recase.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/forms/field_config.dart';
import 'package:stacked_generator/src/generators/forms/form_view_config.dart';

class FormBuilder with StringBufferUtils {
  final FormViewConfig formViewConfig;
  FormBuilder({required this.formViewConfig});

  List<FieldConfig> get fields => formViewConfig.fields;
  String get viewName => formViewConfig.viewName;
  bool get autoTextFieldValidation => formViewConfig.autoTextFieldValidation;

  FormBuilder addHeaderComment() {
    writeLine(
        "// ignore_for_file: public_member_api_docs,  constant_identifier_names, non_constant_identifier_names,unnecessary_this");
    return this;
  }

  FormBuilder addMixinSignature() {
    writeLine("mixin \$$viewName on StatelessWidget {");
    return this;
  }

  FormBuilder addClosingBracket() {
    writeLine('}');
    return this;
  }

  FormBuilder addImports() {
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

    return this;
  }

  FormBuilder addValueMapKeys() {
    newLine();
    for (var field in fields) {
      final caseName = ReCase(field.name);
      writeLine(
          "const String ${_getFormKeyName(caseName)} = '${caseName.camelCase}';");
    }
    newLine();

    return this;
  }

  FormBuilder addDropdownItemsMap() {
    newLine();
    for (final field in fields.onlyDropdownFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine(
        "final Map<String, String> ${caseName.pascalCase}ValueToTitleMap = {",
      );
      for (final item in field.items) {
        writeLine("'${item.value}': '${item.title}',");
      }
      writeLine('};');
    }
    newLine();
    return this;
  }

  FormBuilder addTextEditingControllerItemsMap() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
    newLine();
    writeLine(
        "final Map<String, TextEditingController> _${viewName}TextEditingControllers = {};");
    newLine();
    return this;
  }

  FormBuilder addFocusNodeItemsMap() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;

    newLine();
    writeLine("final Map<String, FocusNode> _${viewName}FocusNodes = {};");
    newLine();
    return this;
  }

  FormBuilder addValidationFunctionsFromAnnotation() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
    newLine();
    writeLine(
        "final Map<String, String? Function(String?)?> _${viewName}TextValidations = {");
    for (var field in fields.onlyTextFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine(
          "${_getFormKeyName(caseName)}: ${field.validatorFunction?.validatorName},");
    }
    writeLine("};");
    newLine();
    return this;
  }

  FormBuilder addTextEditingControllersForTextFields() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
    for (final field in fields.onlyTextFieldConfigs) {
      /// if the field needs a custom TextEditingController not a regular one
      if (field.customTextEditingController != null) {
        final caseName = ReCase(field.name);
        writeLine(
            '${field.customTextEditingController!.returnType} get ${_getControllerName(field)} => _getCustomFormTextEditingController(${_getFormKeyName(caseName)});');
        continue;
      }
      final caseName = ReCase(field.name);
      final initialValue = hasFieldInitialValue(field)
          ? ",initialValue: '${field.initialValue!}'"
          : '';
      writeLine(
          'TextEditingController get ${_getControllerName(field)} => _getFormTextEditingController(${_getFormKeyName(caseName)}$initialValue);');
    }
    return this;
  }

  FormBuilder addFocusNodesForTextFields() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
    for (final field in fields.onlyTextFieldConfigs) {
      final caseName = ReCase(field.name);
      writeLine(
          'FocusNode get ${_getFocusNodeName(field)} => _getFormFocusNode(${_getFormKeyName(caseName)});');
    }
    return this;
  }

  FormBuilder addGetTextEditinController() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
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
    return this;
  }

  FormBuilder addGetCustomTextEditingController() {
    final textFieldsConfigs = fields.onlyTextFieldConfigs
        .where((element) => element.customTextEditingController != null);

    /// If there is no field that has a [customTextEditingController]
    /// abort this function
    if (textFieldsConfigs.isEmpty) return this;
    for (var tf in textFieldsConfigs) {
      final customTextEditingClassNameAndCallingFunction =
          tf.customTextEditingController!.validatorName;
      final customTextEditingClassName =
          tf.customTextEditingController!.returnType;
      newLine();
      writeLine('''
      $customTextEditingClassName _getCustomFormTextEditingController(String key,) {
          if (_${viewName}TextEditingControllers.containsKey(key)) {
        return _${viewName}TextEditingControllers[key]! as $customTextEditingClassName;
      }
      _${viewName}TextEditingControllers[key] =
         $customTextEditingClassNameAndCallingFunction();
      return _${viewName}TextEditingControllers[key]! 
      as $customTextEditingClassName; }
    ''');
      newLine();
    }

    return this;
  }

  FormBuilder addGetFocuNode() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
    writeLine(''' 
      FocusNode _getFormFocusNode(String key) {
        if (_${viewName}FocusNodes.containsKey(key)) {
        return _${viewName}FocusNodes[key]!;}
        _${viewName}FocusNodes[key] = FocusNode();
      return _${viewName}FocusNodes[key]!;
      }
    ''');
    newLine();
    return this;
  }

  FormBuilder addListenerRegistrationsForTextFields() {
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
    return this;
  }

  FormBuilder addManualValidation() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
    writeLine(
        "final bool _autoTextFieldValidation = $autoTextFieldValidation;");
    writeLine("""
    bool validateFormFields(FormViewModel model) {
      _updateFormData(model, forceValidate: true);
      return model.isFormValid;
    }
    """);
    return this;
  }

  FormBuilder addFormDataUpdateFunctionTorTextControllers() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
    writeLine('''
        /// Updates the formData on the dynamic
        void _updateFormData(dynamic model, {bool forceValidate = false}) { model.setData(
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
    if (_autoTextFieldValidation || forceValidate) {
          _updateValidationData(model);}}
              ''');
    return this;
  }

  FormBuilder addValidationDataUpdateFunctionTorTextControllers() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
    writeLine('''
        /// Updates the fieldsValidationMessages on the dynamic
        void _updateValidationData(dynamic model) => model.setValidationMessages(
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
    return this;
  }

  FormBuilder addGetValidationMessageForTextController() {
    if (fields.onlyTextFieldConfigs.isEmpty) return this;
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
    return this;
  }

  FormBuilder addDisposeForTextControllers() {
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
    return this;
  }

  FormBuilder addFormViewModelExtensionForGetters() {
    newLine();
    writeLine('extension ValueProperties on FormViewModel {');
    writeLine("""bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);""");
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
    return this;
  }

  FormBuilder addFormViewModelExtensionForMethods() {
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
    return this;
  }

  bool hasFieldInitialValue(TextFieldConfig field) {
    return field.initialValue != null && field.initialValue!.isNotEmpty;
  }

  List<String> get validationFileImports {
    List<String> paths = [];
    for (var textFields in fields.onlyTextFieldConfigs) {
      if (textFields.validatorFunction?.validatorPath != null) {
        paths.add(textFields.validatorFunction!.validatorPath!);
      }
      if (textFields.customTextEditingController?.validatorPath != null) {
        paths.add(textFields.customTextEditingController!.validatorPath!);
      }
    }
    return paths;
  }

  String _getFormFieldValueType(FieldConfig field) {
    return field is TextFieldConfig || field is DropdownFieldConfig
        ? 'String'
        : 'DateTime';
  }

  String _getFocusNodeName(FieldConfig field) => '${field.name}FocusNode';
  String _getControllerName(FieldConfig field) => '${field.name}Controller';
  String _getFormKeyName(ReCase caseName) => '${caseName.pascalCase}ValueKey';
}
