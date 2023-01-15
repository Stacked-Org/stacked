import 'package:stacked_cli/src/enums/view_templates.dart';

extension StringHelpers on String {
  ViewTemplate get template {
    for (var templateType in ViewTemplate.values) {
      if (templateType.name == this) {
        return templateType;
      }
    }

    throw Exception(
        '$this is not a valid template. You can only use one of ${ViewTemplate.values.map((e) => e.name)}');
  }
}
