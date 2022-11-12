extension NullableStringUtilsExtension on String? {
  String get surroundWithAngleBracketsOrReturnEmptyIfNull =>
      this != null ? '<$this>' : '';
  String get addInstanceNameIfNotNull {
    if (this == null) return '';

    return ", instanceName: '$this'";
  }

  /// Inorder to replace this             with             this
  ///                     ||                                ||
  ///                     \/                                \/
  /// String? !=null ? String? + String : null        String? + String
  ///
  ///
  ///
  String? operator +(String rightSide) {
    final leftSide = this;

    if (leftSide == null) {
      return leftSide;
    } else {
      return leftSide + rightSide;
    }
  }
}

extension StringUtilsExtension on String {
  RegExpMatch? get getTypeInsideList =>
      RegExp(r'(.*)<(.*)(>)').firstMatch(this);
}
