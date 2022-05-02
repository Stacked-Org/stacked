/// Defined the config for the logger in the app
class StackedLogger {
  final String logHelperName;

  /// Pass loggerOutputs types here.[StackedLogger(loggerOutputs: [CrashlyticsOutput])]
  ///
  /// loggerOutputs must extends [LogOutput]
  final List<Type> loggerOutputs;

  /// When set to true console logs will not be printed in release mode
  /// Default is true
  final bool disableReleaseConsoleOutput;

  const StackedLogger({
    this.loggerOutputs = const [],
    this.logHelperName = 'getLogger',
    this.disableReleaseConsoleOutput = true,
  });
}
