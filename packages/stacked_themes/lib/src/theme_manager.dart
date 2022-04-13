import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked_themes/src/locator_setup.dart';
import 'package:stacked_themes/src/services/platform_service.dart';
import 'package:stacked_themes/src/services/shared_preferences_service.dart';
import 'package:stacked_themes/src/services/statusbar_service.dart';
import 'package:stacked_themes/src/theme_service.dart';
import 'package:stacked_themes/stacked_themes.dart';

const String SelectedTheme = 'selected-theme';
const String DarkTheme = 'dark-theme';

/// Provides functionality to manage the current theme for the application
class ThemeManager {
  final SharedPreferencesService _sharedPreferences =
      locator<SharedPreferencesService>();

  final StatusBarService _statusBarService = locator<StatusBarService>();
  final PlatformService _platformService = locator<PlatformService>();

  /// Has to be called before  we make use of the theme manager
  static Future initialise() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
  }

  /// A list of themes that the application can swap to
  final List<ThemeData>? themes;

  /// The theme to be used when not using the darkTheme
  final ThemeData? lightTheme;

  /// The theme to be used when not using the lightTheme
  final ThemeData? darkTheme;

  /// The default theme mode to use for the application when the application is frst used.
  ///
  /// When using system all previously user selected theme will be cleared in favor of the system.
  final ThemeMode defaultTheme;

  ThemeMode? _selectedThemeMode;

  ThemeModel? _initialTheme;

  /// Returns the current selected theme mode
  ThemeMode? get selectedThemeMode => _selectedThemeMode;

  ThemeModel get initalTheme => _initialTheme!;

  /// A builder function that provides you with the new selected theme that expects you to
  /// return a color for the status bar.
  final Color? Function(ThemeData?)? statusBarColorBuilder;

  /// A builder function that provides you with the new selected theme that expects you to
  /// return a color for the navigation bar.
  final Color? Function(ThemeData?)? navigationBarColorBuilder;

  late BehaviorSubject<ThemeModel> _themesController;

  Stream<ThemeModel> get themesStream => _themesController.stream;

  /// Returns true if the ThemeMode is dark. This does not apply when you're using system as ThemeMode
  bool get isDarkMode => _selectedThemeMode == ThemeMode.dark;

  /// Get currently selected theme
  int? get selectedThemeIndex {
    if (themes != null && themes!.isNotEmpty) {
      int? themeIndex = _sharedPreferences.themeIndex;
      return themeIndex == null ? 0 : themeIndex;
    }
    return null;
  }

  ThemeManager({
    this.themes,
    this.statusBarColorBuilder,
    this.navigationBarColorBuilder,
    this.darkTheme,
    this.lightTheme,
    this.defaultTheme = ThemeMode.system,
  }) {
    var hasMultipleThemes = themes != null && themes!.length > 1;
    var hasLightAndDarkThemes = darkTheme != null && lightTheme != null;
    assert(hasMultipleThemes || hasLightAndDarkThemes,
        '''You have to supply themes if you want to use themes. You have supplied no themes. Don\'t do that. Supply themes.
You can supply either a list of ThemeData objects to the themes property or a lightTheme and a darkTheme to be swapped between.
        ''');

    var storedThemeIndex = _sharedPreferences.themeIndex;

    ThemeData? selectedTheme;

    if (hasMultipleThemes) {
      if (storedThemeIndex != null) {
        try {
          selectedTheme = themes![storedThemeIndex];
        } catch (e) {
          print(
              '''WARNING: You have changed your number of themes. Because of this we will clear your previously selected
        theme and broadcast the first theme in your list of themes.''');
          _sharedPreferences.themeIndex = null;
          selectedTheme = themes!.first;
        }
      } else {
        selectedTheme = themes!.first;
      }
      updateOverlayColors(selectedTheme);
    } else {
      _selectedThemeMode = defaultTheme;

      var savedUserThemeMode = _sharedPreferences.userThemeMode;
      if (savedUserThemeMode != null) {
        _selectedThemeMode = savedUserThemeMode;
      }

      if (_selectedThemeMode == ThemeMode.system) {
        final brighteness =
            SchedulerBinding.instance?.window.platformBrightness;
        selectedTheme = brighteness == Brightness.dark ? darkTheme : lightTheme;
      } else {
        selectedTheme =
            _selectedThemeMode == ThemeMode.dark ? darkTheme : lightTheme;
      }

      updateOverlayColors(selectedTheme);
    }

    ThemeModel _currTheme = ThemeModel(
        selectedTheme: selectedTheme,
        darkTheme: darkTheme,
        themeMode: _selectedThemeMode);

    _themesController = BehaviorSubject<ThemeModel>.seeded(_currTheme);
    _initialTheme = _currTheme;

    ThemeService.getInstance().setThemeManager(this);
  }

  ThemeModel getSelectedTheme() {
    var selectedTheme =
        _selectedThemeMode == ThemeMode.dark ? darkTheme : lightTheme;
    return ThemeModel(
        selectedTheme: selectedTheme,
        darkTheme: darkTheme,
        themeMode: _selectedThemeMode);
  }

  /// Sets the theme for the application equal to the theme at the index
  /// in the list of [themes] supplied to the [ThemeBuilder]
  Future selectThemeAtIndex(int themeIndex) async {
    if (themes == null || themes!.isEmpty) {
      throw Exception(
          'You cannot select the theme if you have no themes supplied. Supply a list of themes to the constructor of the ThemeManager if you want to use this function.');
    }

    var theme = themes![themeIndex];
    await updateOverlayColors(theme);

    _themesController.add(ThemeModel(
      selectedTheme: theme,
      darkTheme: darkTheme,
      themeMode: _selectedThemeMode,
    ));

    _sharedPreferences.themeIndex = themeIndex;
  }

  Future _applyStatusBarColor(ThemeData? theme) async {
    if (_platformService.isMobilePlatform) {
      var statusBarColor = statusBarColorBuilder?.call(theme);
      if (statusBarColor != null) {
        await _statusBarService.updateStatusBarColor(statusBarColor);
      }
    }
  }

  Future _applyNavigationBarColor(ThemeData? theme) async {
    // Change color only when not on web
    if (_platformService.isMobilePlatform) {
      var navigationBarColor = navigationBarColorBuilder?.call(theme);
      if (navigationBarColor != null) {
        await _statusBarService.updateNavigationBarColor(navigationBarColor);
      }
    }
  }

  Future<void> updateOverlayColors(ThemeData? theme) async {
    _applyStatusBarColor(theme);
    _applyNavigationBarColor(theme);
  }

  /// Swaps between the light and dark ThemeMode
  void toggleDarkLightTheme() {
    _selectedThemeMode =
        _selectedThemeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    updateOverlayColors(
        _selectedThemeMode == ThemeMode.dark ? darkTheme : lightTheme);
    _themesController.add(ThemeModel(
      selectedTheme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _selectedThemeMode,
    ));
  }

  void setThemeMode(ThemeMode themeMode) {
    _selectedThemeMode = themeMode;

    _sharedPreferences.userThemeMode = themeMode;

    if (themeMode != ThemeMode.system) {
      updateOverlayColors(
          _selectedThemeMode == ThemeMode.dark ? darkTheme : lightTheme);
    } else {
      var currentBrightness =
          SchedulerBinding.instance!.window.platformBrightness;
      updateOverlayColors(
          currentBrightness == Brightness.dark ? darkTheme : lightTheme);
    }

    _themesController.add(ThemeModel(
      selectedTheme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _selectedThemeMode,
    ));
  }
}

/// Returns the [ThemeManger] that
ThemeManager getThemeManager(BuildContext context) =>
    Provider.of<ThemeManager>(context, listen: false);

class ThemeModel {
  final ThemeData? selectedTheme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;

  ThemeModel({
    required this.selectedTheme,
    required this.darkTheme,
    required this.themeMode,
  });
}
