/// Defined the config for the logger in the app
class StackedLogger {
  final String logHelperName;

  /// Pass loggerOutputs types here.[logger: StackedLogger(loggerOutputs: [CrashlyticsOutput])]
  ///
  /// loggerOutputs must extends [LogOutput]
  final List<Type> loggerOutputs;

  const StackedLogger({
    this.loggerOutputs = const [],
    this.logHelperName = 'getLogger',
  });
}
