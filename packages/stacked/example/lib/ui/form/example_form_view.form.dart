// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
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

mixin $ExampleFormView on StatelessWidget {
  final TextEditingController emailController =
      TextEditingController(text: 'Lorem');
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController shortBioController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode shortBioFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    shortBioController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            EmailValueKey: emailController.text,
            PasswordValueKey: passwordController.text,
            ShortBioValueKey: shortBioController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    emailController.dispose();
    emailFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    shortBioController.dispose();
    shortBioFocusNode.dispose();
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
