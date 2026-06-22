import 'package:example/app/app.logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

class SharedPreferencesService implements InitializableDependency {
  static const _isUserLoggedInKey = 'isUserLoggedIn';

  final bool enableLogs;
  SharedPreferencesService({this.enableLogs = false});

  final _log = getLogger('SharedPreferencesService');

  late SharedPreferences _preferences;

  @override
  Future<void> init() async {
    _log.d('Initialized');
    _preferences = await SharedPreferences.getInstance();
  }

  bool get isUserLoggedIn =>
      (getFromDisk(_isUserLoggedInKey) as bool?) ?? false;

  set isUserLoggedIn(bool value) => saveToDisk(_isUserLoggedInKey, value);

  Set<String> getKeys() => _preferences.getKeys();

  Object? getFromDisk(String key) {
    final value = _preferences.get(key);
    if (enableLogs) _log.v('key:$key value:$value');
    return value;
  }

  void saveToDisk(String key, dynamic content) {
    if (enableLogs) _log.v('key:$key value:$content');

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

  void dispose() {
    _log.i('');
    _preferences.clear();
  }
}
