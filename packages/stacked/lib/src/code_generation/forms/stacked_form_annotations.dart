/// The annotation to be used for a view that contains a Form
class FormView {
  /// The list of form fields to generate
  final List<FormField> fields;

  const FormView({this.fields});
}

/// Describes a single text form field to be generated
class FormField {
  /// The name of the form field. This will be used to generate the Key mapping
  final String name;

  /// Indicates if the [FormField] is a password field or not
  final bool isPassword;

  const FormField({this.name, this.isPassword});
}
