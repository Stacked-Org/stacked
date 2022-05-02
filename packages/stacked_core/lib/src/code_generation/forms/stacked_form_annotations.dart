/// The annotation to be used for a view that contains a Form
class FormView {
  /// The list of form fields to generate
  final List<FormField>? fields;

  const FormView({this.fields});
}

/// Describes a form field to be generated
class FormField {
  /// The name of the form field. This will be used to generate the Key mapping
  final String? name;

  const FormField({this.name});
}

/// Describes an entry field on the form that takes text
class FormTextField extends FormField {
  /// Indicates if the [FormField] is a password field or not
  final bool? isPassword;

  /// Assigns initial value, `text` parameter in `TextEditingController`
  final String? initialValue;

  const FormTextField({
    String? name,
    this.isPassword,
    this.initialValue,
  }) : super(name: name);
}

/// Describes a date form field.
class FormDateField extends FormField {
  const FormDateField({String? name}) : super(name: name);
}

class FormDropdownField extends FormField {
  final List<StaticDropdownItem> items;
  const FormDropdownField({String? name, required this.items})
      : super(name: name);
}

class StaticDropdownItem {
  final String title;
  final String value;
  const StaticDropdownItem({required this.title, required this.value});
}
