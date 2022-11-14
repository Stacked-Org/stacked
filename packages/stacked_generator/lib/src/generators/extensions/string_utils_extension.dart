extension NullableStringUtilsExtension on String? {
  String get surroundWithAngleBracketsOrReturnEmptyIfNull =>
      this != null ? '<$this>' : '';
  String get addInstanceNameIfNotNull {
    if (this == null) return '';

    return ", instanceName: '$this'";
  }

  /// Overload the + operator to handle nullable and non-nullable addtion
  String? operator +(String right) {
    final left = this;

    if (left == null) {
      return left;
    } else {
      return left + right;
    }
  }
}

extension StringUtilsExtension on String {
  RegExpMatch? get getTypeInsideList =>
      RegExp(r'(.*)<(.*)(>)').firstMatch(this);
}
