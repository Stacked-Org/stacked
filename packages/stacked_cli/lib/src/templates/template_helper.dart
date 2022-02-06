// TODO: Refactor into a service so we can mock out the return value
import 'dart:io';

import 'package:stacked_cli/src/locator.dart';
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

  /// Returns the list of files that have .stk endings in the templates/[templateName] folder
  Future<List<FileSystemEntity>> getFilesForTemplate({
    required String templateName,
  }) async {
    final allFilesInTemplateDirectory = await _fileService.getFilesInDirectory(
      directoryPath: templatesPath,
    );

    final allTemplateFiles = getFilesWithExtension(
      filePaths: allFilesInTemplateDirectory,
      extension: '.stk',
    );

    final templateFolder = _pathService.join('templates', templateName);

    return getFilesThatContainSection(
      files: allTemplateFiles,
      section: templateFolder,
    );
  }
}
