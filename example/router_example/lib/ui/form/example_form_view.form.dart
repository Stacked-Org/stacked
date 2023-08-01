// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:example/ui/form/custom_text_field.dart';
import 'package:example/ui/form/validators.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';
const String ShortBioValueKey = 'shortBio';
const String BirthDateValueKey = 'birthDate';
const String DoYouLoveFoodValueKey = 'doYouLoveFood';

final Map<String, String> DoYouLoveFoodValueToTitleMap = {
  'YesDr': 'Yes',
  'NoDr': 'No',
};

final Map<String, TextEditingController>
    _ExampleFormViewTextEditingControllers = {};

final Map<String, FocusNode> _ExampleFormViewFocusNodes = {};

final Map<String, String? Function(String?)?> _ExampleFormViewTextValidations =
    {
  EmailValueKey: FormValidators.emailValidator,
  PasswordValueKey: FormValidators.passwordValidator,
  ShortBioValueKey: null,
};

mixin $ExampleFormView {
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey, initialValue: 'Lorem');
  CustomEditingController get passwordController =>
      _getPasswordCustomFormTextEditingController(PasswordValueKey);
  CustomEditingController get shortBioController =>
      _getShortBioCustomFormTextEditingController(ShortBioValueKey);

  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);
  FocusNode get shortBioFocusNode => _getFormFocusNode(ShortBioValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_ExampleFormViewTextEditingControllers.containsKey(key)) {
      return _ExampleFormViewTextEditingControllers[key]!;
    }

    _ExampleFormViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ExampleFormViewTextEditingControllers[key]!;
  }

  CustomEditingController _getPasswordCustomFormTextEditingController(
    String key,
  ) {
    if (_ExampleFormViewTextEditingControllers.containsKey(key)) {
      return _ExampleFormViewTextEditingControllers[key]!
          as CustomEditingController;
    }
    _ExampleFormViewTextEditingControllers[key] =
        CustomEditingController.getCustomEditingController();
    return _ExampleFormViewTextEditingControllers[key]!
        as CustomEditingController;
  }

  CustomEditingController _getShortBioCustomFormTextEditingController(
    String key,
  ) {
    if (_ExampleFormViewTextEditingControllers.containsKey(key)) {
      return _ExampleFormViewTextEditingControllers[key]!
          as CustomEditingController;
    }
    _ExampleFormViewTextEditingControllers[key] =
        CustomEditingController.getCustomEditingController();
    return _ExampleFormViewTextEditingControllers[key]!
        as CustomEditingController;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ExampleFormViewFocusNodes.containsKey(key)) {
      return _ExampleFormViewFocusNodes[key]!;
    }
    _ExampleFormViewFocusNodes[key] = FocusNode();
    return _ExampleFormViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    shortBioController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    shortBioController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          EmailValueKey: emailController.text,
          PasswordValueKey: passwordController.text,
          ShortBioValueKey: shortBioController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _ExampleFormViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ExampleFormViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ExampleFormViewTextEditingControllers.clear();
    _ExampleFormViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;
  String? get shortBioValue => this.formValueMap[ShortBioValueKey] as String?;
  DateTime? get birthDateValue =>
      this.formValueMap[BirthDateValueKey] as DateTime?;
  String? get doYouLoveFoodValue =>
      this.formValueMap[DoYouLoveFoodValueKey] as String?;

  set emailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailValueKey: value}),
    );

    if (_ExampleFormViewTextEditingControllers.containsKey(EmailValueKey)) {
      _ExampleFormViewTextEditingControllers[EmailValueKey]?.text = value ?? '';
    }
  }

  set passwordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PasswordValueKey: value}),
    );

    if (_ExampleFormViewTextEditingControllers.containsKey(PasswordValueKey)) {
      _ExampleFormViewTextEditingControllers[PasswordValueKey]?.text =
          value ?? '';
    }
  }

  set shortBioValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ShortBioValueKey: value}),
    );

    if (_ExampleFormViewTextEditingControllers.containsKey(ShortBioValueKey)) {
      _ExampleFormViewTextEditingControllers[ShortBioValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);
  bool get hasPassword =>
      this.formValueMap.containsKey(PasswordValueKey) &&
      (passwordValue?.isNotEmpty ?? false);
  bool get hasShortBio =>
      this.formValueMap.containsKey(ShortBioValueKey) &&
      (shortBioValue?.isNotEmpty ?? false);
  bool get hasBirthDate => this.formValueMap.containsKey(BirthDateValueKey);
  bool get hasDoYouLoveFood =>
      this.formValueMap.containsKey(DoYouLoveFoodValueKey);

  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;
  bool get hasShortBioValidationMessage =>
      this.fieldsValidationMessages[ShortBioValueKey]?.isNotEmpty ?? false;
  bool get hasBirthDateValidationMessage =>
      this.fieldsValidationMessages[BirthDateValueKey]?.isNotEmpty ?? false;
  bool get hasDoYouLoveFoodValidationMessage =>
      this.fieldsValidationMessages[DoYouLoveFoodValueKey]?.isNotEmpty ?? false;

  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
  String? get shortBioValidationMessage =>
      this.fieldsValidationMessages[ShortBioValueKey];
  String? get birthDateValidationMessage =>
      this.fieldsValidationMessages[BirthDateValueKey];
  String? get doYouLoveFoodValidationMessage =>
      this.fieldsValidationMessages[DoYouLoveFoodValueKey];
}

extension Methods on FormViewModel {
  Future<void> selectBirthDate({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null) {
      this.setData(
        this.formValueMap..addAll({BirthDateValueKey: selectedDate}),
      );
    }

    if (_autoTextFieldValidation) {
      this.validateForm();
    }
  }

  void setDoYouLoveFood(String doYouLoveFood) {
    this.setData(
      this.formValueMap..addAll({DoYouLoveFoodValueKey: doYouLoveFood}),
    );

    if (_autoTextFieldValidation) {
      this.validateForm();
    }
  }

  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;
  setShortBioValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ShortBioValueKey] = validationMessage;
  setBirthDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BirthDateValueKey] = validationMessage;
  setDoYouLoveFoodValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DoYouLoveFoodValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    emailValue = '';
    passwordValue = '';
    shortBioValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ShortBioValueKey: getValidationMessage(ShortBioValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _ExampleFormViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _ExampleFormViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormViewModel model) => model.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ShortBioValueKey: getValidationMessage(ShortBioValueKey),
    });
