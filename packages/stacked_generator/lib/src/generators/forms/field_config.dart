/// Described a single field to be generated.
///
/// TODO: Think about different field types like drop down, image selection,
/// date pickers etc.
abstract class FieldConfig {
  /// The name of the form field. This will be used to generate the Key mapping
  final String name;

  const FieldConfig({this.name});
}

class TextFieldConfig extends FieldConfig {
  /// Indicates if the field is a password field or not
  final bool isPassword;

  const TextFieldConfig({String name, this.isPassword}) : super(name: name);
}

class DateFieldConfig extends FieldConfig {
  DateFieldConfig({String name}) : super(name: name);
}

extension ListOfFieldConfigs on List<FieldConfig> {
  List<TextFieldConfig> get onlyTextFieldConfigs => this
      .where((fieldConfig) => fieldConfig is TextFieldConfig)
      .map((t) => t as TextFieldConfig)
      .toList();

  List<DateFieldConfig> get onlyDateFieldConfigs => this
      .where((fieldConfig) => fieldConfig is DateFieldConfig)
      .map((t) => t as DateFieldConfig)
      .toList();
}
