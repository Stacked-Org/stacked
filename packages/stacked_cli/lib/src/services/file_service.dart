// ignore_for_file: constant_identifier_names, unnecessary_string_escapes

import 'dart:async';
import 'dart:io';

import 'package:recase/recase.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/colorized_log_service.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';

/// Handles the writing of files to disk
class FileService {
  final _log = locator<ColorizedLogService>();

  Future<void> writeFile({
    required File file,
    required String fileContent,
    bool verbose = false,
    FileModificationType type = FileModificationType.Create,
    String? verboseMessage,
  }) async {
    if (!(await file.exists())) {
      if (type != FileModificationType.Create) {
        _log.warn(message: 'File does not exist. Write it out');
      }
      await file.create(recursive: true);
    }

    await file.writeAsString(fileContent);

    if (verbose) {
      _log.fileOutput(type: type, message: verboseMessage ?? '$file');
    }
  }

  /// Delete a file at the given path
  ///
  /// Args:
  ///   filePath (String): The path to the file you want to delete.
  Future<void> deleteFile({required String filePath}) async {
    final file = File(filePath);
    await file.delete();
    _log.fileOutput(type: FileModificationType.Delete, message: '$file');
  }

  /// It deletes all the files in a folder. and the folder itself.
  ///
  /// Args:
  ///   directoryPath (String): The path to the directory you want to delete.
  Future<void> deleteFolder({required String directoryPath}) async {
    var files = await getFilesInDirectory(directoryPath: directoryPath);
    await Future.forEach<FileSystemEntity>(files, (file) async {
      await file.delete();
      _log.fileOutput(type: FileModificationType.Delete, message: '$file');
    });
    await Directory(directoryPath).delete(recursive: false);
  }

  /// Check if the file at [filePath] exists
  Future<bool> fileExists({required String filePath}) {
    return File(filePath).exists();
  }

  /// Reads the file at [filePath] on disk and returns as String
  Future<String> readFileAsString({
    required String filePath,
  }) {
    return File(filePath).readAsString();
  }

  /// "Read the file at the given path and return the contents as a list of strings, one string per
  /// line."
  ///
  /// Args:
  ///   filePath (String): The path to the file to read.
  ///
  /// Returns:
  ///   A Future<List<String>>
  Future<List<String>> readFileAsLines({
    required String filePath,
  }) {
    return File(filePath).readAsLines();
  }

  Future<void> removeSpecificFileLines({
    required String filePath,
    required String removedContent,
    String type = kTemplateNameView,
  }) async {
    final recaseName = ReCase('$removedContent $type');
    if (type == kTemplateNameService) {
      await removeTestHelperFunctionFromFile(
        filePath: filePath,
        serviceName: recaseName.pascalCase,
      );
    }
    List<String> fileLines = await readFileAsLines(filePath: filePath);
    fileLines.removeWhere((line) => line.contains(recaseName.snakeCase));
    fileLines.removeWhere((line) => line.contains(recaseName.pascalCase));
    await writeFile(
      file: File(filePath),
      fileContent: fileLines.join('\n'),
      type: FileModificationType.Modify,
      verbose: true,
      verboseMessage: "Removed ${recaseName.pascalCase}$type from $filePath",
    );
  }

  Future<void> removeTestHelperFunctionFromFile({
    required String filePath,
    required String serviceName,
  }) async {
    String fileString = await readFileAsString(filePath: filePath);
    fileString = fileString.replaceAll(
        RegExp(
          "Mock$serviceName getAndRegister$serviceName[(][)] {.*?}",
          caseSensitive: false,
          dotAll: true,
          multiLine: true,
        ),
        '');
    await writeFile(
      file: File(filePath),
      fileContent: fileString,
      type: FileModificationType.Modify,
    );
  }

  /// Gets all files in a given directory
  Future<List<FileSystemEntity>> getFilesInDirectory(
      {required String directoryPath}) async {
    final directory = Directory(directoryPath);
    final allFileEntities = await _listDirectoryContents(directory);
    return allFileEntities.toList();
  }

  Future<List<String>> getFoldersInDirectory(
      {required String directoryPath}) async {
    final directory = Directory(directoryPath);
    final allFileEntities =
        await _listDirectoryContents(directory, recursive: false);
    return allFileEntities.whereType<Directory>().map((e) => e.path).toList();
  }

  Future<List<FileSystemEntity>> _listDirectoryContents(
    Directory dir, {
    bool recursive = true,
  }) {
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: recursive);
    lister.listen(
      (file) => files.add(file),
      // should also register onError
      onDone: () => completer.complete(files),
    );
    return completer.future;
  }
}

// enum for file modification types
enum FileModificationType {
  Create,
  Modify,
  Delete,
}
