# Stacked Services

Provides some essential services to aid in implementing the Stacked architecture. These services are only here to reduce boilerplate code for the users of the Stacked Architecture that uses the architecture as instructed by FilledStacks on the architecture series.

## Migration from 0.5.x -> 0.6.x

- The custom builder function has changed for the `DialogService` instead of using `registerCustomDialogBuilder` you should now create a map of builders and pass it to `registerCustomDialogBuilders`.
- If you're still using `registerCustomDialogBuilder` the builder function now takes a third argument of type `Function(DialogResponse)` that you can call completer.

Old way:

```dart
service.registerCustomDialogBuilder(variant: Dialog.basic, builder: (context, request) => Dialog(...))
```

New way:

```dart
service.registerCustomDialogBuilder(variant: Dialog.basic, builder: (context, request, completer) => Dialog(...))
```

Take note of the third parameter in the builder function that you can call to complete the builder instead of using the dialog service directly. You can simply call

```dart
completer(DialogResponse(...));
```

## Services

The following services are included in the package

- **NavigationService:** Makes use of the [Get](https://pub.dev/packages/get) package to expose basic navigation functionalities
- **DialogService**: Makes use of the [Get](https://pub.dev/packages/get) package to expose functionality that allows the dev to show dialogs from the ViewModels
- **SnackbarService**: Makes use of the [Get](https://pub.dev/packages/get) to expose the snack bar functionality to devs.
- **BottomSheetService**: Makes use of the [Get](https://pub.dev/packages/get) to expose the bottom sheet functionality.

The services can be registered with get_it normally as you would usually

```dart
final locator = GetIt.instance;

locator.registerLazySingleton(() => NavigationService());
```

If you're using Injectable as recommended you can register the services using a third party services module. Create a new file in your services folder called thirdparty_services_module.dart.

```dart
@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackBarService;
  @lazySingleton
  BottomSheetService get bottomSheetService;
}
```

If you now run

```
flutter pub run build_runner build
```

Your services will be available as usual on your locator instance.

## Usage

To use ANY OF the services you have to assign the navigation key to your Flutter application.

```dart
MaterialApp(
  title: 'Stacked Services',
  navigatorKey: StackedService.navigatorKey,
  // home: AddCardView(), // Used when testing a view
  initialRoute: Routes.startupViewRoute,
  onGenerateRoute: Router().onGenerateRoute,
);
```

If you're only using the `DialogService` it also exposes the navigation key. **You only have to set the key for one of the services and it'll work for all the other services.** If you set the nav key using the navigation service you don't have to set it for the DialogService and vice versa.

## Dialog Service

The `DialogService` will show a platform-specific dialog by default. You can change this by passing in `dialogPlatform` to your show dialog call.

```dart
await _dialogService.showDialog(
  title: 'Test Dialog Title',
  description: 'Test Dialog Description',
  dialogPlatform: DialogPlatform.Cupertino,
);
```

### Custom Dialog UI

In addition to platform-specific UI, you can also build a custom dialog. To do that we'll do the following. Start by creating an enum called `DialogType`.

```dart
/// The type of dialog to show
enum DialogType { basic, form }
```

In your UI folder or shared folder under UI, if you have one, create a new file called `setup_dialog_ui.dart`. Inside you will create a new function called `setupDialogUi`. In there you will create a Map of builders that will map to the `enum` values you created above. To keep code maintenance to the highest level you should make each of the widgets into its own widget and construct that instead of building the UI inline.

```dart
void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.form:  (context, sheetRequest, completer) =>
        _FormDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialog({Key key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: /* Build your dialog UI here */
    );
  }
}

class _FormDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormDialog({Key key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: /* Build your dialog UI here */
    );
  }
}

```

The `DialogRequest` has a few properties that can make you easily decide which widgets to place in the dialog to show. All these properties can be passed directly to the `showCustomDialog` function. Here are all the properties available for you to use.

```dart
/// The title for the dialog
final String title;

/// Text so show in the dialog body
final String description;

/// Indicates if an image should be used or not
final bool hasImage;

/// The URL / path to the image to show
final String imageUrl;

/// The text shown in the main button
final String mainButtonTitle;

/// A bool to indicate if you should show an icon in the main button
final bool showIconInMainButton;

/// The text to show on the secondary button on the dialog (cancel usually)
final String secondaryButtonTitle;

/// Indicates if you should show an icon in the main button
final bool showIconInSecondaryButton;

/// The text shown on the third button on the dialog
final String additionalButtonTitle;

/// Indicates if you should show an icon in the additional button
final bool showIconInAdditionalButton;

/// Indicates if the dialog takes input
final bool takesInput;

/// Intended to be used with enums. If you want to create multiple different
/// dialogs. Pass your enum in here and check the value in the builder
final dynamic variant;

/// Extra data to be passed to the UI
final dynamic customData;
```

### Setup and usage

After you have created your register function go to your main.dart file and after you've registered your services with the locator call `setupDialogUi`.

```dart
void main() {
  setupLocator();
  setupDialogUi();
  runApp(MyApp());
}
```

Now in your ViewModels, you can make use of the dialog as follows.

```dart
await _dialogService.showCustomDialog(
  variant: DialogType.base, // Which builder you'd like to call that was assigned in the builders function above.
  title: 'This is a custom UI with Text as main button',
  description: 'Sheck out the builder in the dialog_ui_register.dart file',
  mainButtonTitle: 'Ok',
);
```

### Returning Data from Custom Dialog

The builder function supplied for a Custom dialog builder has a parameter of type `Function(DialogResponse)` as the last parameter. Calling the completer function and passing in a `DialogResponse` object will return it to the caller that's awaiting on the dialog response UI. So when you have a tap handler in your dialog and you want to close the dialog, use the `completer(DialogResponse())` function.

```dart
var response = await _dialogService.showCustomDialog(
  variant: DialogType.form,
  title: 'My custom dialog',
  description: 'This is my dialog description',
  mainButtonTitle: 'Confirm',
);

if(response.confirmed) {
  // Do some confirmation action here.
}
```

## Navigation Service

The `NavigationService` will allow you to navigate your app easily from the `ViewModel`. No need for `BuildContext`.

- **NOTE: The table below expects you to have followed above steps, and intialized `NavigationService` like this: `final NavigationService _navigationService = locator<NavigationService>();`**
- The table below shows each function you can use with its return type and description:

| Function                    | Return Type       | Description                                                                                                       |
| --------------------------- | ----------------- | ----------------------------------------------------------------------------------------------------------------- |
| `config`                    | `void`            | Allows you to configure the default behaviour for navigation.                                                     |
| `navigateWithTransition`    | `Future<dynamic>` | Pushes `page` onto the navigation stack. This uses the `page` itself `Widget` instead of routeName `String`       |
| `replaceWithTransition`     | `Future<dynamic>` | Replaces current view in the navigation stack. This uses the `page` itself `Widget` instead of routeName `String` |
| `back`                      | `bool`            | Pops the current scope and indicates if you can pop again                                                         |
| `popUntil`                  | `void`            | Pops the back stack until the predicate is satisfied                                                              |
| `popRepeated`               | `void`            | Pops the back stack the number of times you indicate with `popTimes`                                              |
| `navigateTo`                | `Future<dynamic>` | Pushes `routeName` onto the navigation stack                                                                      |
| `navigateToView`            | `Future<dynamic>` | Pushes `view` onto the navigation stack                                                                           |
| `replaceWith`               | `Future<dynamic>` | Replaces the current route with the `routeName`                                                                   |
| `clearStackAndShow`         | `Future<dynamic>` | Clears the entire back stack and shows `routeName`                                                                |
| `clearTillFirstAndShow`     | `Future<dynamic>` | Pops the navigation stack until there's 1 view left then pushes `routeName` onto the stack                        |
| `clearTillFirstAndShowView` | `Future<dynamic>` | Pops the navigation stack until there's 1 view left then pushes `view` onto the stack                             |
| `pushNamedAndRemoveUntil`   | `Future<dynamic>` | Push route and clear stack until predicate is satisfied                                                           |
|  |

## Route observation

If you want the current route to be set during navigations then you have to add a route observer.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stacked Services Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [StackedService.routeObserver], ///<- Here
      navigatorKey: StackedService.navigatorKey,
      initialRoute: auto_router.Routes.homeScreenRoute,
      onGenerateRoute: auto_router.Router().onGenerateRoute,
    );
  }
}
```

## Snackbar Service

The `SnackbarService` allows you to show a snack bar from the `ViewModel`. Logic and state is handled in the `ViewModel` this is where you know something went wrong, a results is unexpected or when a user has completed an action. Instead of routing the action back to the UI to show a snackbar using the context we can show it directly from the ViewModel using the `SnackbarService`.

### Basic Usage

To use the service is quite easy. Here is an example of how you'd show a snackbar.

```dart
_snackbarService.showSnackbar(
  message: 'This is a snack bar',
  title: 'The title',
  duration: Duration(seconds: 2),
  onTap: (_) {
    print('snackbar tapped');
  },
  mainButtonTitle: 'Undo',
  onMainButtonTapped: () => print('Undo the action!'),
);
```

This will show a default Snackbar styled with the background set as Dark grey and the text as white. There will be a main button on the right that will fire the function and print 'Undo the action!' when it's tapped.

### Styling the Snackbar

To supply a style for the `showSnackbar` function you have to supply a `SnackbarConfig`. Create a new file in your ui folder called `setup_snackbar_ui.dart`. Inside create a function that will register your snackbarConfig. We will register a config that makes the background red, text white and the main button title black.

```dart
void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: Colors.red,
    textColor: Colors.white,
    mainButtonTextColor: Colors.black,
  ));
}
```

Then in the main.dart file before running the app, after setting up the locator we call `setupSnackbarUi`.

```dart
void main() {
  setupLocator();
  setupSnackbarUi();
  runApp(MyApp());
}
```

If you now execute the same showSnackbar function as above you'll see the background is red, text white and the action button has black text.

### Custom Styles

Sometimes you might want more than 1 snackbar style. In this case you can register multiple SnackbarConfigs to be shown using the `showCustomSnackBar` function. To register a custom config we need to define unique values to register it again that's easy to reference when we want to show the snackbar using that config. I like to use enums. We'll start by creating an enum called `SnackbarType`.

```dart
/// The type of snackbar to show
enum SnackbarType { blueAndYellow, greenAndRed }
```

Then open up the `setup_snackbar_ui.dart` created above and we'll add the configs for the two enums.

```dart
void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.blueAndYellow,
    config: SnackbarConfig(
      backgroundColor: Colors.blueAccent,
      textColor: Colors.yellow,
      borderRadius: 1,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.greenAndRed,
    config: SnackbarConfig(
      backgroundColor: Colors.white,
      titleColor: Colors.green,
      messageColor: Colors.red,
      borderRadius: 1,
    ),
  );
}
```

Now you can call `showCustomSnackBar` and pass in the `variant` enum that you'd like to use. The following code will show the blueAndYellow snackbar.

```dart
_snackbarService.showCustomSnackBar(
  variant: SnackbarType.blueAndYellow,
  message: 'Blue and yellow',
  title: 'The message is the message',
  duration: Duration(seconds: 2),
  onTap: (_) {
    print('snackbar tapped');
  },
  mainButtonTitle: 'Undo',
  onMainButtonTapped: () => print('Undo the action!'),
);
```

And the following code will show the greenAndRed snackbar

```dart
_snackbarService.showCustomSnackBar(
  variant: SnackbarType.greenAndRed,
  title: 'Green and Red',
  message: 'The text is green and red and the background is white',
  duration: Duration(seconds: 2),
  onTap: (_) {
    print('snackbar tapped');
  },
  mainButtonTitle: 'Undo',
  onMainButtonTapped: () => print('Undo the action!'),
);
```

The snackbar service does not cover every scenario at the moment, especially for adding multiple actions or using icons. If you're looking for those kind of features please make an issue or make a PR for the functionality. I would greatly appreciate it.

## BottomSheet Service

This service, similar to the others above, allows the user to show a `BottomSheet` from the same place they handle their business logic. It's calls that can be awaited on for a result returned by the user. This makes writing your business logic much easier in the long run.

## Usage

The `BottomSheetService` has a basic mode for quick and dirty bottom sheet functionality, and also has a custom UI building function. To show a basic bottom sheet you simply get the `BottomSheetService` from the locator and then call `showBottomSheet`.

```dart
final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

