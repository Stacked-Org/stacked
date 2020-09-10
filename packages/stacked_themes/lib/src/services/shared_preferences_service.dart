import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService _instance;

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      _instance =
          SharedPreferencesService._(await SharedPreferences.getInstance());
    }

    return _instance;
  }

  final SharedPreferences _preferences;
  SharedPreferencesService._(this._preferences);

  static const _ThemeIndexKey = 'user_key';
  static const _UserThemeModeKey = 'user_theme_mode_key';

  int get themeIndex => _getFromDisk(_ThemeIndexKey);

  set themeIndex(int value) => _saveToDisk(_ThemeIndexKey, value);

  ThemeMode get userThemeMode {
    var userThemeString = _getFromDisk(_UserThemeModeKey);
    if (userThemeString == ThemeMode.dark.toString()) {
      return ThemeMode.dark;
    }

    if (userThemeString == ThemeMode.light.toString()) {
      return ThemeMode.light;
    }

    return null;
  }

  set userThemeMode(ThemeMode value) {
    if (value == null) {
      _saveToDisk(_UserThemeModeKey, value);
    } else {
      var userTheme = value.toString();
      _saveToDisk(_UserThemeModeKey, userTheme);
    }
  }

  void clearPreferences() {
    _preferences.clear();
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void _saveToDisk(String key, dynamic content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
