/// Described the logger functionality to generate in the app
class LoggerConfig {
  /// The name of the globally accessible function to return an instance of your Logger
  final String logHelperName;
  final Set<String> imports;
  final List<String> mutliloggers;
  // Future
  // final bool enableGoogleCloudLogging;

  LoggerConfig({
    this.imports = const {},
    this.mutliloggers = const [],
    this.logHelperName = 'getLogger',
  });
}
