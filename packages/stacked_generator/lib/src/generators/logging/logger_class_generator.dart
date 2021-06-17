import 'package:stacked_generator/src/generators/logging/logger_config.dart';

import '../base_generator.dart';
import 'logger_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class LoggerClassGenerator extends BaseGenerator {
  final LoggerConfig _loggerConfig;

  LoggerClassGenerator(LoggerConfig loggerConfig)
      : _loggerConfig = loggerConfig;

  Future<String> generate() async {
    final _logHelperNameKey = _loggerConfig.logHelperName;
    final _imports = _generateImports(_loggerConfig.imports);
    final _multiLogger = _generateMultiLoggers(_loggerConfig.mutliloggers);

    final _replacedHelperName =
        loggerClassContent.replaceFirst(LogHelperNameKey, _logHelperNameKey);

    final _replacedImports =
        _replacedHelperName.replaceFirst(MultiLoggerImports, _imports);

    write(_replacedImports.replaceFirst(MultipleLoggerOutput, _multiLogger));

    return stringBuffer.toString();
  }

  String _generateMultiLoggers(List<String> multiLogger) {
    final _multiLoggers = StringBuffer();

    multiLogger.forEach((element) {
      _multiLoggers.write("$element(),");
    });
    return _multiLoggers.toString();
  }

  String _generateImports(Set<String> imports) {
    final _importBuffer = StringBuffer();
    imports.forEach((element) {
      _importBuffer.writeln("import '$element';");
    });
    return _importBuffer.toString();
  }
}
