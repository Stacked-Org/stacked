import 'package:analyzer/dart/element/element.dart';

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
  final ExecutableElementData? validatorFunction;
  final ExecutableElementData? customTextEditingController;
  const TextFieldConfig({
    required String name,
    this.initialValue,
    this.validatorFunction,
    this.customTextEditingController,
  }) : super(name: name);
}

class DateFieldConfig extends FieldConfig {
  const DateFieldConfig({required String name}) : super(name: name);
}

class DropdownFieldConfig extends FieldConfig {
  final List<DropdownFieldItem> items;
  const DropdownFieldConfig({required String name, required this.items})
      : super(name: name);
}

class DropdownFieldItem {
  final String title;
  final String value;

  const DropdownFieldItem({required this.title, required this.value});
}

class ExecutableElementData {
  final String? validatorPath;
  final String? validatorName;
  final String? enclosingElementName;
  final bool hasEnclosingElementName;
  final String? returnType;
  const ExecutableElementData({
    this.validatorPath,
    this.validatorName,
    this.enclosingElementName,
    this.hasEnclosingElementName = false,
    this.returnType,
  });

  factory ExecutableElementData.fromExecutableElement(
      ExecutableElement executableElement) {
    return ExecutableElementData(
        returnType: executableElement.declaration.returnType.toString(),
        enclosingElementName: executableElement.enclosingElementName,
        hasEnclosingElementName: executableElement.hasEnclosingElementName,
        validatorName: executableElement.validatorName,
        validatorPath: executableElement.validatorPath);
  }
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

extension ExecutableElementDataExtension on ExecutableElement? {
  String? get validatorPath => this?.source.uri.toString();
  String? get validatorName => hasEnclosingElementName
      ? '${enclosingElementName}.${this?.name}'
      : this?.name;
  bool get hasEnclosingElementName => enclosingElementName != null;
  String? get enclosingElementName => this?.enclosingElement.name;
}
