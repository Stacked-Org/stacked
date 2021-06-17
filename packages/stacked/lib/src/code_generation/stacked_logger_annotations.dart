import 'package:logger/logger.dart';

/// Defined the config for the logger in the app
class StackedLogger {
  final String logHelperName;
  final List<Type> multiLogger;

  const StackedLogger({
    this.multiLogger = const [],
    this.logHelperName = 'getLogger',
  });
}
