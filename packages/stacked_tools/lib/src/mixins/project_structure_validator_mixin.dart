import 'package:stacked_tools/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/services/file_service.dart';

mixin ProjectStructureValidator {
  final _fileService = locator<FileService>();

  /// Validates structure and throws exception message when not valid.
  Future<void> validateStructure({String? outputPath}) async {
    // Check if we are at the root of the project. If not, exit gracefully
    if (!(await _fileService.isProjectRoot(outputPath: outputPath))) {
      throw InvalidStackedStructureException(kInvalidRootDirectory);
    }

    if (!(await _fileService.isStakedApplication(outputPath: outputPath))) {
      throw InvalidStackedStructureException(kInvalidStackedStructure);
    }
  }
}
