import 'package:stacked_themes/src/theme_manager.dart';

/// A service accessible outside of the UI to allow the control of the [ThemeManager]
class ThemeService {
  static ThemeService _instance;
  static ThemeService getInstance() {
    if (_instance == null) {
      _instance = ThemeService();
    }

    return _instance;
  }

  ThemeManager _themeManager;

  /// Sets the theme manager instance that will be used from the service
  void setThemeManager(ThemeManager manager) => _themeManager = manager;

  /// Sets the theme for the application equal to the theme at the index
  /// in the list of [themes] supplied to the [ThemeBuilder]
  Future selectThemeAtIndex(int themeIndex) =>
      _themeManager.selectThemeAtIndex(themeIndex);

  /// Swaps between the light and dark ThemeMode if the defaultThemeMode supplied
  /// to the ThemeBuilder is not [ThemeMode.system]
  void toggleDarkLightTheme() => _themeManager.toggleDarkLightTheme();

  /// Returns the number of themes supplied to the [ThemeBuilder]
  int get themeCount => _themeManager.themes?.length ?? 0;

  /// Returns true if the ThemeMode is dark. This does not apply when you're using system as ThemeMode
  bool get isDarkMode => _themeManager.isDarkMode;
}
