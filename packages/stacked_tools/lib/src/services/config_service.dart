import 'dart:convert';

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

  Config _config = Config();

  /// Path of the file where StackedApp is setup.
  String get stackedAppPath => _config.stackedAppPath;

  /// Path where views and viewmodels will be genereated.
  String get viewPath => _config.viewPath;

  /// Path where viewmodels unit tests will be genereated.
  String get viewTestsPath => _config.viewTestsPath;

  /// Path where services will be genereated.
  String get servicePath => _config.servicePath;

  /// Path where services unit tests will be genereated.
  String get serviceTestsPath => _config.serviceTestsPath;

  /// Path for test helper file that contains the register functions for unit
  /// test setup.
  String get testHelpersPath => _config.testHelpersPath;

  /// Path for mock declarations.
  String get testMocksPath => _config.testMocksPath;

  /// Check if configuration file at [path] exists.
  Future<bool> isConfigFileAvailable({String path = kConfigFilePath}) async {
    return await _fileService.fileExists(filePath: path);
  }

  /// Reads configuration file at [path] and add data to [_config] map.
  Future<void> loadConfig({String path = kConfigFilePath}) async {
    try {
      if (!await isConfigFileAvailable(path: path)) {
        throw ConfigFileNotFoundException(kConfigFileNotFound);
      }

      final data = await _fileService.readFileAsString(filePath: path);

      _config = Config.fromJson(jsonDecode(data));
    } on ConfigFileNotFoundException catch (e) {
      _log.warn(message: e.message);
    } on FormatException catch (_) {
      _log.warn(message: kConfigFileMalformed);
    } catch (e) {
      _log.error(message: e.toString());
    }
  }
}
