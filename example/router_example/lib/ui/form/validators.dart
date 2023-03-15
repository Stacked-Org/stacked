class FormValidators {
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password should not be empty";
    } else {
      return null;
    }
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }
}
