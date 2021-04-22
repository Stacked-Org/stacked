/// Described the logger functionality to generate in the app
class LoggerConfig {
  /// The name of the globally accessible function to return an instance of your Logger
  final String logHelperName;

  // Future
  // final bool enableGoogleCloudLogging;

  LoggerConfig({this.logHelperName = 'getLogger'});
}
