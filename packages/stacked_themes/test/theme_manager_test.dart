import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_themes/src/theme_manager.dart';

import 'test_setup.dart';

void main() {
  group('ThemeManagerTest -', () {
    group('Construction -', () {
      test('When constructed with themes, should not throw exception', () {
        expect(
          () => ThemeManager(),
          throwsA(null),
        );
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
          expect(theme, themes.first);
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
            expect(theme, themes[1]);
          }
          alreadyCalled = true;
        }, count: 2));

        themeManager.selectThemeAtIndex(1);
      });
    });

    group('Theme Persistence -', () {
      test(
          'When a theme changes the index should be persisted into shared preferences',
          () {
        var sharedPreferences = getAndRegisterSharedPreferencesServiceMock();
        var themes = [
          ThemeData(primaryColor: Colors.blue),
          ThemeData(primaryColor: Colors.yellow),
        ];
        var themeManager = ThemeManager(themes: themes);
        themeManager.selectThemeAtIndex(1);
        verify(sharedPreferences.themeIndex = 1);
      });

      test(
          'When theme manager contructed, should get the themeIndex from the shared preferences',
          () {
        var sharedPreferences = getAndRegisterSharedPreferencesServiceMock();
        ThemeManager();
        verify(sharedPreferences.themeIndex);
      });
    });
  });
}
