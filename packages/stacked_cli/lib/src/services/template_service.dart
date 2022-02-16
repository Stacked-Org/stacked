import 'dart:async';
import 'dart:io';

import 'package:mustache_template/mustache_template.dart';
// TODO: Refactor into a service so we can mock out the return value
import 'package:path/path.dart' as p;
import 'package:pubspec_yaml/pubspec_yaml.dart';
import 'package:recase/recase.dart';
import 'package:stacked_cli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/message_constants.dart';
import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/templates/compiled_template_map.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';
import 'package:stacked_cli/src/templates/template_helper.dart';
import 'package:stacked_cli/src/templates/template_render_functions.dart';

/// Given the data that points to templates it writes out those templates
/// using the same file paths
class TemplateService {
  final _fileService = locator<FileService>();
  final _templateHelper = locator<TemplateHelper>();

  /// Reads the template folder and creates the dart code that will be used to generate
  /// the templates
  Future<void> compileTemplateInformation() async {
    final templatesPath = _templateHelper.templatesPath;

    final stackedTemplateFolderPaths = await _fileService.getFoldersInDirectory(
      directoryPath: templatesPath,
    );

    final stackedTemplates = <CompiledStackedTemplate>[];
    final allTemplateItems = <CompliledTemplateFile>[];

    for (final stackedTemplateFolderPath in stackedTemplateFolderPaths) {
      final templateName = _templateHelper.getTemplateFolderName(
        templateFilePath: stackedTemplateFolderPath,
      );

      final templateItemsToRender =
          await _templateHelper.getTemplateItemsToRender(
        templateName: templateName,
      );

      allTemplateItems.addAll(templateItemsToRender);

      final templateModificationsToApply = await _templateHelper
          .getTemplateModificationsToApply(templateName: templateName);

      stackedTemplates.add(CompiledStackedTemplate(
        name: templateName,
        templateFiles: templateItemsToRender,
        modificationFiles: templateModificationsToApply,
      ));
    }

    final outputTemplate = Template(kTemplateDataStructure);
    final templateItemsData = {
      'templateItems': allTemplateItems.map((e) => e.toJson()).toList(),
    };

    final allTemplateItemsContent =
        outputTemplate.renderString(templateItemsData);

    await _fileService.writeFile(
      file: File(p.join(templatesPath, 'compiled_templates.dart')),
      fileContent: allTemplateItemsContent,
    );

    // Creat the template map
    final templateMap = Template(kTemplateMapDataStructure);
    final templateMapData = {
      'stackedTemplates': stackedTemplates.map((e) => e.toJson()).toList(),
    };

    final templateMapContent = templateMap.renderString(templateMapData);
    await _fileService.writeFile(
      file: File(p.join(templatesPath, 'compiled_template_map.dart')),
      fileContent: templateMapContent,
    );
  }

  /// Using the [templateName] this function will write out the template
  /// files in the directory the cli is currently running.
  Future<void> renderTemplate({
    required String templateName,

    /// The name to use for the views when generating the view template
    required String name,
    bool verbose = false,

    /// When set to true the newly generated view will not be added to the app.dart file
    bool excludeRoute = false,
  }) async {
    // Get the template that we want to render
    final template = kCompiledStackedTemplates[templateName] ??
        StackedTemplate(templateFiles: []);

    await writeOutTemplateFiles(
      template: template,
      templateName: templateName,
      name: name,
    );

    // TODO: Refactor into an exclusionary rule system where we can
    // provide new rules to exclude functionality with.
    if (templateName == 'view' && excludeRoute) {
      return;
    }

    await modifyExistingFiles(
      template: template,
      templateName: templateName,
      name: name,
    );
  }

  Future<void> writeOutTemplateFiles({
    required StackedTemplate template,
    required String templateName,
    required String name,
  }) async {
    for (final templateFile in template.templateFiles) {
      final templateContent = renderContentForTemplate(
        content: templateFile.content,
        templateName: templateName,
        name: name,
      );

      final templateFileOutputPath = getTemplateOutputPath(
        inputTemplatePath: templateFile.relativeOutputPath,
        name: name,
      );

      await _fileService.writeFile(
        file: File(templateFileOutputPath),
        fileContent: templateContent,
        verbose: true,
      );
    }
  }

  /// Returns the output path for the file given the input path of the template
  String getTemplateOutputPath({
    required String inputTemplatePath,
    String? name,
  }) {
    final recaseName = ReCase(name ?? '');
    return inputTemplatePath
        .replaceAll(
          'generic',
          recaseName.snakeCase,
        )
        .replaceFirst('.stk', '');
  }

  /// Takes in a templated string [content] and builds the template data
  /// to use when rendering
  String renderContentForTemplate({
    required String content,
    required String templateName,
    required String name,
  }) {
    var viewTemplate = Template(content, lenient: true);

    final renderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
    );

    return viewTemplate.renderString(renderData);
  }

  /// Returns a render data map from the [template_render_functions.dart] file with map
  Map<String, String> getTemplateRenderData({
    required String templateName,
    required String name,

    /// This value is only for testing
    Map<String, RenderFunction>? testRenderFunctions,
  }) {
    final nameRecase = ReCase(name);

    final renderFunction = testRenderFunctions != null
        ? testRenderFunctions[templateName]
        : renderFunctions[templateName];

    if (renderFunction == null) {
      throw Exception(
          'No render function has been defined for the template $templateName. Please define a render function before running the command again.');
    }

    return renderFunction(nameRecase);
  }

  Future<void> modifyExistingFiles({
    required StackedTemplate template,
    required String templateName,
    String? name,
  }) async {
    for (final fileToModify in template.modificationFiles) {
      final fileExists = await _fileService.fileExists(
        filePath: fileToModify.relativeModificationPath,
      );

      if (!fileExists) {
        throw InvalidStackedStructureException(kInvalidStackedStructureAppFile);
      }

      final fileContent = await _fileService.readFile(
        filePath: fileToModify.relativeModificationPath,
      );

      final updatedFileContent = templateModificationFileContent(
        fileContent: fileContent,
        modificationIdentifier: fileToModify.modificationIdentifier,
        modificationTemplate: fileToModify.modificationTemplate,
        viewName: name,
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
    final template = Template(
      modificationTemplate,
      lenient: true,
    );

    // TODO: We need to be able to unit test this (will become important if it ever breaks somethings)
    final pubspecYaml = File('pubspec.yaml').readAsStringSync().toPubspecYaml();

    // TODO: Remove duplicate code below
    final viewNameRecase = ReCase(viewName ?? '');
    final renderedTemplate = template.renderString(
      {
        // TODO: Create helper extensions for modifying the viewName passed in
        kTemplatePropertyViewName: '${viewNameRecase.pascalCase}View',
        kTemplatePropertyPackageName: pubspecYaml.name,
        kTemplateViewFolderName: viewNameRecase.snakeCase,
        kTemplateViewFileName: '${viewNameRecase.snakeCase}_view.dart',
      },
    );

    // Take the content, replace the identifier in the file with the new code
    // plus the identifier so we can do the same thing again later.
    return fileContent.replaceFirst(
      modificationIdentifier,
      '$renderedTemplate\n$modificationIdentifier',
    );
  }
}
