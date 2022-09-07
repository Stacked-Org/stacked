class ConfigFileNotFoundException implements Exception {
  final String message;
  ConfigFileNotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}
