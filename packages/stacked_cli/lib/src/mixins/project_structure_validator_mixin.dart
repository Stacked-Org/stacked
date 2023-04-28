import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';

mixin ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _cLog = locator<ColorizedLogService>();

  /// Returns true if the cli is running from the root of a flutter
  /// or dart project
  Future<bool> _isProjectRoot({String? outputPath}) {
    final hasOutputPath = outputPath != null;
    final pubspecPath = 'pubspec.yaml';
    return File(
      hasOutputPath ? path.join(outputPath, pubspecPath) : pubspecPath,
    ).exists();
  }

  /// Checks if the current project aligns with the stacked application structure
  /// to allow for scaffolding to work properly
  Future<bool> _isStackedApplication({String? outputPath}) {
    final hasOutputPath = outputPath != null;
    final appPath = _configService.stackedAppFilePath;

    return File(hasOutputPath
            ? path.join(outputPath, 'lib', appPath)
            : path.join('lib', appPath))
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

  final organizationPattern = RegExp(r'^[a-z0-9]+(\.[a-z0-9]+)+$');

  bool _isOrganizationValid(String orgName) {
    return organizationPattern.hasMatch(orgName);
  }

  /// Logs an error if the the organization name is invalid
  void validateOrganization({String? organization}) {
    if (organization == null) {
      return;
    }
    if (_isOrganizationValid(organization)) {
      return;
    }
    _cLog.error(message: kInvalidOrganization);
    return;
  }

  final appNamePattern = RegExp(r'^[a-z][a-z0-9_]*(?:_[a-z0-9_]+)*$');

  static const _reservedWords = [
    'assert',
    'break',
    'case',
    'catch',
    'class',
    'const',
    'continue',
    'default',
    'do',
    'else',
    'enum',
    'extends',
    'false',
    'final',
    'finally',
    'for',
    'if',
    'in',
    'is',
    'new',
    'null',
    'rethrow',
    'return',
    'super',
    'switch',
    'this',
    'throw',
    'true',
    'try',
    'var',
    'void',
    'while',
    'with'
  ];

  bool _isValidAppName(String appName) {
    return appNamePattern.hasMatch(appName) &&
        !_reservedWords.contains(appName);
  }

  /// Logs an error if the the app name is invalid
  void validateAppName({String? appName}) {
    if (appName == null) {
      return;
    }
    if (_isValidAppName(appName)) {
      return;
    }
    _cLog.error(message: kInvalidAppName);
    return;
  }
}
