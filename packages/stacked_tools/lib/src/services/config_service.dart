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

  /// Returns the name of the locator to use when registering service mocks.
  String get locatorName => _customConfig.locatorName;

  String get registerMocksFunction => _customConfig.registerMocksFunction;

  /// Relative import path related to services of test helpers and mock services.
  String get serviceTestHelpersImport => getFilePathToHelpersAndMocks(
        _customConfig.testServicesPath,
      );

  /// File path where StackedApp is setup.
  String get stackedAppFilePath => _customConfig.stackedAppFilePath;

  /// File path where register functions for unit test setup and mock
  /// declarations are located.
  String get testHelpersFilePath => _customConfig.testHelpersFilePath;

  /// Relative path where services unit tests will be genereated.
  String get testServicesPath => _customConfig.testServicesPath;

  /// Relative path where viewmodels unit tests will be genereated.
  String get testViewsPath => _customConfig.testViewsPath;

  /// Relative views path for import statements.
  String get viewImportPath => getImportPath(_customConfig.viewsPath);

  /// Relative path where views and viewmodels will be genereated.
  String get viewPath => _customConfig.viewsPath;

  /// Relative import path related to viewmodels of test helpers and mock services.
  String get viewTestHelpersImport => getFilePathToHelpersAndMocks(
        _customConfig.testViewsPath,
      );

  /// Returns boolean value to determine view builder style.
  ///
  /// False: StackedView
  /// True: ViewModelBuilder
  bool get v1 => _customConfig.v1;

  /// Returns int value for line length when format code.
  int get lineLength => _customConfig.lineLength;

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
      // Avoid trying to replace non path values like v1 or lineLength
      if (!k.contains('path')) continue;

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

  /// Returns file path of test helpers and mock services relative to [path].
  @visibleForTesting
  String getFilePathToHelpersAndMocks(String path) {
    String fileToImport = testHelpersFilePath;
    if (path.startsWith('test/') && fileToImport.startsWith('test/')) {
      path = path.replaceFirst('test/', '');
      fileToImport = fileToImport.replaceFirst('test/', '');
    }

    final pathSegments =
        path.split('/').where((element) => !element.contains('.'));

    for (var i = 0; i < pathSegments.length; i++) {
      fileToImport = '../' + fileToImport;
    }

    return fileToImport;
  }
}
