import 'field_config.dart';

/// Described the configuration to use for generating the forms
class FormViewConfig {
  /// The name of the view that has the [FormView] annotation on it
  final String viewName;

  /// Contains a list of configs to use when generating the form data
  final List<FieldConfig> fields;

  FormViewConfig({this.viewName, this.fields});
}
