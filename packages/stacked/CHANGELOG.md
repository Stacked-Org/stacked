## 3.1.0-beta.3

- Deprecates `ViewModelBuilderWidget` in favour of `StackedView`
- Deprecates `HookViewModelWidget` in favour of `StackedHookView`
- Deprecates `fireOnModelReadyOnce` in favour of `fireOnViewModelReadyOnce`
- Deprecates `onModelReady` in favour of `onViewModelReady`

## 3.1.0-beta.2

- Adds `listenersCount` to `ListenableServiceMixin`
- Updates ViewModels to use `viewModel` instead of `model`

## 3.1.0-beta.1

- Makes setFormStatus as NOT required override
- Adds a better named `rebuildUi` function to replace `notifyListeners`

## 3.1.0-beta.0

- Renames ViewModelBuilderWidget to StackedView
- Updates BuilderWidgetExampleView

## 3.0.1

- Add onDispose method to ViewModelBuilderWidget

## 3.0.0+2

- Fix [#767](https://github.com/FilledStacks/stacked/issues/767)

## 3.0.0+1

- Replace the old `ReactiveValues` approach with `notifyListeners()` when using the `ReactiveServiceMixin` in readme

## 3.0.0

- Passes generic argument to `DataStateHelper`
- Uses `FormStateHelper` for the `FormViewModel`
- Adds `BusyAndErrorStateHelper` to the `BaseViewModel`
- Refactor `BaseViewModel` by extracting the different functionalities to mixins.
- Remove the inconsistency between the `BaseViewModel` and `FutureViewModel`, `StreamViewModel` when setting the error, data values.
- Now we have three mixins that can be mix with any viewmodel and they are:
  - `FutureRunnerHelper` that has `runBusyFuture` and `runErrorFuture` functions.
  - `MessageStateHelper` that adds message property to the viewmodel.
  - `DataStateHelper` that adds data property to the viewmodel.
  - `FormStateHelper` that gives the flexibility to mixin the form functionality with the  any other view model.
  - `IndexTrackingStateHelper` that give the flexibility to mixin the index tracking in a bottom navigation bar any other view model.

## 2.3.15

- Rename `SelectorViewModelBuilderWidget` and `SelectorViewModelWidget` similar to `ViewModelWidget`

## 2.3.14

- Adds `SelectorViewModelBuilder` and `SelectorViewModelBuilderWidget`

## 2.3.13

- Adds Message state functionality for view models

## 2.3.12

- Fix [#486](https://github.com/FilledStacks/stacked/issues/486)

## 2.3.11

- Fix [#546](https://github.com/FilledStacks/stacked/issues/546)

## 2.3.10

- Fixes issues on navigation

## 2.3.9

- Pump stacked_core version
- Update example app

## 2.3.8

- Remove duplicate code and Clean up

## 2.3.7

### Flutter v3 compatibility

- Use [ambiguate](https://docs.flutter.dev/development/tools/sdk/release-notes/release-notes-3.0.0#your-code) to ensure v3 (and backward) compatibility

### Fixes

- Add move in left route transition

## 2.3.6

- Reverts 2.3.4

## 2.3.5

- Use the stacked_core package to expose the stacked_annotation

## 2.3.4

- Updates MultipleStreamViewModel to take generic type for key

## 2.3.3+1

- Updates Example's kotlin version to 1.4.10
- Updates Example's Android Embedding to Version 2
- Updates Example's CompileSdk to 31

## 2.3.3

- Returns a null value for catchError handler when using FutureViewModel

## 2.3.2

- Reverts 2.3.1

## 2.3.1

- Handles the futureToRun viewmodels with try/catch and not catchError function

## 2.3.0

### New Feature: Adds per field validation

- A setValidationMessage will now be generated for each field for you to set and use similar to the global validation message that was used before

- Breaking changes on `FormViewModel`
  - `showValidation` → `showValidationMessage`

## 2.2.8

- Adds `disableReleaseConsoleOutput` to the logger annotation to disable console output in release mode

## 2.2.7+1

- Upgraded the dependency on `provider` to 6.0.0

## 2.2.7

- Fixes non-reactive `ViewModelBuilderWidget`

## 2.2.6

- Optimized skeleton loader to be dynamic

## 2.2.5

- Added IgnorePointer to Skeleton Loader Widget

## 2.2.4

- Added Skeleton Loader Widget to show a shimmer when data is loading
- Added skeletonData on viewmodels for busy data values

## 2.2.3

- Added ability to pass parameter to factories
  Add service to `FactoryWithParam` in `StackedApp` and annotate paramaters with `@factoryParam` which needed to be passed in the Factory constructor
- Improved error setting base functionality

## 2.2.2

- Added view model argument to `ViewModelBuilder` on method `onDispose` callback

## 2.2.1

- Replaced `dart:io` with `universal_io`

## 2.2.0

- Fixes nullable type generation issue on `@PathParam` and `@QueryParam`

## 2.1.9

- Added ability to pass custom logger outputs to MultiLoggerOutput

## 2.1.8

- Fixes `ReactiveServiceMixin` in Services to handle `ChangeNotifier` updates

## 2.1.7

- updates `get_it` to the latest

## 2.1.6

- `Environments` now will be automatically registered which eliminates the need to call `registerEnvironment` manually if generated `setupLocator` wasn't used

## 2.1.5

- Added functionality to supply custom `locator` and `setupLocator` names.

## 2.1.4

- Removes forced nullable type

## 2.1.3

- Added `Environment` on Dependency Injection

## 2.1.2

- Added return type for `runBusyFuture` and `runErrorFuture`

## 2.1.1

- Exports Transition builders

## 2.1.0

- Adds annotations to allow the user to generate a logger for their app

## 2.0.4

- Updates the extended router functionality to use non null routes

## 2.0.3+1

- Exposed `buildAdaptivePageRoute`, `misTypedArgsRoute` and `defaultUnknownRoutePage` functions to outer world
- Changed `OutlineButton` to `OutlinedButton` (removed deprecated code)

## 2.0.3

- Fixed where anyObjectsBusy was always true in MultipleFutureViewModel.

## 2.0.2

- Made ViewModel variable naming scheme consistent. `ViewModel viewModel` is now preferred.

## 2.0.1

- Adds ReactiveValue and ReactiveList for reactive functionality

## 2.0.0

- Null safety migration complete and ready to be used!

## 2.0.0-nullsafety.3

- Fixes annotation to allow for date selection

## 2.0.0-nullsafety.2

- Adds back `resolveUsing` function to the annotations

## 2.0.0-nullsafety.1

- Migrate to null-safety. We will remove null safety when we iron out all the issues

## 1.9.8

- Exposes `RouteGuard` through stacked as well

## 1.9.7

- Adds `resolveUsing` function that can be used for singleton type dependency registrations.

## 1.9.6

- Exports the `ExtendedNavigator` for nested navigation
- Update provider in stacked to 5.0.0
- Revert nonReactive update update for stacked
- Update get_it to 6.0.0
- Will revert fix for issue that came with disposing a nonReactive Viewmodel.

## 1.9.5

- Adds the asType property into the locator types

## 1.9.4

- Adds fix for [issue #171](https://github.com/FilledStacks/stacked/issues/171)

## 1.9.3

- Adds onDispose functionality

## 1.9.2

### MAJOR UPDATE: FORMS!!!

- Adds brand new form first party support and form generation functionality

## 1.9.1+2

- Fix null error from locator

## 1.9.1+1

- Adds export for `StackedLocator`

## 1.9.1

- Adds `StackedLocator` to remove the apps dependency from GetIt. It's a thin wrapper around the `GetIt` object implementation

## 1.9.0

Big Update! This version of stacked aims to reduce the boiler plate required to setup a stacked application. We introduce the annotation that are used by the stacked_generator to generate the router and locator setup functionality.

## 1.7.7

- Fixes [Multiple Streams ViewModel causing memory overflow](https://github.com/FilledStacks/stacked/issues/190) bug

## 1.7.6

- Adds `fireOnce` properties to the `ViewModelBuilderWidget`

## 1.7.5

- Adds rethrow capability to the `FutureViewModel`

## 1.7.4

- Makes index tracking viewmodel a reactive viewmodel so it can react to services

## 1.7.3+2

- REVERT: Use hascode for hasErrorForObject function instead of value directly

## 1.7.3+1

- Use hascode for hasErrorForObject function instead of value directly

## 1.7.3

- Removes old error handling code for specialty viewmodels

## 1.7.2

- Adds `RxSet` to the reactive list of functionalities.

## 1.7.1+1

- Adds `initialiseSpecialViewModelsOnce` to the readme.

## 1.7.1

- Adds `initialiseSpecialViewModelsOnce` property to set initialise function call to only fire once.

## 1.7.0+1

- Adds more migration notes

## 1.7.0 - [BREAKING CHANGES]

### Migrate from 1.6.1 -> 1.7

- hasError(key) -> error(key) for multiple ViewModel

- Adds `IndexTrackingViewModel` for help with BottomNavBar
- Adds better error handling for `BaseViewModel`

## 1.6.1+1

- Adds `fireOnModelReadyOnce` to readme

## 1.6.1

- Adds `fireOnModelReadyOnce` to be used together with `disposeViewModel` to ensure a viewmodel that's already been constructed doesn't call onModelReady every time it's shown on screen.

## 1.6.0+1

- Adds onCancel call for the MultiStreamViewModel

## 1.6.0

- Adds dispose protection when calling notifyListeners.

## 1.5.8

- Adds `anyObjectsBusy` to `FutureViewModels` to report if there are any futures's that are still running

## 1.5.7+1

- fixed busy state hash code problem

## 1.5.7

- Exposes notifyListeners to the service for rebuilding ViewModels that are listening

## 1.5.6+1

- added back busy to false state when busy future is complete without an error

## 1.5.6

- runBusyFuture now sets itself to not busy when exception is thrown
- runBusyFuture has parameter throwException which will rethrow the caught exception to the caller

## 1.5.5+1

- Reverted commit below

## 1.5.5

- Added fix to set busy back to false when the future throws an exception

## 1.5.4+1

- Added `MultipleStreamViewModel` example into the readme

## 1.5.4

- Made specialty viewmodels reactive as well so you can supply reactive services as an override

## 1.5.3

- Expose subscription for single stream viewmodel and getSubscriptionForKey for multiple stream viewmodel.

## 1.5.2

- Added `onData` function into `FutureViewModel` that can be overridden

## 1.5.1

- Ensure model is busy as soon as runFuture notifyListeners for the first time

## 1.5.0

- Adds functionality to support `RxList`

## 1.4.3

- Added functionality to save the error thrown by the calling future

## 1.4.2

- Added `getParentViewModel` functionality for accessing a provided ViewModel above in the widget tree

## 1.4.1+2

- Busy for Object bug fix in base viewmodel

## 1.4.1+1

- Change log styling updates

## 1.4.1

- Added the `const` keyword to the following widget constructors:
  - `ViewModelBuilder.nonReactive`, `ViewModelBuilder.reactive`, and `ViewModelWidget`

## 1.4.0+1

- [Breaking] Moved private files into src folder

## 1.4.0

- Breaking Moved private files into src folder
- Fix imports, import visibility and changed file names.

## 1.3.4

- Added DynamicDataSource funtionality to swap streams at runtime

## 1.3.3

- Removed the hooks dependency and moved code to stacked_hooks package

## 1.3.2

- Fixed StreamViewModel functionality

## 1.3.1

- Added the HookViewModelWidget to use the ViewModelWidget with flutter_hooks

## 1.3.0+3

- Pass type to the base models of ViewModel

## 1.3.0+2

- ReadMe updates

## 1.3.0+1

- onModelReady taken out of post frame callback

## 1.3.0

- Adds Mulitple streams ViewModel Builder

## 1.2.4

- onModelReady updates

- `onModelReady` is not called every time the model is constructed
- `onModelReady` is called after the current frame is rendered by using `postFrameCallback` internally.

## 1.2.3

- Added BuildContext to ViewModelBuilder for WidgetBuilder

## 1.2.2+1

- Updated ChangeLog order

## 1.2.2

- Moved stream subscription to after ViewModel construction

## 1.2.1+2

- Description Update 2

## 1.2.1+1

- Description Update

## 1.2.1

- Added ViewModelBuilderWidget
- The `ViewModelBuilderWidget` removes boiler plate code for using a `ViewModelBuilder` to provide the View->ViewModel rebuild functionality.

## 1.2.0

- Added FutureViewmodel
- The `FutureViewModel` removes boiler plate code for a ViewModel that depends on data returned from a Future.

## 1.1.0

- Added StreamViewModel
- The `StreamViewModel` removes boiler plate code for listening to a Stream and notifying listeners as the data comes in.

## 1.0.3+3

- Added isBusy to BaseViewModel

## 1.0.3+2

- Added Migration from provider_architecture to stacked

## 1.0.3+1

- Updated Readme

## 1.0.3

- Adds back setBusy call to BaseViewModel

## 1.0.2

- Reactive Viewmodel updates
- Instead of depending on the user to call set reactive services we require an override to provide a list of services

## 1.0.1

- Readme instruction updates

## 1.0.0

- First release of the architecture containing all the initial required parts to build a full application.

