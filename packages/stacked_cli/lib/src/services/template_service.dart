import 'dart:async';
import 'dart:io';

import 'package:mustache_template/mustache_template.dart';
import 'package:recase/recase.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/templates/generic_view_template.dart';
import 'package:stacked_cli/src/templates/generic_viewmodel_template.dart';
import 'package:stacked_cli/src/templates/generic_viewmodel_test_template.dart';
import 'package:stacked_cli/src/templates/template.dart';

Map<String, StackedTemplate> _templates = {
  'view': StackedTemplate(templateFiles: [
    TemplateFile(
      relativeOutputPath: 'lib/ui/views/generic/generic_view.dart',
      content: GenericViewTemplate,
    ),
    TemplateFile(
      relativeOutputPath: 'lib/ui/views/generic/generic_viewmodel.dart',
      content: GenericViewModelTemplate,
    ),
    TemplateFile(
      relativeOutputPath: 'test/viewmodel_tests/generic_viewmodel_test.dart',
      content: GenericViewModelTestTemplate,
    )
  ])
};

/// Given the data that points to templates it writes out those templates
/// using the same file paths
class TemplateService {
  Future<void> renderTemplate({
    required String templateName,

    /// The name to use for the views when generating the view template
    String? viewName,
    bool verbose = false,
  }) async {
    // T: Given view as template name with no viewName should throw an exception
    // T: Given view as template name with details as viewName should write three
    //    files to the file system
    // Templating itself should be unit tested on its own through it's own function

    // Get the template that we want to render
    final template =
        _templates[templateName] ?? StackedTemplate(templateFiles: []);

    for (final templateFile in template.templateFiles) {
      final templateContent = renderContentForTemplate(
        content: templateFile.content,
        templateName: templateName,
        viewName: viewName,
      );

      final templateFileOutputPath = templateFile.relativeOutputPath.replaceAll(
        'generic',
        viewName ?? '',
      );

      // TODO: Invert control for unit test purposes
      FileService().writeFile(
        file: File(templateFileOutputPath),
        fileContent: templateContent,
      );
    }
  }

  String renderContentForTemplate({
    required String content,
    required String templateName,
    String? viewName,
  }) {
    var viewTemplate = Template(content, lenient: true);

    // This functionality is separate and will have to move into its own place
    // It WILL become a lot more complicated.
    final viewNameRecase = ReCase(viewName ?? '');
    // TODO: Refactor this to get different render data depending on the template
    final renderData = {
      // TODO: Convert the property names into constants to use in the template content and here
      'viewName': '${viewNameRecase.pascalCase}View',
      'viewModelName': '${viewNameRecase.pascalCase}ViewModel',
      'viewModelFileName': '${viewName}_viewmodel',
    };

    return viewTemplate.renderString(renderData);
  }
}
