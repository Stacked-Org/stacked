import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';

/// Reolves the [LoggerConfig] and returns the object if it's supplied
class LoggerConfigResolver {
  Future<LoggerConfig?> resolve(ConstantReader stackedApp) async {
    final loggerReader = stackedApp.peek('logger');

    if (loggerReader != null) {
      return LoggerConfig(
        logHelperName:
            loggerReader.peek('logHelperName')?.stringValue ?? 'getLogger',
      );
    }

    return null;
  }
}
