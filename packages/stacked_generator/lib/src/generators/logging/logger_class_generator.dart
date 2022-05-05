import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';

import 'logger_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class LoggerClassGenerator extends BaseGenerator {
  final LoggerConfig _loggerConfig;

  LoggerClassGenerator(this._loggerConfig);

  final utils = LoggerClassGeneratorUtils();

  @override
  String generate() {
    writeImports();

    writeBody();

    writeLoggerNameAndOutputs();

    return stringBuffer.toString();
  }

  void writeImports() {
    final preparedImports =
        utils.surroundStringWithImportTemplate(_loggerConfig.imports);

    final replacedImports =
        loggerClassImports.replaceFirst(MultiLoggerImports, preparedImports);

    write(replacedImports);
  }

  void writeBody() {
    write(loggerClassConstantBody);
  }

  void writeLoggerNameAndOutputs() {
    final withHelperNameInPlace = loggerClassNameAndOutputs.replaceFirst(
        LogHelperNameKey, _loggerConfig.logHelperName);

    String withConditionalLoggerInPlace = withHelperNameInPlace.replaceFirst(
        DisableConsoleOutputInRelease,
        _loggerConfig.disableReleaseConsoleOutput ? 'if(!kReleaseMode)' : '');

    final loggerOutputs =
        utils.addCheckForReleaseModeToEachLogger(_loggerConfig.loggerOutputs);

    String loggerOutputsInPlace = withConditionalLoggerInPlace.replaceFirst(
        MultipleLoggerOutput, loggerOutputs);

    write(loggerOutputsInPlace);
  }
}

class LoggerClassGeneratorUtils {
  String addCheckForReleaseModeToEachLogger(List<String> multiLogger) {
    final _multiLoggers = StringBuffer();

    multiLogger.forEach((element) {
      _multiLoggers.write(" if(kReleaseMode) $element(),");
    });
    return _multiLoggers.toString();
  }

  String surroundStringWithImportTemplate(Set<String> imports) {
    final _importBuffer = StringBuffer();
    imports.forEach((element) {
      _importBuffer.writeln("import '$element';");
    });
    return _importBuffer.toString();
  }
}
