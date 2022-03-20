import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/path_service.dart';

/// This class contains functions that helps with the population of the templates
// TODO: Reasses if this should just be in the template service and not on its own
class TemplateHelper {
  final _fileService = locator<FileService>();
  final _pathService = locator<PathService>();

  String get templatesPath => _pathService.templatesPath;

  /// Returns files that end in .stk extensions (which is how we indicate templates in this project)
  List<FileSystemEntity> getFilesWithExtension({
    required List<FileSystemEntity> filePaths,
    required String extension,
  }) {
    return filePaths
        .where((element) => element.path.contains(extension))
        .toList();
  }

  List<FileSystemEntity> getFilesThatContainSection({
    required List<FileSystemEntity> files,
    required String section,
  }) {
    return files.where((element) => element.path.contains(section)).toList();
  }

  /// Returns the name of the template file without the extensions
  String getTemplateFileNameOnly(
          {required FileSystemEntity templateFilePath}) =>
      _pathService
          .basename(templateFilePath.path)
          .replaceFirst('.dart.stk', '');

  String getTemplateFolderName({required String templateFilePath}) =>
      _pathService.basename(templateFilePath);

  /// Returns the list of files with [extension] endings in the templates/[templateName] folder
  Future<List<FileSystemEntity>> getFilesForTemplate({
    required String templateName,
    String extension = '.stk',
  }) async {
    final allFilesInTemplateDirectory = await _fileService.getFilesInDirectory(
      directoryPath: templatesPath,
    );

    final allTemplateFiles = getFilesWithExtension(
      filePaths: allFilesInTemplateDirectory,
      extension: extension,
    );

    final templateFolder = _pathService.join('templates', templateName);

    return getFilesThatContainSection(
      files: allTemplateFiles,
      section: templateFolder,
    );
  }

  /// Return all the compiled file modifications to apply to the template
  Future<List<CompiledFileModification>> getTemplateModificationsToApply({
    required String templateName,
  }) async {
    final templateModificationItems = <CompiledFileModification>[];
    final modificationFiles = await getFilesForTemplate(
      templateName: templateName,
      extension: '.json',
    );

    for (final modificationFile in modificationFiles) {
      final fileContent = await File(modificationFile.path).readAsString();

      final compiledModificationItem =
          CompiledFileModification.fromJson(json.decode(fileContent));

      templateModificationItems.add(compiledModificationItem);
    }
    return templateModificationItems;
  }

  /// Returns all the compiled template files to write out to disk
  Future<List<CompliledTemplateFile>> getTemplateItemsToRender({
    required String templateName,
  }) async {
    final templateItemsToRender = <CompliledTemplateFile>[];

    final templateFiles = await getFilesForTemplate(
      templateName: templateName,
    );

    final templateNameRecase = ReCase(templateName);
    // TODO: Add a test to confirm this functionality
    final templateFolderName = _pathService.join('templates', templateName);

    for (final templateFile in templateFiles) {
      final templateFileNameOnly = getTemplateFileNameOnly(
        templateFilePath: templateFile,
      );

      final templateFileNameRecase = ReCase(templateFileNameOnly);

      final relativeTemplateFilePath =
          // TODO: Fix properly and unit test, this is a hack
          templateFile.path.split(templateFolderName).last.replaceFirst(
                _pathService.separator,
                '',
              );

      final templateFileContent =
          await _fileService.readFile(filePath: templateFile.path);

      templateItemsToRender.add(CompliledTemplateFile(
        name: templateNameRecase.pascalCase,
        fileName: templateFileNameRecase.pascalCase,
        path: relativeTemplateFilePath,
        content: templateFileContent,
      ));
    }

    return templateItemsToRender;
  }
}
