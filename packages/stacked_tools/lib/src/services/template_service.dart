import 'dart:async';
import 'dart:io' as io;

import 'package:mustache_template/mustache_template.dart';
// TODO: Refactor into a service so we can mock out the return value
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:stacked_tools/src/constants/command_constants.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/models/template_models.dart';
import 'package:stacked_tools/src/services/colorized_log_service.dart';
import 'package:stacked_tools/src/services/file_service.dart';
import 'package:stacked_tools/src/services/pubspec_service.dart';
import 'package:stacked_tools/src/services/process_service.dart';
import 'package:stacked_tools/src/templates/compiled_template_map.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';
import 'package:stacked_tools/src/templates/template_helper.dart';
import 'package:stacked_tools/src/templates/template_render_functions.dart';

/// Given the data that points to templates it writes out those templates
/// using the same file paths
class TemplateService {
  final _fileService = locator<FileService>();
  final _templateHelper = locator<TemplateHelper>();
  final _pubspecService = locator<PubspecService>();
  final _clog = locator<ColorizedLogService>();
  final _processService = locator<ProcessService>();

  /// Reads the template folder and creates the dart code that will be used to generate
  /// the templates
  Future<void> compileTemplateInformation() async {
    final templatesPath = _templateHelper.templatesPath;

    final stackedTemplateFolderPaths = await _fileService.getFoldersInDirectory(
      directoryPath: templatesPath,
    );

    final stackedTemplates = <CompiledStackedTemplate>[];
    final allTemplateItems = <CompiledTemplateFile>[];

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
      file: io.File(path.join(templatesPath, 'compiled_templates.dart')),
      fileContent: allTemplateItemsContent,
    );

    // Create the template map
    final templateMap = Template(kTemplateMapDataStructure);
    final templateMapData = {
      'stackedTemplates': stackedTemplates.map((e) => e.toJson()).toList(),
    };

