import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/config_service.dart';

mixin ProjectStructureValidator {
  final _configService = locator<ConfigService>();

  /// Returns true if the cli is running from the root of a flutter
  /// or dart project
  Future<bool> _isProjectRoot({String? outputPath}) {
    final hasOutputPath = outputPath != null;
    final pubspecPath = 'pubspec.yaml';
    return File(
            hasOutputPath ? path.join(outputPath, pubspecPath) : pubspecPath)
        .exists();
  }

  /// Checks if the current project aligns with the stacked application structure
  /// to allow for scaffolding to work properly
  Future<bool> _isStackedApplication({String? outputPath}) {
    final hasOutputPath = outputPath != null;
    final appPath = _configService.stackedAppPath;

    return File(hasOutputPath ? path.join(outputPath, appPath) : appPath)
        .exists();
  }

  /// Validates structure and throws exception message when not valid.
  Future<void> validateStructure({String? outputPath}) async {
    // Check if we are at the root of the project. If not, exit gracefully
    if (!(await _isProjectRoot(outputPath: outputPath))) {
      throw InvalidStackedStructureException(kInvalidRootDirectory);
    }

    if (!(await _isStackedApplication(outputPath: outputPath))) {
      throw InvalidStackedStructureException(kInvalidStackedStructure);
    }
  }
}
