extension NullableStringUtilsExtension on String? {
  String get surroundWithAngleBracketsOrReturnEmptyIfNull =>
      this != null ? '<$this>' : '';
}

extension StringUtilsExtension on String {
  RegExpMatch? get getTypeInsideList =>
      RegExp(r'(.*)<(.*)(>)').firstMatch(this);
}
