# ChangeLog

## 0.5.2

- Adds `orElse` handler in the logger `realFirstLine` variable to fix [issue #455](https://github.com/FilledStacks/stacked/issues/455)
- Disposes the focusNodes while calling `disposeForm`
- Update analyzer dependency to `analyzer: ^2.0` (you can upgrade json_serialization to 5.0 without dependency conflicts)

## 0.5.1


- Added ability to pass parameter to factories with `FactoryWithParam`

## 0.5.0

- Fixes nullable type generation issue on `@PathParam` and `@QueryParam`

## 0.4.9

- Fixes Default parameter value generation bug on stacked router
  [issue #411](https://github.com/FilledStacks/stacked/issues/411)

## 0.4.8

- Added ability to pass custom logger outputs to MultiLoggerOutput

## 0.4.7

- Use the default filter for the logger

## 0.4.6

- Added functionality to supply custom `locator` and `setupLocator` names.

## 0.4.5

- Fixed code generation issue from last release

## 0.4.4

- Fixes stacked version

## 0.4.3

- Added `Environment` on Dependency Injection

## 0.4.2

- Adds `initialValue` parameter for `FormTextField` to support initial value in the `TextEditingController`
- Fixes `Route TransitionsBuilders` generation

## 0.4.1

- Fixes regular expression bug causing function name not to show up in logs

## 0.4.0

- Adds option to generate a logger with formatting and automatic function name printing
- Bumps stacked to `2.1.0`

## 0.3.3

- Fixed Static dropdown list generation

## 0.3.2

- Fixed unexpected empty string import

## 0.3.1-nullsafety.3

- Generate nulllable formView property getters

## 0.3.1-nullsafety.2

- fixes DatePicker changes bugs

## 0.3.1-nullsafety.1

- Adds DatePicker form field option to the Form Generation functionality

## 0.3.0-nullsafety.1

- Migrates to null safety

## 0.2.7

- Bumps build and source gen

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
