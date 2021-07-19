import 'package:flutter/foundation.dart';

class Parameters {
  final Map<String, String?> _params;

  Parameters(Map<String, String?> params) : _params = params;

  Map<String, String?> get rawMap => _params;

  ParameterValue operator [](String key) => ParameterValue._(_params[key]);

  @override
  String toString() {
    return _params.toString();
  }
}

class ParameterValue {
  final dynamic _value;

  const ParameterValue._(this._value);

  dynamic get value => _value;

  String? optString() => _value;

  String getString([String? defaultValue]) {
    var val = _value ?? defaultValue;
    if (val == null) {
      throw FlutterError('Failed to parse [String] value from $_value');
    }
    return val;
  }

  int? optInt([int? defaultValue]) {
    if (_value == null) {
      return defaultValue;
    } else if (_value is int) {
      return _value;
    } else {
      return int.tryParse(_value.toString()) ?? defaultValue;
    }
  }

  int getInt([int? defaultValue]) {
    var val = optInt(defaultValue);
    if (val == null) {
      throw FlutterError('Failed to parse [int] value from $_value');
    }
    return val;
  }

  double? optDouble([double? defaultValue]) {
    if (_value == null) {
      return defaultValue;
    } else if (_value is double) {
      return _value;
    } else {
      return double.tryParse(_value.toString()) ?? defaultValue;
    }
  }

  double getDouble([double? defaultValue]) {
    var val = optDouble(defaultValue);
    if (val == null) {
      throw FlutterError('Failed to parse [double] value from $_value');
    }
    return val;
  }

  num? optNum([num? defaultValue]) {
    if (_value == null) {
      return defaultValue;
    } else if (_value is num) {
      return _value;
    } else {
      return double.tryParse(_value.toString()) ?? defaultValue;
    }
  }

  num getNum([num? defaultValue]) {
    var val = optNum(defaultValue);
    if (val == null) {
      throw FlutterError('Failed to parse [num] value from $_value');
    }
    return val;
  }

  bool? optBool([bool? defaultValue]) {
    switch (_value?.toLowerCase()) {
      case 'true':
        return true;
      case 'false':
        return false;
      default:
        return defaultValue;
    }
  }

  bool getBool([bool? defaultValue]) {
    var val = optBool(defaultValue);
    if (val == null) {
      throw FlutterError('Failed to parse [bool] value from $_value');
    }
    return val;
  }
}
