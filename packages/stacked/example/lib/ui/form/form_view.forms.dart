import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:new_architecture/ui/form/base_form_viewmodel.dart';
import 'package:new_architecture/ui/form/form_viewmodel.dart';

const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';

// NOTE: a Mixin seems to work fine for the controllers
mixin $FormView on StatelessWidget {
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
        {
          EmailValueKey: emailController.text,
          PasswordValueKey: passwordController.text,
        },
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }
}

extension ValueProperties on BaseFormViewModel {
  String get emailValue => this.formValueMap[EmailValueKey];
  String get passwordValue => this.formValueMap[PasswordValueKey];
}
