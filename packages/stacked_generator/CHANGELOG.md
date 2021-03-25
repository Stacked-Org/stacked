# ChangeLog

## 0.3.0-nullsafety.1

- Migrates to null safety

## 0.2.6

- Adds the `resolveUsing` code generation for `Singleton` and `LazySingleton` registrations

## 0.2.5

- Removes dependency on logger

## 0.2.4

- Bumps `analyzer` and `build_runner` versions

## 0.2.3

- Fixes issue #240

## 0.2.2

- Adds support to register a service `asType` when generating the getIt registrations

## 0.2.1

- fixes the incompaitility with using an analyzer version that requires the withNullability argument on .getDisplayString()

## 0.2.0

- Adds form generation functionality

## 0.1.3

- Updates the analyzer dependency to `">=0.39.2 <0.41.2"`

## 0.1.2

- Updates generator to use `StackedLocator` for `.locator.dart` file

## 0.1.1

- Makes the dependencies optional

## 0.1.0 - Initial functionality

- Generate a `StackedRouter` from the routes defined on `StackedApp`
- Generate all get_it registrations from the dependencies defined on `StackedApp`
