class FormValidators {
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password should not be empty";
    }

    if (value.length < 6) {
      return "Password must has at least 6 alpha characters";
    }

    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!value.contains('@')) {
      return 'Email is not valid';
    }

    return null;
  }
}
