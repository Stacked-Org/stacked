## 0.8.0-beta.4
- Support providing enums as route arguments
## 0.8.0-beta.3
- Support providing functions as route arguments
## 0.8.0-beta.2
- Apply a more general fix to the aliased imports in stacked generator
## 0.7.16-beta.0
- Replace `FormViewModel` to `FormStateHelper`
## 0.7.15

- Updates analyzer package
- Fixes deprecated element and enclosingElement2
## 0.7.14

- Add `instanceName` parameter to the DependencyRegistration annotation
## 0.8.0-beta.1
- Fixes assign import alias to view with a list parameter 
## 0.8.0-beta.0

- Migrate the router generator to use [code_builder](https://pub.dev/packages/code_builder)
- Fixes [#690](https://github.com/FilledStacks/stacked/issues/690)
## 0.7.13

- Fixes dublicated types imports not added

## 0.7.12

- Fixes missing comma on default transition builder

## 0.7.11

- Fixes the logger not printing method name on flutter web
- Cleanup and refactor the logger code
  
## 0.7.10

- Fixes issue with imports for deeply nested views
- Removes duplicate strongly typed methods

## 0.7.9+1

- Removes print statement that clutters the logs

## 0.7.9

- Add bottomsheets generator

## 0.7.8

- Adds a method to manually validate fields on FormViewModel

## 0.7.7

- Add [customTextEditingController] to [FormTextField]
- Fixes [#384](https://github.com/FilledStacks/stacked/issues/384)

## 0.7.6

- Fixes [#664](https://github.com/FilledStacks/stacked/issues/664)
- Fixes [#591](https://github.com/FilledStacks/stacked/issues/591)

## 0.7.5

- Fixes Strongly Typed id param never allowing id as a view param

## 0.7.4

- Prevent throwing an error when routes is not provided in StackedApp

## 0.7.3

- Fixes Import for Adaptive Route

## 0.7.2

- Add default values to Strong Type Navigation parameters

## 0.7.1

- Add Strong Type Navigation parameters

## 0.7.0

- Add dialogs generator

## 0.6.6+1

- Readme update 
  
## 0.6.6
- Fixes bug [#627](https://github.com/FilledStacks/stacked/issues/627)
- TextEditingControllers are now created and disposed better.
  
## 0.6.5
- Major refacor to the router_generator but no changes
  
## 0.6.3

- Replace dependency on stacked with stacked_core
## 0.6.2

- Enables multi logger output only in release mode

## 0.6.1

- Adds type case for extension getters to adhere to 

```yaml
strong-mode:
    implicit-casts: false
``` 

linting rule when generating `ValueProperties` for a form



## 0.6.0

- Adds per-field validation message
- Bumps stacked to `2.3.0`

## 0.5.7

- Adds functionality to disable generated logger in release mode

## 0.5.6

- Fixed Route generation with generic return types

## 0.5.5

- Reverts update from 0.5.4 lol. (sorry, some confusion with a different bug)

## 0.5.4

- Reverts update from 0.5.3

## 0.5.3

- Generate correct return type for returning a route to pop

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
