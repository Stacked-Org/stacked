import 'package:stacked_generator/src/generators/logging/logger_config.dart';

import '../base_generator.dart';
import 'logger_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class LoggerClassGenerator extends BaseGenerator {
  final LoggerConfig _loggerConfig;

  LoggerClassGenerator(LoggerConfig loggerConfig)
      : _loggerConfig = loggerConfig;

  Future<String> generate() {
    return Future.value(loggerClassContent.replaceFirst(
      LogHelperNameKey,
      _loggerConfig.logHelperName,
    ));
  }
}
