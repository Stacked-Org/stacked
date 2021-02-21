class SharedPreferencesService {
  static SharedPreferencesService _instance;

  static Future<SharedPreferencesService> getInstance() {
    if (_instance == null) {
      _instance = SharedPreferencesService();
    }

    return Future.value(_instance);
  }
}
