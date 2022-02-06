import 'dart:async';
import 'dart:io';

/// Handles the writing of files to disk
class FileService {
  Future<void> writeFile({
    required File file,
    required String fileContent,
    bool verbose = false,
  }) async {
    log('Start writing file: $file', verbose: verbose);

    if (!(await file.exists())) {
      await file.create(recursive: true);
    }

    await file.writeAsString(fileContent);

    log('File write complete: $file', verbose: verbose);
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
      print(message);
    }
  }

  /// Returns true if the cli is running from the root of a flutter
  /// or dart project
  Future<bool> isProjectRoot() => File('pubspec.yaml').exists();

  /// Checks if the current project aligns with the stacked application structure
  /// to allow for scaffolding to work properly
  Future<bool> isStakedApplication() => File('lib/app/app.dart').exists();
}
