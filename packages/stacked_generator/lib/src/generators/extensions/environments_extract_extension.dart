extension EnvironmentExtractExtension on Set<String>? {
  String get getFromatedEnvs {
    final _envString = StringBuffer();
    if (this == null || this!.isEmpty) {
      return _envString.toString();
    }

    _envString.write(',registerFor:{');

    this!.forEach((element) {
      if (this!.first == element) {
        _envString.write('"$element"');
      } else {
        _envString.write(',"$element"');
      }
    });
    _envString.write('}');
    return _envString.toString();
  }
}
