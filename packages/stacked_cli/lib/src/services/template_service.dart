import 'dart:async';
import 'dart:io';

import 'package:mustache_template/mustache_template.dart';
import 'package:recase/recase.dart';
import 'package:stacked_cli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/templates/generic_view_template.dart';
import 'package:stacked_cli/src/templates/generic_viewmodel_template.dart';
import 'package:stacked_cli/src/templates/generic_viewmodel_test_template.dart';
import 'package:stacked_cli/src/templates/template.dart';

const String InvalidStackedStructureAppFile =
    'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/';

const String ModificationIdentifierAppRoutes =
    '// Do not replace. Used for route scaffolding';

Map<String, StackedTemplate> stackdTemplates = {
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
  ], modificationFiles: [
    ModificationFile(
      relativeModificationPath: 'lib/app/app.dart',
      modificationIdentifier: ModificationIdentifierAppRoutes,
      // TODO: add an option to create Cupertino or custom routes
      modificationTemplate: 'MaterialRoute(page: {{viewName}}),',
      modificationProblemError: InvalidStackedStructureAppFile,
    )
  ])
};

/// Given the data that points to templates it writes out those templates
/// using the same file paths
class TemplateService {
  final _fileService = locator<FileService>();

  Future<void> renderTemplate({
    required String templateName,

    /// The name to use for the views when generating the view template
    String? viewName,
    bool verbose = false,
  }) async {
    if (templateName == 'view') {
      if (viewName == null) {
        throw Exception(
            'When using the view template supplying the viewName parameter is required');
      }
    }

    // Get the template that we want to render
    final template =
        stackdTemplates[templateName] ?? StackedTemplate(templateFiles: []);

    await writeOutTemplateFiles(
      template: template,
      templateName: templateName,
      viewName: viewName,
    );

    await modifyExistingFiles(
      template: template,
      templateName: templateName,
      viewName: viewName,
    );
  }

  Future<void> writeOutTemplateFiles({
    required StackedTemplate template,
    required String templateName,
    String? viewName,
  }) async {
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

      await _fileService.writeFile(
        file: File(templateFileOutputPath),
        fileContent: templateContent,
      );
    }
  }

  /// Takes in a templated string [content] and builds the template data
  /// to use when rendering
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

  Future<void> modifyExistingFiles({
    required StackedTemplate template,
    required String templateName,
    String? viewName,
  }) async {
    for (final fileToModify in template.modificationFiles) {
      final fileExists = await _fileService.fileExists(
        filePath: fileToModify.relativeModificationPath,
      );

      if (!fileExists) {
        throw InvalidStackedStructureException(InvalidStackedStructureAppFile);
      }

      final fileContent = await _fileService.readFile(
        filePath: fileToModify.relativeModificationPath,
      );

      final updatedFileContent = templateModificationFileContent(
        fileContent: fileContent,
        modificationIdentifier: fileToModify.modificationIdentifier,
        modificationTemplate: fileToModify.modificationTemplate,
        viewName: viewName,
      );

      // Write the file back that was modified
      await _fileService.writeFile(
        file: File(fileToModify.relativeModificationPath),
        fileContent: updatedFileContent,
      );
    }
  }

  String templateModificationFileContent({
    required String fileContent,
    required String modificationTemplate,
    required String modificationIdentifier,
    String? viewName,
  }) {
    final template = Template(modificationTemplate);

    // TODO: Remove duplicate code below
    final viewNameRecase = ReCase(viewName ?? '');
    final renderedTemplate = template.renderString(
      {'viewName': '${viewNameRecase.pascalCase}View'},
    );

    // Take the content, replace the identifier in the file with the new code
    // plus the identifier so we can do the same thing again later.
    return fileContent.replaceFirst(
      modificationIdentifier,
      '$renderedTemplate\n$modificationIdentifier',
    );
  }
}
