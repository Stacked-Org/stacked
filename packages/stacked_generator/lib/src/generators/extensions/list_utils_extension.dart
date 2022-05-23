extension LoggerClassGeneratorExtension on List<String> {
  String get addCheckForReleaseModeToEachLogger {
    final _multiLoggers = StringBuffer();

    this.forEach((element) {
      _multiLoggers.write(" if(_isReleaseMode) $element(),");
    });
    return _multiLoggers.toString();
  }
}