    final templateMapContent = templateMap.renderString(templateMapData);
    await _fileService.writeFile(
      file: io.File(path.join(templatesPath, 'compiled_template_map.dart')),
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

    /// When supplied the templates will be created using the folder supplied here as the
    /// output location.
    ///
    /// i.e. When the template writes too lib/ui/view.dart if output path is playground
    /// the final output path will be playground/lib/ui/view.dart
    String? outputPath,
  }) async {
    // Get the template that we want to render
    final template = kCompiledStackedTemplates[templateName] ??
        StackedTemplate(templateFiles: []);

    await writeOutTemplateFiles(
      template: template,
      templateName: templateName,
      name: name,
      outputFolder: outputPath,
    );

    // TODO: Refactor into an exclusionary rule system where we can
    // provide new rules to exclude functionality with.
    if (templateName == kTemplateNameView && excludeRoute) {
      return;
    }

    await modifyExistingFiles(
      template: template,
      templateName: templateName,
      name: name,
      outputPath: outputPath,
    );
  }

  /// Using the [templateName] this function will delete out the template
  /// files in the directory the cli is currently running and revert the modifications applied by this template.
  Future<void> revertTemplate({
    required String templateName,

    /// The name to use for the views when generating the view template
    required String name,
    bool verbose = false,

    /// When set to true the newly generated view will not be added to the app.dart file
    bool excludeRoute = false,

    /// When supplied the templates will be created using the folder supplied here as the
    /// output location.
    ///
    /// i.e. When the template writes too lib/ui/view.dart if output path is playground
    /// the final output path will be playground/lib/ui/view.dart
    String? outputPath,
  }) async {
    // Get the template that we want to render
    final template = kCompiledStackedTemplates[templateName] ??
        StackedTemplate(templateFiles: []);

    await revertTemplateFiles(
      template: template,
      templateName: templateName,
      name: name,
      outputFolder: outputPath,
    );
  }

  Future<void> writeOutTemplateFiles({
    required StackedTemplate template,
    required String templateName,
    required String name,
    String? outputFolder,
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
        outputFolder: outputFolder,
      );

      await _fileService.writeFile(
        file: io.File(templateFileOutputPath),
        fileContent: templateContent,
        verbose: true,
      );
    }
  }

  /// Revert all the modifications made be [template]
  Future<void> revertTemplateFiles({
    required StackedTemplate template,
    required String templateName,
    required String name,
    String? outputFolder,
  }) async {
    // Delete all the template generated files
    for (final templateFile in template.templateFiles) {
      final templateFileOutputPath = getTemplateOutputPath(
        inputTemplatePath: templateFile.relativeOutputPath,
        name: name,
        outputFolder: outputFolder,
      );

      bool fileExists =
          await _fileService.fileExists(filePath: templateFileOutputPath);
      if (!fileExists) {
        _clog.warn(
            message:
                'Template Generated File not deleted. The file $templateFileOutputPath does not exist');
      }

      _fileService.deleteFile(filePath: templateFileOutputPath);
    }

    //revert modified Files of the template
    final hasOutputPath = outputFolder != null;
    for (final fileToModify in template.modificationFiles) {
      final modificationPath = hasOutputPath
          ? path.join(outputFolder, fileToModify.relativeModificationPath)
          : fileToModify.relativeModificationPath;

      final fileExists = await _fileService.fileExists(
        filePath: modificationPath,
      );

      if (!fileExists) {
        _clog.warn(
            message:
                'Modification not unapplied. The file $modificationPath does not exist');
        throw InvalidStackedStructureException(kInvalidStackedStructureAppFile);
      }

      final fileContent = await _fileService.readFileAsString(
        filePath: modificationPath,
      );

      if (!fileContent.contains(fileToModify.modificationIdentifier)) {
        _clog.warn(
            message:
                'Modification not unapplied. The identifier `${fileToModify.modificationIdentifier}` does not exist in the file.');
        throw InvalidStackedStructureException(kInvalidStackedStructureAppFile);
      }

      // Get the file content without the modifications
      final updatedFileContent = await templateWithoutModifiedFileContent(
        fileContent: fileContent,
        modificationIdentifier: fileToModify.modificationIdentifier,
        modificationTemplate: fileToModify.modificationTemplate,
        name: name,
        templateName: templateName,
      );

      final verboseMessage = templateModificationName(
        modificationName: fileToModify.modificationName,
        name: name,
        templateName: templateName,
      );

      // Write the file back that was modified
      await _fileService.writeFile(
          file: io.File(modificationPath),
          fileContent: updatedFileContent,
          verbose: true,
          type: FileModificationType.RevertModification,
          verboseMessage: verboseMessage);
    }

    // The template being deleted is a view template, and thus we have to delete the created folders as well.
    if (templateName == "view") {
      /// Deleting the view folder.
      String directoryPath = getTemplateOutputPath(
        inputTemplatePath: 'lib/ui/views/generic/',

        ///TODO: Change this 👆 to the config file view path when it's added.
        name: name,
        outputFolder: outputFolder,
      );
      _fileService.deleteFolder(directoryPath: directoryPath);
    }
  }

  /// Returns the output path for the file given the input path of the template
  String getTemplateOutputPath({
    required String inputTemplatePath,
    required String name,
    String? outputFolder,
  }) {
    final hasOutputFolder = outputFolder != null;

    final recaseName = ReCase(name);
    final modifiedOutputPath = inputTemplatePath
        .replaceAll(
          'generic',
          recaseName.snakeCase,
        )
        .replaceFirst('.stk', '');
    if (hasOutputFolder) {
      return path.join(outputFolder, modifiedOutputPath);
    }

    return modifiedOutputPath;
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

    final renderDataForTemplate = renderFunction(nameRecase);

    final packageName = templateName == kTemplateNameApp ? name : null;

    return applyGlobalTemplateProperties(
      renderDataForTemplate,
      packageName: packageName,
    );
  }

  Map<String, String> applyGlobalTemplateProperties(
    Map<String, String> renderTemplate, {
    String? packageName,
  }) {
    return {
      ...renderTemplate,
      // All template data will have the values added below
      kTemplatePropertyPackageName:
          packageName ?? _pubspecService.getPackageName,
    };
  }

  Future<void> modifyExistingFiles({
    required StackedTemplate template,
    required String templateName,
    required String name,
    String? outputPath,
  }) async {
    final hasOutputPath = outputPath != null;
    for (final fileToModify in template.modificationFiles) {
      final modificationPath = hasOutputPath
          ? path.join(outputPath, fileToModify.relativeModificationPath)
          : fileToModify.relativeModificationPath;

      final fileExists = await _fileService.fileExists(
        filePath: modificationPath,
      );

      if (!fileExists) {
        _clog.warn(
            message:
                'Modification not applied. The file $modificationPath does not exist');
        throw InvalidStackedStructureException(kInvalidStackedStructureAppFile);
      }

      final fileContent = await _fileService.readFileAsString(
        filePath: modificationPath,
      );

      if (!fileContent.contains(fileToModify.modificationIdentifier)) {
        _clog.warn(
            message:
                'Modification not applied. The identifier `${fileToModify.modificationIdentifier}` does not exist in the file.');
      }

      final updatedFileContent = templateModificationFileContent(
        fileContent: fileContent,
        modificationIdentifier: fileToModify.modificationIdentifier,
        modificationTemplate: fileToModify.modificationTemplate,
        name: name,
        templateName: templateName,
      );

      final verboseMessage = templateModificationName(
        modificationName: fileToModify.modificationName,
        name: name,
        templateName: templateName,
      );

      // Write the file back that was modified
      await _fileService.writeFile(
        file: io.File(modificationPath),
        fileContent: updatedFileContent,
        verbose: true,
        type: FileModificationType.ApplyModification,
        verboseMessage: verboseMessage,
      );
    }
  }

  String templateModificationName({
    required String modificationName,
    required String name,
    required String templateName,
  }) {
    final template = Template(
      modificationName,
      lenient: true,
    );

    final templateRenderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
    );

    final renderedTemplate = template.renderString(templateRenderData);
    return renderedTemplate;
  }

  String templateModificationFileContent({
    required String fileContent,
    required String modificationTemplate,
    required String modificationIdentifier,
    required String name,
    required String templateName,
  }) {
    final template = Template(
      modificationTemplate,
      lenient: true,
    );

    final templateRenderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
    );

    final renderedTemplate = template.renderString(templateRenderData);

    // Take the content, replace the identifier in the file with the new code
    // plus the identifier so we can do the same thing again later.
    return fileContent.replaceFirst(
      modificationIdentifier,
      '$renderedTemplate\n$modificationIdentifier',
    );
  }

  /// It reverts the modification applied to a file by [modificationTemplate]
  Future<String> templateWithoutModifiedFileContent({
    required String fileContent,
    required String modificationTemplate,
    required String modificationIdentifier,
    required String name,
    required String templateName,
  }) async {
    final template = Template(
      modificationTemplate,
      lenient: true,
    );

    final templateRenderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
    );

    final renderedTemplate = template.renderString(templateRenderData);

    //Replace generated io.File content with modifier, to remove the generated content
    if (renderedTemplate.contains("\n")) {
      var file = io.File("temp.txt");
      await _fileService.writeFile(file: file, fileContent: renderedTemplate);

      await _processService.runProcessAndLogOutput(
        programName: 'dart',
        arguments: [ksFormat, "temp.txt", "--set-exit-if-changed"],
        workingDirectory: ksCurrentDirectory,
      );

      String formattedText = await file.readAsString();

      file.delete();

      return fileContent.replaceFirst(
        '\n' + formattedText,
        '',
      );
    } else {
      return fileContent.replaceFirst(renderedTemplate, '');
    }
  }
}
