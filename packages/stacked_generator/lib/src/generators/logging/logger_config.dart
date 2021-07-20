/// Described the logger functionality to generate in the app
class LoggerConfig {
  /// The name of the globally accessible function to return an instance of your Logger
  final String logHelperName;
  final Set<String> imports;
  final List<String> loggerOutputs;
  // Future
  // final bool enableGoogleCloudLogging;

  LoggerConfig({
    this.imports = const {},
    this.loggerOutputs = const [],
    this.logHelperName = 'getLogger',
  });
}
