/// Described a single field to be generated.
///
/// TODO: Think about different field types like drop down, image selection,
/// date pickers etc.
class FieldConfig {
  /// The name of the form field. This will be used to generate the Key mapping
  final String name;

  const FieldConfig({required this.name});
}
