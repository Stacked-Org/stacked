/// Defined the config for the logger in the app
class StackedLogger {
  final String logHelperName;
  final List<Type> loggerOutputs;

  const StackedLogger({
    this.loggerOutputs = const [],
    this.logHelperName = 'getLogger',
  });
}
