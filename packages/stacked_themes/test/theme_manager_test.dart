import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_themes/src/theme_manager.dart';

import 'test_setup.dart';

void main() {
  group('ThemeManagerTest -', () {
    setUp(() => registerServices());
  
    tearDown(() => unregisterServices());

    group('Construction -', () {
      test(
          'When constructed and last theme index is 1, should broadcast theme at 1 as selected theme',
          () async {
        getAndRegisterSharedPreferencesServiceMock(themeIndex: 1);

        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];

        var themeManager = ThemeManager(themes: themes);
        themeManager.themesStream.listen(expectAsync1((theme) {
          expect(theme.selectedTheme, themes[1]);
        }));
      });

      test(
          'When constructed and last theme index is 2, if the new theme manager has less themes, broadcast first',
          () async {
        getAndRegisterSharedPreferencesServiceMock(themeIndex: 2);

        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];

        var themeManager = ThemeManager(themes: themes);
        themeManager.themesStream.listen(expectAsync1((theme) {
          expect(theme.selectedTheme, themes.first);
        }));
      });

      test(
          'When constructed and last theme index is 2, if the new theme manager has less themes, reset theme',
          () async {
        var sharedPreferences =
            getAndRegisterSharedPreferencesServiceMock(themeIndex: 2);

        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];

        ThemeManager(themes: themes);
        verify(sharedPreferences.themeIndex = null);
      });

      test(
          'When constructed and no theme has been selected we broadcast the first theme',
          () async {
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];

        var themeManager = ThemeManager(themes: themes);
        themeManager.themesStream.listen(expectAsync1((theme) {
          expect(theme.selectedTheme, themes.first);
        }));
      });
    });

    group('themesStream -', () {
      test('After construction, should broadcast the first theme from themes',
          () {
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var themeManager = ThemeManager(themes: themes);
        themeManager.themesStream.listen(expectAsync1((theme) {
          expect(theme.selectedTheme, themes.first);
        }));
      });
    });

    group('selectThemeAtIndex -', () {
      test(
          'When called with index 1, should broadcast the theme at 1 over the themesStream',
          () {
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var themeManager = ThemeManager(themes: themes);
        bool alreadyCalled = false;
        themeManager.themesStream.listen(expectAsync1((theme) {
          if (alreadyCalled) {
            expect(theme.selectedTheme, themes[1]);
          }
          alreadyCalled = true;
        }, count: 2));

        themeManager.selectThemeAtIndex(1);
      });

      test('When called with index, should get status color from the callback',
          () async {
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        bool called = false;
        var themeManager = ThemeManager(
            themes: themes,
            statusBarColorBuilder: (themeData) {
              called = true;
              return null;
            });

        await themeManager.selectThemeAtIndex(1);

        expect(called, true);
      });

      test(
          'When called with index, should pass color to the status bar service',
          () async {
        var statusBar = getAndRegisterStatusBarServiceMock();
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var themeManager = ThemeManager(
          themes: themes,
          statusBarColorBuilder: (theme) => theme!.primaryColor,
        );

        await themeManager.selectThemeAtIndex(1);
        verify(statusBar.updateStatusBarColor(themes.first.primaryColor));
      });
    });

    group('Dark and Light -', () {
      test(
          'When constructed with ThemeMode.system, should broadcast ThemeMode.system in the ThemeModel',
          () {
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var themeManager =
            ThemeManager(darkTheme: themes.first, lightTheme: themes.last);

        themeManager.themesStream.listen(expectAsync1((theme) {
          expect(theme.themeMode, ThemeMode.system);
        }));
      });

      test(
          'When constructed with ThemeMode.light, should broadcast ThemeMode.light in the ThemeModel',
          () {
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var themeManager = ThemeManager(
          darkTheme: themes.first,
          lightTheme: themes.last,
          defaultTheme: ThemeMode.light,
        );

        themeManager.themesStream.listen(expectAsync1((theme) {
          expect(theme.themeMode, ThemeMode.light);
        }));
      });

      test(
          'When constructed with ThemeMode.system, should check if user has a savedThemeMode',
          () {
        var sharedPreferences = getAndRegisterSharedPreferencesServiceMock();
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        ThemeManager(
          darkTheme: themes.first,
          lightTheme: themes.last,
          defaultTheme: ThemeMode.system,
        );

        verify(sharedPreferences.userThemeMode);
      });

      test(
          'When constructed with ThemeMode.light, and user has saved theme dark, should broadcast dark',
          () {
        getAndRegisterSharedPreferencesServiceMock(
          userThemeMode: ThemeMode.dark,
        );
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var manager = ThemeManager(
          darkTheme: themes.first,
          lightTheme: themes.last,
          defaultTheme: ThemeMode.light,
        );

        manager.themesStream.listen(expectAsync1((theme) {
          expect(theme.themeMode, ThemeMode.dark);
        }));
      });

      test(
          'When manager constructed with Light, When toggleDarkLightTheme is called, should broadcast Dark theme mode',
          () {
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var manager = ThemeManager(
          darkTheme: themes.first,
          lightTheme: themes.last,
          defaultTheme: ThemeMode.light,
        );

        bool alreadyCalled = false;
        manager.themesStream.listen(expectAsync1((theme) {
          if (alreadyCalled) {
            expect(theme.themeMode, ThemeMode.dark);
          }
          alreadyCalled = true;
        }, count: 2));

        manager.toggleDarkLightTheme();
      });

      test(
          'When manager constructed with Light, should get the statusColor from the builder',
          () {
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var statusColor;
        ThemeManager(
            darkTheme: themes.first,
            lightTheme: themes.last,
            defaultTheme: ThemeMode.light,
            statusBarColorBuilder: (theme) {
              statusColor = theme?.primaryColor;
              return statusColor;
            });

        expect(statusColor, themes.last.primaryColor);
      });

      test(
          'When manager constructed with Light, When toggleDarkLightTheme is called, should get the statusColor from the builder',
          () {
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var statusColor;
        var manager = ThemeManager(
            darkTheme: themes.first,
            lightTheme: themes.last,
            defaultTheme: ThemeMode.light,
            statusBarColorBuilder: (theme) {
              statusColor = theme?.primaryColor;
              return statusColor;
            });

        manager.toggleDarkLightTheme();
        expect(statusColor, themes.first.primaryColor);
      });
    });

    group('setThemeMode -', () {
      test(
          'When called with ThemeMode.dark, should save the theme mode to shared preferences',
          () {
        var preferences = getAndRegisterSharedPreferencesServiceMock();
        var themeManager = ThemeManager(
          lightTheme: ThemeData(),
          darkTheme: ThemeData(),
        );
        themeManager.setThemeMode(ThemeMode.dark);
        verify(preferences.userThemeMode = ThemeMode.dark);
      });

      test(
          'When called with ThemeMode.dark, should set the status bar color from the ThemeManager',
          () async {
        bool called = false;
        var themeManager = ThemeManager(
            lightTheme: ThemeData(),
            darkTheme: ThemeData(),
            statusBarColorBuilder: (themeData) {
              called = true;
              return null;
            });

        themeManager.setThemeMode(ThemeMode.dark);

        expect(called, true);
      });

      test(
          'When called with ThemeMode.dark, should broadcast the theme data over the theme stream',
          () {
        var themeManager = ThemeManager(
          lightTheme: ThemeData(),
          darkTheme: ThemeData(),
        );

        bool alreadyCalled = false;
        themeManager.themesStream.listen(expectAsync1((theme) {
          if (alreadyCalled) {
            expect(theme.themeMode, ThemeMode.dark);
          }
          alreadyCalled = true;
        }, count: 2));

        themeManager.setThemeMode(ThemeMode.dark);
      });
    });

    group('Theme Persistence -', () {
      test(
          'When a theme changes the index should be persisted into shared preferences',
          () async {
        var sharedPreferences = getAndRegisterSharedPreferencesServiceMock();
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var themeManager = ThemeManager(themes: themes);
        await themeManager.selectThemeAtIndex(1);
        verify(sharedPreferences.themeIndex = 1);
      });

      test(
          'When theme manager contructed, should get the themeIndex from the shared preferences',
          () {
        var sharedPreferences = getAndRegisterSharedPreferencesServiceMock();
        ThemeManager(themes: [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ]);
        verify(sharedPreferences.themeIndex);
      });
    });
  });
}
