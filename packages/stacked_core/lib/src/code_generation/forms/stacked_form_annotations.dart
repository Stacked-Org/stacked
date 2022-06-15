/// The annotation to be used for a view that contains a Form
class FormView {
  /// The list of form fields to generate
  final List<FormField>? fields;

  /// A flag to enable/disable auto validation of text fields. defauls to `true`
  final bool autoTextFieldValidation;
  const FormView({
    this.fields,
    this.autoTextFieldValidation = true,
  });
}

/// Describes a form field to be generated
class FormField {
  /// The name of the form field. This will be used to generate the Key mapping
  final String? name;

  const FormField({this.name});
}

/// Describes an entry field on the form that takes text
class FormTextField extends FormField {
  /// Assigns initial value, `text` parameter in `TextEditingController`
  final String? initialValue;

  final String? Function(String?)? validator;

  /// Replace the default flutter [TextEditingController] with
  /// another controller that extends the [TextEditingController]
  ///
  /// When providing this field [initialValue] will be ignored
  final dynamic Function()? customTextEditingController;
  final bool autoTextFieldValidation;

  const FormTextField({
    String? name,
    this.initialValue,
    this.validator,
    this.customTextEditingController,
    this.autoTextFieldValidation = true,
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
