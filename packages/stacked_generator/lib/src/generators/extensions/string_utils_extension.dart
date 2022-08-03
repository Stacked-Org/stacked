extension StringUtilsExtension on String? {
  String get surroundWithAngleBracketsOrReturnEmptyIfNull =>
      this != null ? '<$this>' : '';
  String get addInstanceNameIfNotNull {
    if (this == null) return '';

    return ", instanceName: '$this'";
  }
}
