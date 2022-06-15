import 'dart:io';

import 'package:mustache_template/mustache.dart';
import 'package:path/path.dart' as path;
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/models/template_models.dart';
import 'package:stacked_tools/src/services/colorized_log_service.dart';
import 'package:stacked_tools/src/services/file_service.dart';
import 'package:stacked_tools/src/services/template_service_utils.dart';
import 'package:stacked_tools/src/templates/compiled_template_map.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';

class RenderTemplateService {
  final _fileService = locator<FileService>();
  final _clog = locator<ColorizedLogService>();
  final _templateServiceUtils = locator<TemplateServiceUtils>();

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

      final verboseMessage = _templateServiceUtils.templateModificationName(
        modificationName: fileToModify.modificationName,
        name: name,
        templateName: templateName,
      );

      // Write the file back that was modified
      await _fileService.writeFile(
        file: File(modificationPath),
        fileContent: updatedFileContent,
        verbose: true,
        type: FileModificationType.ApplyModification,
        verboseMessage: verboseMessage,
      );
    }
  }

  String templateModificationFileContent({
    required String fileContent,
    required String modificationTemplate,
    required String modificationIdentifier,
    required String name,
    required String templateName,
  }) {
    final renderedTemplate = _templateServiceUtils.getRenderedTemplateData(
        modificationTemplate, templateName, name);

    // Take the content, replace the identifier in the file with the new code
    // plus the identifier so we can do the same thing again later.
    return fileContent.replaceFirst(
      modificationIdentifier,
      '$renderedTemplate\n$modificationIdentifier',
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

      final templateFileOutputPath =
          _templateServiceUtils.getTemplateOutputPath(
        inputTemplatePath: templateFile.relativeOutputPath,
        name: name,
        outputFolder: outputFolder,
      );

      await _fileService.writeFile(
        file: File(templateFileOutputPath),
        fileContent: templateContent,
        verbose: true,
      );
    }
  }

  /// Takes in a templated string [content] and builds the template data
  /// to use when rendering
  String renderContentForTemplate({
    required String content,
    required String templateName,
    required String name,
  }) {
    var viewTemplate = Template(content, lenient: true);

    final renderData = _templateServiceUtils.getTemplateRenderData(
      templateName: templateName,
      name: name,
      testRenderFunctions: null,
    );

    return viewTemplate.renderString(renderData);
  }
}
