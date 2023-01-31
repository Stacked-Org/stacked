import 'package:stacked_generator/src/generators/extensions/string_utils_extension.dart';

/// Described the Dialog functionality to generate in the app
class BottomsheetConfig {
  final String import;
  final String bottomsheetClassName;

  const BottomsheetConfig({
    required this.import,
    required this.bottomsheetClassName,
  });

  /// Returns enum value of BottomSheetType
  String get enumValue {
    // The length of class name without Sheet word
    final wl = bottomsheetClassName.length - 5;
    final className = bottomsheetClassName.toLowerCamelCase;

    if (className.endsWith('Sheet')) {
      return className.substring(0, wl);
    }

    return className;
  }
}
