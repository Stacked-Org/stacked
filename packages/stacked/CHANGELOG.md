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
