import 'dart:_internal';

import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';

import 'logger_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class LoggerClassGenerator extends BaseGenerator {
  final LoggerConfig _loggerConfig;

  LoggerClassGenerator(this._loggerConfig);

  @override
  String generate() {
    _writeImports();

    _writeBody();

    _writeLoggerNameAndOutputs();

    return stringBuffer.toString();
  }

  void _writeImports() {
    final replacedImports = loggerClassImports.replaceFirst(MultiLoggerImports,
        _loggerConfig.imports.surroundStringWithImportTemplate);

    write(replacedImports);
  }

  void _writeBody() {
    write(loggerClassConstantBody);
  }

  void _writeLoggerNameAndOutputs() {
    final withHelperNameInPlace = loggerClassNameAndOutputs.replaceFirst(
        LogHelperNameKey, _loggerConfig.logHelperName);

    String withConditionalLoggerInPlace = withHelperNameInPlace.replaceFirst(
        DisableConsoleOutputInRelease,
        _loggerConfig.disableReleaseConsoleOutput ? 'if(!kReleaseMode)' : '');

    String loggerOutputsInPlace = withConditionalLoggerInPlace.replaceFirst(
        MultipleLoggerOutput,
        _loggerConfig.loggerOutputs.addCheckForReleaseModeToEachLogger);

    write(loggerOutputsInPlace);
  }
}

/// I used [EfficientLengthIterable] cause it's the common ancestor of [List] and [Set]
extension LoggerClassGeneratorUtils on EfficientLengthIterable {
  String get addCheckForReleaseModeToEachLogger {
    final _multiLoggers = StringBuffer();

    this.forEach((element) {
      _multiLoggers.write(" if(kReleaseMode) $element(),");
    });
    return _multiLoggers.toString();
  }

  String get surroundStringWithImportTemplate {
    final _importBuffer = StringBuffer();
    this.forEach((element) {
      _importBuffer.writeln("import '$element';");
    });
    return _importBuffer.toString();
  }
}
