import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_themes/src/locator_setup.dart';
import 'package:stacked_themes/src/services/shared_preferences_service.dart';
import 'package:stacked_themes/src/services/statusbar_service.dart';

const String SelectedTheme = 'selected-theme';
const String DarkTheme = 'dark-theme';

/// Provides functionality to manage the current theme for the application
class ThemeManager {
  final _sharedPreferences = locator<SharedPreferencesService>();
  final _statusBarService = locator<StatusBarService>();

  /// Has to be called before  we make use of the theme manager
  static Future initialise() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
  }

  /// A list of themes that the application can swap to
  final List<ThemeData> themes;

  /// The theme to be used when not using the darkTheme
  final ThemeData lightTheme;

  /// The theme to be used when not using the lightTheme
  final ThemeData darkTheme;

  /// Indicates if you want the system setting for light or dark to take effect
  /// default value is true. Set this to false if you want the app to determine your theme
  final bool useSystemTheme;

  /// A builder function that provides you with the new selected theme that expects you to
  /// return a color for the status bar.
  final Color Function(ThemeData) statusBarColorBuilder;

  /// Indicates if you want the darkmode supplied to be the first theme supplied to the application
  final bool startInDarkMode;

  BehaviorSubject<Map<String, ThemeData>> _themesController;

  Stream<Map<String, ThemeData>> get themesStream => _themesController.stream;

  ThemeManager({
    this.themes,
    this.useSystemTheme,
    this.statusBarColorBuilder,
    this.startInDarkMode,
    this.darkTheme,
    this.lightTheme,
  }) {
    var hasMultipleThemes = themes != null && themes.length > 1;
    var hasLightAndDarkThemes = darkTheme != null && lightTheme != null;
    assert(hasMultipleThemes || hasLightAndDarkThemes,
        '''You have to supply themes if you want to use themes. You have supplied no themes. Don\'t do that. Supply themes.
You can supply either a list of ThemeData objects to the themes property or a lightTheme and a darkTheme to be swapped between.
        ''');

    var storedThemeIndex = _sharedPreferences.themeIndex;

    ThemeData selectedTheme;

    if (hasMultipleThemes) {
      if (storedThemeIndex != null) {
        try {
          selectedTheme = themes[storedThemeIndex];
        } catch (e) {
          print(
              '''WARNING: You have changed your number of themes. Because of this we will clear your previously selected
        theme and broadcast the first theme in your list of themes.''');
          _sharedPreferences.themeIndex = null;
          selectedTheme = themes.first;
        }
      } else {
        selectedTheme = themes.first;
      }
    } else {
      if (!startInDarkMode) {
        selectedTheme = lightTheme;
      } else {
        selectedTheme = darkTheme;
      }
    }

    _applyStatusBarColor(selectedTheme);

    _themesController = BehaviorSubject<Map<String, ThemeData>>.seeded({
      SelectedTheme: selectedTheme,
      DarkTheme: darkTheme,
    });
  }

  /// Broadcasts the theme at the index over the [themesStream]
  Future selectThemeAtIndex(int themeIndex) async {
    var theme = themes[themeIndex];
    await _applyStatusBarColor(theme);
    _themesController.add({SelectedTheme: theme});
    _sharedPreferences.themeIndex = themeIndex;
  }

  Future _applyStatusBarColor(ThemeData theme) async {
    var statusBarColor = statusBarColorBuilder?.call(theme);
    if (statusBarColor != null) {
      await _statusBarService.updateStatusBarColor(statusBarColor);
    }
  }
}

/// Returns the [ThemeManger] that
ThemeManager getThemeManager(BuildContext context) =>
    Provider.of<ThemeManager>(context, listen: false);
