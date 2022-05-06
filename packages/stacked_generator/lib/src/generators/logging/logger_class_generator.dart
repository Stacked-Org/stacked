import 'package:flutter/material.dart';
import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';

import 'logger_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class LoggerClassGenerator extends BaseGenerator {
  final LoggerConfig _loggerConfig;

  LoggerClassGenerator(this._loggerConfig);

  @override
  String generate() {
    writeImports(_loggerConfig.imports, prefex: loggerClassPrefex);

    write(loggerClassConstantBody);

    customizeLoggerNameAndOutputs(loggerClassNameAndOutputs);

    return stringBuffer.toString();
  }

  @visibleForTesting
  void customizeLoggerNameAndOutputs(String template) {
    final withHelperNameInPlace =
        template.replaceFirst(LogHelperNameKey, _loggerConfig.logHelperName);

    String withConditionalLoggerInPlace = withHelperNameInPlace.replaceFirst(
        DisableConsoleOutputInRelease,
        _loggerConfig.disableReleaseConsoleOutput ? 'if(!kReleaseMode)' : '');

    String loggerOutputsInPlace = withConditionalLoggerInPlace.replaceFirst(
        MultipleLoggerOutput,
        _loggerConfig.loggerOutputs.addCheckForReleaseModeToEachLogger);

    write(loggerOutputsInPlace);
  }
}

extension LoggerClassGeneratorExtension on List<String> {
  String get addCheckForReleaseModeToEachLogger {
    final _multiLoggers = StringBuffer();

    this.forEach((element) {
      _multiLoggers.write(" if(kReleaseMode) $element(),");
    });
    return _multiLoggers.toString();
  }
}
