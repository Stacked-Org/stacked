import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:stacked_tools/src/constants/command_constants.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_tools/src/models/template_models.dart';
import 'package:stacked_tools/src/services/colorized_log_service.dart';
import 'package:stacked_tools/src/services/file_service.dart';
import 'package:stacked_tools/src/services/process_service.dart';
import 'package:stacked_tools/src/services/pubspec_service.dart';
import 'package:stacked_tools/src/services/template_service_utils.dart';
import 'package:stacked_tools/src/templates/compiled_template_map.dart';

class RevertTemplateService {
  final _fileService = locator<FileService>();
  final _pubspecService = locator<PubspecService>();
  final _clog = locator<ColorizedLogService>();
  final _processService = locator<ProcessService>();
  final _utils = locator<TemplateServiceUtils>();

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

  /// Revert all the modifications made be [template]
  Future<void> revertTemplateFiles({
    required StackedTemplate template,
    required String templateName,
    required String name,
    String? outputFolder,
  }) async {
    // Delete all the template generated files
    for (final templateFile in template.templateFiles) {
      final templateFileOutputPath = _utils.getTemplateOutputPath(
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

      final verboseMessage = _utils.templateModificationName(
        modificationName: fileToModify.modificationName,
        name: name,
        templateName: templateName,
      );

      // Write the file back that was modified
      await _fileService.writeFile(
          file: File(modificationPath),
          fileContent: updatedFileContent,
          verbose: true,
          type: FileModificationType.RevertModification,
          verboseMessage: verboseMessage);
    }

    // The template being deleted is a view template, and thus we have to delete the created folders as well.
    if (templateName == "view") {
      /// Deleting the view folder.
      String directoryPath = _utils.getTemplateOutputPath(
        inputTemplatePath: 'lib/ui/views/generic/',

        ///TODO: Change this 👆 to the config file view path when it's added.
        name: name,
        outputFolder: outputFolder,
      );
      _fileService.deleteFolder(directoryPath: directoryPath);
    }
  }

  /// It reverts the modification applied to a file by [modificationTemplate]
  Future<String> templateWithoutModifiedFileContent({
    required String fileContent,
    required String modificationTemplate,
    required String modificationIdentifier,
    required String name,
    required String templateName,
  }) async {
    String renderedTemplate = _utils.getRenderedTemplateData(
        modificationTemplate, templateName, name);

    //Replace generated io.File content with modifier, to remove the generated content
    if (renderedTemplate.contains("\n")) {
      var file = File("temp.txt");
      await _fileService.writeFile(file: file, fileContent: renderedTemplate);

      await _processService.formatFile(
        fileName: 'temp.txt',
        workingDir: ksCurrentDirectory,
      );

      String formattedText = await file.readAsString();

      print(formattedText);

      formattedText = formattedText[formattedText.length - 1] == '\n'
          ? formattedText.substring(0, formattedText.length - 1)
          : formattedText;
      formattedText = escapeRegex(formattedText);

      print(formattedText);
      // var regexp = RegExp(r'(.*?)*\s*' + formattedText + r'\n?');
      var regexp = RegExp(r'(.*)\s*' + formattedText + r'\n?');

      file.delete();

      // The reason of doing 2 replace is just to make sure if there is no newline above the formattedText, we
      // still eliminate it
      var returnedText = fileContent.replaceFirstMapped(
        regexp,
        (match) => '',
      );

      return returnedText;
    } else {
      var templateText = escapeRegex(renderedTemplate);
      // var regexp = RegExp(r'\n\s*' + templateText);
      var regexp = RegExp(r'(.*)\s*' + templateText);
      print(fileContent.replaceFirstMapped(regexp, (match) => ''));
      return fileContent.replaceFirstMapped(regexp, (match) => '');
    }
  }

  /// Use this method to purge a view or a service.
  Future<void> purgeTemplate(String templateName, ArgResults argResults,
      ProjectStructureValidator structureValidator) async {
    final outputPath = argResults.rest.length > 1 ? argResults.rest[1] : null;
    await _pubspecService.initialise(workingDirectory: outputPath);
    await structureValidator.validateStructure(outputPath: outputPath);
    await revertTemplate(
        templateName: templateName, name: argResults.rest.first);
    await _processService.runBuildRunner(appName: outputPath);
    await _processService.runFormat(appName: outputPath);
  }

  // A function to escape all special regex characters, making the string safe for use in a regex match
  String escapeRegex(String text) {
    var regex = RegExp(r'[\.\^\$\*\+\-\?\(\)\[\]\{\}\|\—\/]\s*?');
    // var regex = RegExp(r'[.^$*+-?()[]{}|—/]\s*+');
    return text.replaceAllMapped(regex, (match) => r'\' + text[match.start]);
  }
}
