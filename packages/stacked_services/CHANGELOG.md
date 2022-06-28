## 0.9.1
- Hide the `message` widget in `showCustomSnackBar` when the message color is null and message is empty 
## 0.9.0
- ⚠️ Break Change ⚠️: Removed the following deprecated code from snackbar_service
  - `navigatorKey` getter
  - `registerCustomSnackbarconfig` method
  - `customData` parameter from `showCustomSnackBar` method
## 0.8.25
- Added clearStackAndShowView to clear stack and show widget directly 
## 0.8.24
- Flutter v3 compatibility 
## 0.8.22+2
- Update documentation.
## 0.8.22+1
- Adds Breaking change indication below.
## 0.8.22
- Fix navigation service
- Deprecate: transition and transitionClass and defaultTransition argument
- Update the example app
- Replace deprecated documentaion with new one
## 0.8.21
- Minor fix
## 0.8.20
- ⚠️ Break Change ⚠️: Remove the export of the Get package to hide its global variables
## 0.8.19

- Adds `titleTextStyle` and `messageTextStyle` to `showCustomSnackbar` to allow custom textstyles for snackbars.
- Fixes reference to `title` and `message` widget properties in `registerCustomSnackbarConfig` so they may now be optionally used where extra customization is preferrable.
- Adds `mainButtonStyle` in `showCustomSnackbar` to allow further customization.

## 0.8.18

- Adds useRootNavigator to bottomSheet

## 0.8.17+1

- Updates Example's kotlin version to 1.4.10
- Updates Example's Android Embedding to Version 2
  
## 0.8.17

- Add `buttonTitleColor` and `cancelTitleColor` to showDialog method when a dialogPlatform is passed.

## 0.8.16

- Updated `get` to latest package version
- Fixed bug on unknown `isSnackbar` and `SnackDismissDirection`

## 0.8.15

### Bottom Sheet Unique Name
When showing a bottom sheet we'll now give it a uique route name based on the properties passed in. The format of this will differ between the general and custom.
- general: `general_{md5hashOfTitleAndDescription}
- custom: `variant_{md5HashOfTitleDescriptionMainButtonTitleSecondaryButtonTitle}

The expected output of a bottom sheet will look like this

```dart
general_82fda55933c6a64eb961dfb6e13bdd4f // General and confirmation bottom sheet
BottomSheetType.FloatingBox_33557de8784ebb01ebd64b71926b5933 // Custom Bottom sheet with variant
```

## 0.8.14

- Updated `get` to latest package version

## 0.8.13

- Updated `get` to latest package version
- Fixed bug on unknown `Get.reference` and `route.name`

## 0.8.12

- Remove useRootNavigator from Dialog Service

## 0.8.11

- Add `ignoreSafeArea` parameter to `showBottomSheet` and `showCustomSheet`, pass down to `get` bottomSheet method

## 0.8.10

- Pass down generic types to `NavigationService` methods along with the properties relevant to `get` router

## 0.8.9

- Exports `get` package

## 0.8.8

- Added generic type arguments for `OverlayResponse` and `OverlayRequest` for dialogs and bottom sheets
- Deprecated `responseData` and added new property `data` that corresponds to that type provided
- Added 2 generic type arguments for `showCustomDialog` and `showCustomSheet`
- The first generic type argument for `showCustomDialog` from `DialogService` is intended for the response `data` and the second generic type argument for `showCustomSheet` from `BottomSheetService` is intended for the request payload `data`

## 0.8.7

- Added `currentArguments` in NavigationService

## 0.8.6

- Fixes empty space on showSnackbar if title is not given

## 0.8.5

- Adds prevent duplicates and parameters to `NavigationService`

## 0.8.4

- Adds support for TestSweets automation by providing keys

## 0.8.3

- Fixed where currentRoute in NavigationService was always null `routeObserver` from `StackedServices` needs to passed on `navigatorObservers` in `MaterialApp`

## 0.8.2

- Fixed barrierDismissible issue on BottomSheetService

## 0.8.1

Updates to latest version of get

## 0.8.0-nullsafety.1

- Migrates to null safety

## 0.7.3

- Removes the warning from the get package
- Complies with "Replaced reference to obsolete FlatButton button class in SnackBar"
- Support `ChangeNotifier` in `ReactiveServiceMixin`

## 0.7.2

- Fixes a regression bug for allowing null title and content for a dialog

## 0.7.1+3

- Fixes onTap signature

## 0.7.1+2

- Fixes snackBar config null exception when using builder

## 0.7.1+1

- Removes requirement for config

## 0.7.1

- Adds `snackbarConfigBuilder` to allow for building the config at runtime instead of before `runApp` is called

## 0.7.0

- Adds custom mainButtonBuilder to allow you to build a main button UI from the variant passed in

## 0.6.8

