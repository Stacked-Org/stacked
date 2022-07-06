import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';

import 'logger_builder.dart';

/// Generates the app.logger.dart file in the users code base.
class LoggerClassGenerator implements BaseGenerator {
  final LoggerConfig _loggerConfig;

  LoggerClassGenerator(this._loggerConfig);

  @override
  String generate() {
    final loggerBuilder = LoggerBuilder(loggerConfig: _loggerConfig)
        .addImports()
        .addLoggerClassConstantBody()
        .addLoggerNameAndOutputs();

    return loggerBuilder.serializeStringBuffer;
  }
}
