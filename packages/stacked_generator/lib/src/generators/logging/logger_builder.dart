import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/extensions/list_utils_extension.dart';
import 'package:stacked_generator/src/generators/logging/logger_class_content.dart';

import 'logger_config.dart';

class LoggerBuilder with StringBufferUtils {
  final LoggerConfig loggerConfig;
  LoggerBuilder({required this.loggerConfig});

  LoggerBuilder addImports() {
    write(loggerClassPrefex);

    writeLine();

    final sorted = loggerConfig.imports.toList()..sort();
    sorted.forEach((import) => writeLine("import '$import';"));

    writeLine();
    writeLine();
    writeLine();

    return this;
  }

  LoggerBuilder addLoggerClassConstantBody() {
    write(loggerClassConstantBody);
    return this;
  }

  LoggerBuilder addLoggerNameAndOutputs() {
    final withHelperNameInPlace = loggerClassNameAndOutputs.replaceFirst(
        LogHelperNameKey, loggerConfig.logHelperName);

    String withConditionalLoggerInPlace = withHelperNameInPlace.replaceFirst(
        DisableConsoleOutputInRelease,
        loggerConfig.disableReleaseConsoleOutput ? 'if(!_isReleaseMode)' : '');

    String loggerOutputsInPlace = withConditionalLoggerInPlace.replaceFirst(
        MultipleLoggerOutput,
        loggerConfig.loggerOutputs.addCheckForReleaseModeToEachLogger);

    write(loggerOutputsInPlace);

    return this;
  }
}
