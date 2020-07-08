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
