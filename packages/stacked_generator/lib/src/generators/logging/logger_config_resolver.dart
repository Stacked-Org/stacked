import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:stacked_generator/import_resolver.dart';
import 'package:stacked_generator/src/generators/logging/logger_config.dart';

/// Reolves the [LoggerConfig] and returns the object if it's supplied
class LoggerConfigResolver {
  Future<LoggerConfig?> resolve(
      ConstantReader stackedApp, ImportResolver importResolver) async {
    final _loggerReader = stackedApp.peek('logger');
    final _multiLogger = _loggerReader?.peek('loggerOutputs')?.listValue;
    final _logHelperName =
        _loggerReader?.peek('logHelperName')?.stringValue ?? 'getLogger';

    if (_loggerReader != null) {
      return LoggerConfig(
        logHelperName: _logHelperName,
        imports: _resolveImports(
          importResolver: importResolver,
          multiLogger: _multiLogger,
        ),
        loggerOutputs: _resolveMultiLogger(_multiLogger),
      );
    }

    return null;
  }

  List<String> _resolveMultiLogger(List<DartObject>? multiLogger) {
    if (multiLogger != null) {
      print(multiLogger);
      final res = multiLogger
          .map((e) => e.toTypeValue()?.getDisplayString(withNullability: false))
          .where((element) => element != null)
          .toList()
          .cast<String>();

      print(res);
      return res;
    } else {
      return [];
    }
  }

  Set<String> _resolveImports({
    List<DartObject>? multiLogger,
    required ImportResolver importResolver,
  }) {
    if (multiLogger != null) {
      return multiLogger
          .where((element) => element.toTypeValue() != null)
          .map((e) => importResolver.resolve(_dartOjectToElemet(e)))
          .toSet()
          .cast<String>();
    } else {
      return {};
    }
  }

  ClassElement _dartOjectToElemet(DartObject obj) {
    var dependencyReader = ConstantReader(obj).typeValue;
    return dependencyReader.element as ClassElement;
  }
}
