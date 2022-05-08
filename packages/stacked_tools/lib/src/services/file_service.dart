import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:stacked_tools/src/mixins/colorized_output_mixin.dart';

/// Handles the writing of files to disk
class FileService with ColorizedOutput {
  Future<void> writeFile({
    required File file,
    required String fileContent,
    bool verbose = false,
  }) async {
    if (!(await file.exists())) {
      log('File does not exist. Write it out');
      await file.create(recursive: true);
    }

    await file.writeAsString(fileContent);

    log('Created $file', verbose: verbose);
  }

  /// Check if the file at [filePath] exists
  Future<bool> fileExists({required String filePath}) {
    return File(filePath).exists();
  }

  /// Reads the file at [filePath] on disk and returns as String
  Future<String> readFile({required String filePath}) {
    return File(filePath).readAsString();
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

  void log(String message, {bool verbose = false}) {
    if (verbose) {
      stackedOutput(message: message);
    }
  }

  /// Returns true if the cli is running from the root of a flutter
  /// or dart project
  Future<bool> isProjectRoot({String? outputPath}) {
    final hasOutputPath = outputPath != null;
    final pubspecPath = 'pubspec.yaml';
    return File(
            hasOutputPath ? path.join(outputPath, pubspecPath) : pubspecPath)
        .exists();
  }

  /// Checks if the current project aligns with the stacked application structure
  /// to allow for scaffolding to work properly
  Future<bool> isStakedApplication({String? outputPath}) {
    final hasOutputPath = outputPath != null;
    final appPath = 'lib/app/app.dart';

    return File(hasOutputPath ? path.join(outputPath, appPath) : appPath)
        .exists();
  }
}
