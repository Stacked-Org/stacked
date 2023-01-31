import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';

/// Described the Dialog functionality to generate in the app
class DialogConfig {
  final String import;
  final String dialogClassName;

  const DialogConfig({
    required this.import,
    required this.dialogClassName,
  });

  /// Returns enum value of DialogType
  String get enumValue {
    // The length of class name without DIALOG word
    final wl = dialogClassName.length - 6;
    final className = dialogClassName.toLowerCamelCase;

    if (className.endsWith('Dialog')) {
      return className.substring(0, wl);
    }

    return className;
  }
}
