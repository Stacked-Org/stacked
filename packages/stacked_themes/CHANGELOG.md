## 0.3.8+2

- Updates Example's kotlin version to 1.4.10
- Updates Example's Android Embedding to Version 2
- Updates Example's CompileSdk to 31

## 0.3.8+1

- bumps versions of provider and and status bar package

## 0.3.8

- Adds `navigationBarColorBuilder` to change navigation bar color

## 0.3.7

- Fixed `flutter_statusbarcolor_ns` deprecated Android embedding warning

## 0.3.6

- Replaced `dart:io` with `universal_io`

## 0.3.5

- Fixed `PlatformService` registration issue

## 0.3.4

- Fixed Expception being thrown for non-Android and non-iOS platform

## 0.3.3

- Updated dependencies:

  - rxdart: ^0.26.0 -> ^0.27.1
  - shared_preferences: ^2.0.4 -> ^2.0.6
  - get_it: ^6.0.0 -> ^7.1.3
  - mockito: ^5.0.0-nullsafety.7 -> ^5.0.9

## 0.3.2

- Makes `ThemeService.getInstance` non-nullable since we'll always construct a theme service in there if null

## 0.3.1

- Adds a `selectedThemeIndex` property to ThemeManager for getting currently enabled theme.

## 0.3.0

- Updates the package to null-safety

## 0.2.4

- provider: ^4.3.3 -> ^5.0.0
- rxdart: ^0.25.0 -> ^0.26.0
- shared_preferences: ^0.5.12+4 -> ^2.0.4
- get_it: ^5.0.6 -> ^6.0.0

## 0.2.3

- Use get_it newInstance to avoid clashing with the app

## 0.2.2+2

- Updates packages to the latest

## 0.2.2+1

- Updates get it to latest

## 0.2.2

- Re-apply system ThemeMode when we get back from background

## 0.2.1+1

- Fixes bad push

## 0.2.1

- Exposes `ThemeManagerMode` on the `ThemeService` and `ThemeMode` on the `ThemeManager`.

## 0.2.0

- Adds functionality for setting the `ThemeMode` directly using `setThemeMode` function on the `ThemeManager`

## 0.1.0+1

- Adds missing parameter in theme mode

## 0.1.0

- Initial release of Themes functionality
