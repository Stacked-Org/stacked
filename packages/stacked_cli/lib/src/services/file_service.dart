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

  void log(String message, {bool verbose = false}) {
    if (verbose) {
      print(message);
    }
  }
}
