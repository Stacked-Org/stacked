import 'package:meta/meta.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/extensions/list_utils_extension.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';

import 'logger_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class LoggerClassGenerator with StringBufferUtils implements BaseGenerator {
  final LoggerConfig _loggerConfig;

  LoggerClassGenerator(this._loggerConfig);

  @override
  String generate() {
    writeImports(_loggerConfig.imports, prefex: loggerClassPrefex);

    write(loggerClassConstantBody);

    customizeLoggerNameAndOutputs(loggerClassNameAndOutputs);

    return serializeStringBuffer;
  }

  @visibleForTesting
  void customizeLoggerNameAndOutputs(String template) {
    final withHelperNameInPlace =
        template.replaceFirst(LogHelperNameKey, _loggerConfig.logHelperName);

    String withConditionalLoggerInPlace = withHelperNameInPlace.replaceFirst(
        DisableConsoleOutputInRelease,
        _loggerConfig.disableReleaseConsoleOutput ? 'if(!_isReleaseMode)' : '');

    String loggerOutputsInPlace = withConditionalLoggerInPlace.replaceFirst(
        MultipleLoggerOutput,
        _loggerConfig.loggerOutputs.addCheckForReleaseModeToEachLogger);

    write(loggerOutputsInPlace);
  }
}
