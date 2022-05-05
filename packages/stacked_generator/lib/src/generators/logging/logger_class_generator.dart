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
    final _replacedHelperName = loggerClassContent.replaceFirst(
        LogHelperNameKey, _loggerConfig.logHelperName);
    String _replacedConditionalLogger =
        _addConditionalLogger(_replacedHelperName);

    String afterReplaceMultiLoggerOutput =
        _replaceMutiLoggerOutput(utils, _replacedConditionalLogger);

    write(afterReplaceMultiLoggerOutput);

    return stringBuffer.toString();
  }

  String _addConditionalLogger(String _replacedImports) {
    final _replacedConditionalLogger = _replacedImports.replaceFirst(
        DisableConsoleOutputInRelease,
        _loggerConfig.disableReleaseConsoleOutput ? 'if(!kReleaseMode)' : '');
    return _replacedConditionalLogger;
  }

  void writeImports() {
    final preparedImports =
        utils.surroundStringWithImportTemplate(_loggerConfig.imports);

    final replacedImports =
        loggerClassImports.replaceFirst(MultiLoggerImports, preparedImports);

    write(replacedImports);
  }

  String _replaceMutiLoggerOutput(
      LoggerClassGeneratorUtils utils, String _replacedConditionalLogger) {
    final _multiLogger =
        utils.addCheckForReleaseModeToEachLogger(_loggerConfig.loggerOutputs);

    final afterReplaceMultiLoggerOutput = _replacedConditionalLogger
        .replaceFirst(MultipleLoggerOutput, _multiLogger);
    return afterReplaceMultiLoggerOutput;
  }

  void writeBody() {
    write(loggerClassConstantBody);
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
