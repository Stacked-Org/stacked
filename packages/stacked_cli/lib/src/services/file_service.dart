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
