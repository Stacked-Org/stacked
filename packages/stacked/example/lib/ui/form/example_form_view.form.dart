// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';
const String BirthDateValueKey = 'birthDate';

mixin $ExampleFormView on StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            EmailValueKey: emailController.text,
            PasswordValueKey: passwordController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    emailController.dispose();
    passwordController.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String get emailValue => this.formValueMap[EmailValueKey];
  String get passwordValue => this.formValueMap[PasswordValueKey];
  DateTime get birthDateValue => this.formValueMap[BirthDateValueKey];

  bool get hasEmail => this.formValueMap.containsKey(EmailValueKey);
  bool get hasPassword => this.formValueMap.containsKey(PasswordValueKey);
  bool get hasBirthDate => this.formValueMap.containsKey(BirthDateValueKey);
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
}
