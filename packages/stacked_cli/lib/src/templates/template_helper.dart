// TODO: Refactor into a service so we can mock out the return value
import 'dart:io';

import 'package:path/path.dart' as p;

/// This class contains functions that helps with the population of the templates
// TODO: Reasses if this should just be in the template service and not on its own
class TemplateHelper {
  List<FileSystemEntity> getTemplatesFilesOnly(
      {required List<FileSystemEntity> filePaths}) {
    return filePaths.where((element) => element.path.contains('.stk')).toList();
  }

  List<FileSystemEntity> getFilesForTemplate({
    required List<FileSystemEntity> filePaths,
    required String templateName,
  }) {
    final templateFolder = p.join('templates', templateName);
    return filePaths
        .where((element) => element.path.contains(templateFolder))
        .toList();
  }
}
