## 1.4.0

- **Breaking**: fix imports & import visibility and change file names.

## [1.3.4] - 2020-05-03 - Added DynamicDataSource funtionality to swap streams at runtime

## [1.3.3] - 2020-05-03 - Removed the hooks dependency and moved code to stacked_hooks package

## [1.3.2] - 2020-05-02 - Fixed StreamViewModel functionality

## [1.3.1] - 2020-05-01 - Added the HookViewModelWidget to use the ViewModelWidget with flutter_hooks

## [1.3.0+3] - 2020-04-30 - Pass type to the base models of ViewModel

## [1.3.0+2] - 2020-04-30 - ReadMe updates

## [1.3.0+1] - 2020-04-28 - onModelReady taken out of post frame callback

## [1.3.0] - 2020-04-28 - Adds Mulitple streams ViewModel Builder

## [1.2.4] - 2020-04-28 - onModelReady updates

- `onModelReady` is not called every time the model is constructed
- `onModelReady` is called after the current frame is rendered by using `postFrameCallback` internally.

## [1.2.3] - 2020-04-28 - Added BuildContext to ViewModelBuilder for WidgetBuilder

## [1.2.2+1] - 2020-04-27 - Updated ChangeLog order

## [1.2.2] - 2020-04-26 - Moved stream subscription to after ViewModel construction

## [1.2.1+2] - 2020-04-26 - Description Update 2

## [1.2.1+1] - 2020-04-26 - Description Update

## [1.2.1] - 2020-04-26 - Added ViewModelBuilderWidget

- The `ViewModelBuilderWidget` removes boiler plate code for using a `ViewModelBuilder` to provide the View->ViewModel rebuild functionality.

## [1.2.0] - 2020-04-24 - Added FutureViewmodel

- The `FutureViewModel` removes boiler plate code for a ViewModel that depends on data returned from a Future.

## [1.1.0] - 2020-04-23 - Added StreamViewModel

- The `StreamViewModel` removes boiler plate code for listening to a Stream and notifying listeners as the data comes in.

## [1.0.3+3] - 2020-04-23 - Added isBusy to BaseViewModel

## [1.0.3+2] - 2020-04-23 - Added Migration from provider_architecture to stacked

## [1.0.3+1] - 2020-04-22 - Updated Readme

## [1.0.3] - 2020-04-22 - Adds back setBusy call to BaseViewModel

## [1.0.2] - 2020-04-22 - Reactive Viewmodel updates

- Instead of depending on the user to call set reactive services we require an override to provide a list of services

## [1.0.1] - 2020-04-21 - Readme instruction updates

## [1.0.0] - 2020-04-20

- First release of the architecture containing all the initial required parts to build a full application.
