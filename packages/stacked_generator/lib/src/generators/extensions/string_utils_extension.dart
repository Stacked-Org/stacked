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

  String get toLowerCamelCase {
    if (length < 2) return toLowerCase();
    return this[0].toLowerCase() + substring(1);
  }

  String get capitalize {
    if (length < 2) return toUpperCase();
    return this[0].toUpperCase() + substring(1);
  }

  String get toKababCase {
    return replaceAllMapped(RegExp('(.+?)([A-Z])'),
        (match) => '${match.group(1)}-${match.group(2)}'.toLowerCase());
  }
}
