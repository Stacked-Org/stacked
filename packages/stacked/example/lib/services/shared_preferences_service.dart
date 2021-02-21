class SharedPreferencesService {
  static SharedPreferencesService _instance;
  SharedPreferences _sharedPreferences;

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      // Initialise the asynchronous shared preferences
      _sharedPreferences = await SharedPreferences.getSharedPrefs();
      _instance = SharedPreferencesService();
    }

    return Future.value(_instance);
  }
}
