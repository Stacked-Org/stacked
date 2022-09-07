extension NullableStringUtilsExtension on String? {
  String get surroundWithAngleBracketsOrReturnEmptyIfNull =>
      this != null ? '<$this>' : '';
  String get addInstanceNameIfNotNull {
    if (this == null) return '';

    return ", instanceName: '$this'";
  }
}

extension StringUtilsExtension on String {
  RegExpMatch? get getTypeInsideList =>
      RegExp(r'(.*)<(.*)(>)').firstMatch(this);
}
