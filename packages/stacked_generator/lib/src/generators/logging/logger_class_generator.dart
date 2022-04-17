import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';

import 'logger_class_content.dart';

/// Generates the app.logger.dart file in the users code base.
class LoggerClassGenerator extends BaseGenerator {
  final LoggerConfig _loggerConfig;

  LoggerClassGenerator(LoggerConfig loggerConfig)
      : _loggerConfig = loggerConfig;

  Future<String> generate() async {
    // TODO: Refactor the way we do this to make more sense.
    // TODO: Use O from SOLID principles (open / closed) to Close implementation
    final _logHelperNameKey = _loggerConfig.logHelperName;
    final _imports = _generateImports(_loggerConfig.imports);
    final _multiLogger = _generateMultiLoggers(_loggerConfig.loggerOutputs);

    final _replacedHelperName =
        loggerClassContent.replaceFirst(LogHelperNameKey, _logHelperNameKey);

    final _replacedImports =
        _replacedHelperName.replaceFirst(MultiLoggerImports, _imports);

    final _replacedConditionalLogger = _replacedImports.replaceFirst(
        DisableConsoleOutputInRelease,
        _loggerConfig.disableReleaseConsoleOutput ? 'if(!kReleaseMode)' : '');

    write(_replacedConditionalLogger.replaceFirst(
        MultipleLoggerOutput, _multiLogger));

    return stringBuffer.toString();
  }

  String _generateMultiLoggers(List<String> multiLogger) {
    final _multiLoggers = StringBuffer();

    multiLogger.forEach((element) {
      _multiLoggers.write(" if(kReleaseMode) $element(),");
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
