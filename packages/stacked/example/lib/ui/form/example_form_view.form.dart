// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs,  constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:new_architecture/ui/form/validators.dart';
import 'package:stacked/stacked.dart';

const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';
const String ShortBioValueKey = 'shortBio';
const String BirthDateValueKey = 'birthDate';
const String DoYouLoveFoodValueKey = 'doYouLoveFood';

const Map<String, String> DoYouLoveFoodValueToTitleMap = {
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

mixin $ExampleFormView on StatelessWidget {
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey, initialValue: 'Lorem');
  TextEditingController get passwordController =>
      _getFormTextEditingController(PasswordValueKey);
  TextEditingController get shortBioController =>
      _getFormTextEditingController(ShortBioValueKey);
  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);
  FocusNode get shortBioFocusNode => _getFormFocusNode(ShortBioValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_ExampleFormViewTextEditingControllers.containsKey(key)) {
      return _ExampleFormViewTextEditingControllers[key]!;
    }
    _ExampleFormViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ExampleFormViewTextEditingControllers[key]!;
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
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    shortBioController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) {
    model.setData(
      model.formValueMap
        ..addAll({
          EmailValueKey: emailController.text,
          PasswordValueKey: passwordController.text,
          ShortBioValueKey: shortBioController.text,
        }),
    );
    _updateValidationData(model);
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        EmailValueKey: _getValidationMessage(EmailValueKey),
        PasswordValueKey: _getValidationMessage(PasswordValueKey),
        ShortBioValueKey: _getValidationMessage(ShortBioValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _ExampleFormViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_ExampleFormViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
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
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;
  String? get shortBioValue => this.formValueMap[ShortBioValueKey] as String?;
  DateTime? get birthDateValue =>
      this.formValueMap[BirthDateValueKey] as DateTime?;
  String? get doYouLoveFoodValue =>
      this.formValueMap[DoYouLoveFoodValueKey] as String?;

  bool get hasEmail => this.formValueMap.containsKey(EmailValueKey);
  bool get hasPassword => this.formValueMap.containsKey(PasswordValueKey);
  bool get hasShortBio => this.formValueMap.containsKey(ShortBioValueKey);
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
  Future<void> selectBirthDate(
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
          this.formValueMap..addAll({BirthDateValueKey: selectedDate}));
    }
  }

  void setDoYouLoveFood(String doYouLoveFood) {
    this.setData(
        this.formValueMap..addAll({DoYouLoveFoodValueKey: doYouLoveFood}));
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
}
