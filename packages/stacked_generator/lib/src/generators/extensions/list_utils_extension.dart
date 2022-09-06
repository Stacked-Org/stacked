extension LoggerClassGeneratorExtension on List<String> {
  String get addCheckForReleaseModeToEachLogger {
    final multiLoggers = StringBuffer();

    for (final element in this) {
      multiLoggers.write(" if(kReleaseMode) $element(),");
    }
    return multiLoggers.toString();
  }
}
