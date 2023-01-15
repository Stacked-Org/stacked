import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stacked_cli/src/constants/config_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/config_file_not_found_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/models/config_model.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/path_service.dart';

/// Handles app configuration of stacked cli
class ConfigService {
  final _log = locator<ColorizedLogService>();
  final _fileService = locator<FileService>();
  final _pathService = locator<PathService>();

  /// Default config map used to compare and replace with custom values.
  final Map<String, dynamic> _defaultConfig = Config().toJson();

  /// Custom config used to store custom values read from file.
  Config _customConfig = Config();

  bool _hasCustomConfig = false;

  bool get hasCustomConfig => _hasCustomConfig;

  /// Relative services path for import statements.
  String get serviceImportPath => _customConfig.servicesPath;

  /// Relative path where services will be genereated.
  String get servicePath => _customConfig.servicesPath;

  /// Returns the name of the locator to use when registering service mocks.
  String get locatorName => _customConfig.locatorName;

  String get registerMocksFunction => _customConfig.registerMocksFunction;

  /// Relative import path related to services of test helpers and mock services.
  String get serviceTestHelpersImport => getFilePathToHelpersAndMocks(
        _customConfig.testServicesPath,
      );

  /// Relative bottom sheet path for import statements.
  String get bottomSheetsPath => _customConfig.bottomSheetsPath;

  /// File path where bottom sheet builders are located.
  String get bottomSheetBuilderFilePath =>
      _customConfig.bottomSheetBuilderFilePath;

  /// File path where bottom sheet type enum values are located.
  String get bottomSheetTypeFilePath => _customConfig.bottomSheetTypeFilePath;

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
  String get viewImportPath => _customConfig.viewsPath;

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

  /// Resolves configuration file path.
  ///
  /// Looks for the configuration file in different locations depending their
  /// priorities. When a configuration file is find, the path of the file is
  /// returned. Otherwise, null is returned.
  ///
  /// Locations sorted by priority.
  ///   - $path/stacked.json
  ///   - stacked.json
  ///   - $XDG_CONFIG_HOME/stacked/stacked.json
  ///   - stacked.config.json (deprecated config filename, only for backwards compatibility)
  @visibleForTesting
  Future<String?> resolveConfigFile({String? path}) async {
    if (path != null) {
      if (await _fileService.fileExists(filePath: '$path/$kConfigFileName')) {
        return '$path/$kConfigFileName';
      }
    }

    if (await _fileService.fileExists(filePath: kConfigFileName)) {
      return kConfigFileName;
    }

    if (await _fileService.fileExists(
      filePath: '${_pathService.configHome.path}/stacked/stacked.json',
    )) {
      return '${_pathService.configHome.path}/stacked/stacked.json';
    }

    // This is only for backwards compatibility, will be removed on next release
    if (await _fileService.fileExists(filePath: 'stacked.config.json')) {
      _log.warn(message: kDeprecatedConfigFileName);
      return 'stacked.config.json';
    }

    return null;
  }

  /// Reads configuration file and set data to [_customConfig] map.
  Future<void> loadConfig({String? path}) async {
    try {
      final configPath = await resolveConfigFile(path: path);
      if (configPath == null) {
        throw ConfigFileNotFoundException(kConfigFileNotFound);
      }

      final data = await _fileService.readFileAsString(filePath: configPath);
      _customConfig = Config.fromJson(jsonDecode(data));
      _hasCustomConfig = true;
      _sanitizeCustomConfig();
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

  /// Sanitizes the [path] removing [find].
  ///
  /// Generally used to remove unnecessary parts of the path as {lib} or {test}.
  @visibleForTesting
  String sanitizePath(String path, [String find = 'lib/']) {
    if (!path.startsWith(find)) return path;

    return path.replaceFirst(find, '');
  }

  /// Sanitizes [_customConfig] to remove unnecessary {lib} or {test} from paths.
  ///
  /// Warns the user if the custom config has deprecated path parts.
  void _sanitizeCustomConfig() {
    final sanitizedConfig = _customConfig.copyWith(
      stackedAppFilePath: sanitizePath(_customConfig.stackedAppFilePath),
      servicesPath: sanitizePath(_customConfig.servicesPath),
      viewsPath: sanitizePath(_customConfig.viewsPath),
      testHelpersFilePath:
          sanitizePath(_customConfig.testHelpersFilePath, 'test/'),
      testServicesPath: sanitizePath(_customConfig.testServicesPath, 'test/'),
      testViewsPath: sanitizePath(_customConfig.testViewsPath, 'test/'),
    );

    if (_customConfig == sanitizedConfig) return;

    _log.warn(message: kDeprecatedPaths);

    _customConfig = sanitizedConfig;
  }

  /// Returns file path of test helpers and mock services relative to [path].
  @visibleForTesting
  String getFilePathToHelpersAndMocks(String path) {
    String fileToImport = testHelpersFilePath;
    final pathSegments =
        path.split('/').where((element) => !element.contains('.'));

    for (var i = 0; i < pathSegments.length; i++) {
      fileToImport = '../' + fileToImport;
    }

    return fileToImport;
  }
}