var sheetResponse = await _bottomSheetService.showBottomSheet(
  title: 'This is my Sheets Title',
  description:
      'This property will display under the title. We\'re not going to provide a lot of UI versions for the sheet because everyone will have a different style.\nInstead you can use the custom sheet builders as shown below.',
);
```

As you can see above you can get a response from the `showBottomSheet` call. There are also two additional titles you can pass into the function.

```dart
 var confirmationResponse =
      await _bottomSheetService.showBottomSheet(
    title: 'Confirm this action with one of the options below',
    description:
        'The result from this call will return a SheetResponse object with confirmed set to true. See the logs where we print out the confirmed value for you.',
    confirmButtonTitle: 'I confirm',
    cancelButtonTitle: 'I DONT confirm',
  );

  print( 'confirmationResponse confirmed: ${confirmationResponse?.confirmed}');
```

The `confirmButtonTitle` when tapped will return a response where `confirmed` is set to true and the cancel title will return a response where `confired` is set to false.

### Custom UI Setup

Custom UI works the same as the `DialogService`. You can create a new file in your ui folder called `setup_bottom_sheet_ui.dart`. Inside this file you'll get the `BottomSheetService` from the locator (make sure it's registered, check beginning of readme). Then you'll construct a map of builders which take a mapping of an enum to a builder function. The builder function expects a `BuildContext`, `SheetRequest` and `Function<SheetResponse>` which we always call a completer.

```dart
void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.FloatingBox: (context, sheetRequest, completer) =>
        _FloatingBoxBottomSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class _FloatingBoxBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  const _FloatingBoxBottomSheet({
    Key key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
          ...
      ),
    );
  }
}
```

Once you've created the builders you set it on the service through `setCustomSheetBuilder`. Now in your code you can show this specific dialog that you registered.

```dart
 var confirmationResponse =
    await _bottomSheetService.showCustomSheet(
  variant: BottomSheetType.FloatingBox,
  title: 'This is a floating bottom sheet',
  description:
      'This sheet is a custom built bottom sheet UI that allows you to show it from any service or viewmodel.',
  mainButtonTitle: 'Awesome!',
  secondaryButtonTitle: 'This is cool',
);

```

### Returning data from the BottomSheet

When you want to complete the dialog and return some data all your do is call the completer function and pass the `SheetResponse` that you'd like the awaiting function to receive.

```dart
onTap: () => completer(SheetResponse(...))
```
