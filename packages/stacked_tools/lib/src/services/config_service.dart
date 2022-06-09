import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stacked_tools/src/constants/config_constants.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/exceptions/config_file_not_found_exception.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/models/config_model.dart';
import 'package:stacked_tools/src/services/colorized_log_service.dart';
import 'package:stacked_tools/src/services/file_service.dart';

/// Handles app configuration of stacked cli
class ConfigService {
  final _log = locator<ColorizedLogService>();
  final _fileService = locator<FileService>();

  /// Default config map used to compare and replace with custom values
  final Map<String, dynamic> _defaultConfig = Config().toJson();

  /// Custom config used to store custom values read from file
  Config _customConfig = Config();

  bool _hasCustomConfig = false;

  bool get hasCustomConfig => _hasCustomConfig;

  /// Relative services path for import statements.
  String get serviceImportPath => getImportPath(_customConfig.servicesPath);

  /// Relative path where services will be genereated.
  String get servicePath => _customConfig.servicesPath;

  /// Relative import path related to services of test helpers and mock services.
  String get serviceTestHelpersImportPath => getRelativePathToHelpersAndMocks(
        _customConfig.testServicesPath,
      );

  /// Relative path of the file where StackedApp is setup.
  String get stackedAppPath => _customConfig.stackedAppPath;

  /// Relative path for test helper file that contains the register functions
  /// for unit test setup.
  String get testHelpersPath => _customConfig.testHelpersPath;

  /// Relative path where services unit tests will be genereated.
  String get testServicesPath => _customConfig.testServicesPath;

  /// Relative path where viewmodels unit tests will be genereated.
  String get testViewsPath => _customConfig.testViewsPath;

  /// Relative views path for import statements.
  String get viewImportPath => getImportPath(_customConfig.viewsPath);

  /// Relative path where views and viewmodels will be genereated.
  String get viewPath => _customConfig.viewsPath;

  /// Relative import path related to viewmodels of test helpers and mock services.
  String get viewTestHelpersImportPath => getRelativePathToHelpersAndMocks(
        _customConfig.testViewsPath,
      );

  /// Check if configuration file at [path] exists.
  Future<bool> isConfigFileAvailable({String path = kConfigFilePath}) async {
    return await _fileService.fileExists(filePath: path);
  }

  /// Reads configuration file at [path] and set data to [_customConfig] map.
  ///
  /// If [path] is not passed, [kConfigFilePath] is used as default.
  Future<void> loadConfig({String path = kConfigFilePath}) async {
    try {
      if (!await isConfigFileAvailable(path: path)) {
        throw ConfigFileNotFoundException(kConfigFileNotFound);
      }

      final data = await _fileService.readFileAsString(filePath: path);

      _customConfig = Config.fromJson(jsonDecode(data));
      _hasCustomConfig = true;
    } on ConfigFileNotFoundException catch (e) {
      _log.warn(message: e.message);
    } on FormatException catch (_) {
      _log.warn(message: kConfigFileMalformed);
    } catch (e) {
      _log.error(message: e.toString());
    }
  }

  /// Replaces the default configuration in [path] by custom configuration
  /// available at [customConfig].
  ///
  /// If [hasCustomConfig] is false, returns [path] without modifications.
  String replaceCustomPaths(String path) {
    if (!hasCustomConfig) return path;

    final customConfig = _customConfig.toJson();
    String customPath = path;

    for (var k in _defaultConfig.keys) {
      if (customPath.contains(_defaultConfig[k])) {
        customPath = customPath.replaceFirst(
          _defaultConfig[k],
          customConfig[k],
        );
        break;
      }
    }

    return customPath;
  }

  /// Returns import path of [path].
  @visibleForTesting
  String getImportPath(String path) {
    if (!path.startsWith('lib/')) return path;

    return path.replaceFirst('lib/', '');
  }

  /// Returns import path relative to [path] of test helpers and mock services.
  @visibleForTesting
  String getRelativePathToHelpersAndMocks(
    /// Relative path of file where test helpers and mocks will be imported.
    String path,
  ) {
    if (!path.startsWith('test/')) {
      throw Exception(
        'Any test file should be placed inside "test" folder on root of the project. Please, correct your test location.',
      );
    }

    /// Remove unnecessary part of the path
    String anyTestFilePath = path.replaceFirst('test/', '');
    String helpersPath = testHelpersPath.replaceFirst('test/', '');

    final anyTestFilePathLevels = anyTestFilePath.split('/');

    for (var i = 0; i < anyTestFilePathLevels.length; i++) {
      helpersPath = '../' + helpersPath;
    }

    return helpersPath;
  }
}
