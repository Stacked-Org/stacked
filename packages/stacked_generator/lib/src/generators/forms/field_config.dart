/// Described a single field to be generated.
///
/// TODO: Think about different field types like drop down, image selection,
/// date pickers etc.
abstract class FieldConfig {
  /// The name of the form field. This will be used to generate the Key mapping
  final String name;

  const FieldConfig({required this.name});
}

class TextFieldConfig extends FieldConfig {
  final String? initialValue;
  const TextFieldConfig({
    required String name,
    this.initialValue,
  }) : super(name: name);
}

class DateFieldConfig extends FieldConfig {
  DateFieldConfig({required String name}) : super(name: name);
}

class DropdownFieldConfig extends FieldConfig {
  final List<DropdownFieldItem> items;
  const DropdownFieldConfig({required String name, required this.items})
      : super(name: name);
}

class DropdownFieldItem {
  final String title;
  final String value;

  DropdownFieldItem({required this.title, required this.value});
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

  List<DropdownFieldConfig> get onlyDropdownFieldConfigs => this
      .where((fieldConfig) => fieldConfig is DropdownFieldConfig)
      .map((t) => t as DropdownFieldConfig)
      .toList();
}