- Adds isOpen functionality

## 0.6.7

- Made dialog title or content optional

## 0.6.6

- Adds title and message textAlign to the config

## 0.6.5

- Allows for null title and message for custom snackbar

## 0.6.4

- Adds `isScrollControlled` to the bottom sheet function

## 0.6.3

- Adds `Color` to dialog service to set the color of the basic dialogs

## 0.6.2

- Adds functionality to allow to set isDismissible on the `BottomSheetService`

## 0.6.1

- Introduces the new `StackedService` class with the navigation properties on it. This is introduced to remove the confusion around every service having a key to set. So going forward if you want to use any of the services you just set the navigatorKey on the `StackedService`.

## 0.6.0+1

- Adds typed return for dialogs and sheets

## 0.6.0

- Adds bottom sheet service
- Adds dark theme for basic Material Dialogs
- Updates the way we complete Dialogs

## 0.5.4+5

- Updates get version to latest

## 0.5.4+4

- Adds an id to the `back` function on the `NavigationService` for nested back calls.

## 0.5.4+3

- Adds type to the navigation key

## 0.5.4+2

- Adds barrier label to custom dialog

## 0.5.4+1

- Updated get version

## 0.5.4

- Exposes `currentRoute` in the `NavigationService`

## 0.5.3

- Exposes `previousRoute` in the `NavigationService`

## 0.5.2

- Changes Dialog response to a `dynamic` value instead of `List<dynamic>`

## 0.5.1

### Custom Dialog

- Add ability, like Custom Snackbar, to registry multiple variants of dialog.
- Use variant term instead customData, I thins this is more clear then customData term to refer a specific type of Dialog
- Add a builder property to declare the UI.
- Rename registerCustomDialogUi to registerCustomDialogBuilder.
- Update documentation.

### Custom Snackbar

- Use variant term instead customData, like I said for Custom Dialog, I think this is more clear use the variant term instead customData to refer a specific.
- Normalize the name, instead registerCustomSnackbarconfig use the registerCustomSnackbarConfig.
- Update documentation.

## 0.5.0 - Custom Snackbar styling

- Adds `SnackbarConfig` functionality and associated functions for custom snackbar styling

## 0.4.11

- Exposes `barrierDismssible` on showConfirmation dialog

## 0.4.10

- Adds null check to dialog service completer

## 0.4.9

- Completes dialogCompleter for confirmation dialog as well

## 0.4.8

- Completes dialogCompleter if the custom dialog is dismissed without the button tap

## 0.4.7

- Makes the dialog completer finish when dialog is dismissed using barrier dismissal

## 0.4.6

- Removed injectable

## 0.4.5

- Bumps injectable version

## 0.4.4+3

- Bumps get version

## 0.4.4+2

- Readme updates to include services in

## 0.4.4+1

- Adds id's to all navigation functions to reference correct nav key

## 0.4.4

- Exposes functionality for nested navigator keys

## 0.4.3

- Exposes barrierColor on the dialog service

## 0.4.2

- Adds barrierDismissable optional boolean
- Adds instantInit option to allow to show snackbar in initState function call

## 0.4.1

- Adds custom data parameter to dialog service
- Adds default values for show custom dialog

## 0.4.0

- Adds custom UI option to the dialog builder

## 0.3.4

- Added arguments into the navigation service for clearStackAndshow and others

## 0.3.3

- DialogService now uses DialogTheme of the context instead of TextTheme

## 0.3.2+1

- Makes use of offAllNamed from get for clear backstack functionality

## 0.3.2

- Fixed naming changes to be consistent with the function name

## 0.3.1+2

- When clearing stacking and showing we push instead of replace

## 0.3.1+1

- Provided route as the predicate for the "till" functions

## 0.3.1

- Expose get key through all services in case they are used on their own without navigation service

## 0.3.0+1

- Injectable version update

## 0.3.0

- Dialog Service now shows platform specific dialogs
- Get version bumped
- Services is now Flutter web compatible

## 0.2.4

- Fixed a null exception caused by 2.5.0 of get

## 0.2.3

- Exposed the navigate with transition and replace with transition functionalities
- Added `NavigationTransition` class to give transitions type safety and avoid using Get's enum value
- Added a config function to set the default navigation behaviour

## 0.2.2+1

- Updated get package version

## 0.2.2

- Adds parameter for pop result to NavigationService

## 0.2.1+1

- Changelog style updates

## 0.2.1

- Moved private files into src folder as per package conventions

## 0.2.0+2

- Fixed a function name type in Navigation Service

## 0.2.0+1

- Updates webpage for package

## 0.2.0

- Expanded the Navigation Service functionality to expose more functionalities

## 0.1.0

- Initial commit with basic services
- Adds the `DialogService`, `NavigationService` and `SnackBarService`
