import 'dart:async';

import 'package:mustache_template/mustache_template.dart';
import 'package:recase/recase.dart';
import 'package:stacked_cli/src/templates/generic_view_template.dart';
import 'package:stacked_cli/src/templates/template.dart';

Map<String, StackedTemplate> _templates = {
  'view': StackedTemplate(templateFiles: [
    TemplateFile(
      relativeOutputPath: 'lib/ui/views/generic/generic_view.dart',
      content: GenericViewTemplate,
    ),
  ])
};

/// Given the data that points to templates it writes out those templates
/// using the same file paths
class TemplateService {
  Future<void> renderTemplate({
    required String templateName,

    /// The name to use for the views when generating the view template
    String? viewName,
  }) async {
    // Get the template that we want to render
    final template =
        _templates[templateName] ?? StackedTemplate(templateFiles: []);

    for (final templateFile in template.templateFiles) {
      var viewTemplate = Template(templateFile.content, lenient: true);
      final viewNameRecase = ReCase(viewName ?? '');
      final renderData = {
        'viewName': '${viewNameRecase.pascalCase}View',
        'viewModelName': '${viewNameRecase.pascalCase}ViewModel',
        'viewModelFileName': '${viewName}_viewmodel.dart',
      };

      final templateOutput = viewTemplate.renderString(renderData);

      final templateFileOutputPath =
          templateFile.relativeOutputPath.replaceAll('generic', viewName ?? '');

      print(
          'Write file: $templateFileOutputPath\nWith content:\n$templateOutput');
    }
  }
}
