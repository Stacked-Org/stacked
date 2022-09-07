extension EnvironmentExtractExtension on Set<String>? {
  String get getFromatedEnvs {
    final envString = StringBuffer();
    if (this == null || this!.isEmpty) {
      return envString.toString();
    }

    envString.write(',registerFor:{');

    for (final element in this!) {
      if (this!.first == element) {
        envString.write('"$element"');
      } else {
        envString.write(',"$element"');
      }
    }
    envString.write('}');
    return envString.toString();
  }
}
