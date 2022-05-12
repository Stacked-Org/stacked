extension StringUtilsExtension on String? {
  String get surroundWithAngleBracketsOrReturnEmptyIfNull =>
      this != null ? '<$this>' : '';
}
