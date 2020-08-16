# Stacked Localisation

A localisation solution specifically built for using with the [stacked package](https://pub.dev/packages/stacked) for state management. This comes in the form of a localisation service accessible to the ViewModels and other services which takes in a localisation key and returns the string (if any), as provided by the files that define the strings for each language. As all the other solutions provided by [FilledStacks](https://www.youtube.com/filledstacks) this solution aims to reduce the amount of code required for basic language setup, make it easier to understand and make the code more readable in the process. All of this is in hopes of creating a more maintainable code base to work with.

## How does it work

The localisation package is very simple. It provides you with a service from which you can request a translated string using a key. The keys map directly to your language files that should be placed in `assets/lang` as json files. The `stacked_localisation_generator` will then generate code for the keys defined in your language file. This will allow you to safely request keys without manually maintaining any of the keys.

## Setup

To use the localisation service there's a few things that has to be done. We start off by adding the stacked_localisation and the stacked_localisation_generator package.

```yaml
dependencies:
  ...
  stacked_localisation:

dev_dependencies:
  ...
  stacked_localisation_generator:
```

Then we will add a new asset entry into pubspec.yaml that points to the `assets/lang` folder (You will create this folder if it doesn't exist).

```yaml
assets:
  - assets/lang/
```

Then we you will create the folders mentioned above and place your strings for a different language in there. Create a folder called assets in the root folder and inside that folder create a new folder called lang. Then create a new file inside it called en.json and place the following json in there.

```json
{
  "HomeView": {
    "title": "This is my Home",
    "subtitle": "I live in this Home"
  }
}
```

Then run `flutter pub run build_runner build --delete-conflicting-outputs` to generate the localisation_string_keys.dart file. This file will look like this.

```dart
/// This code is generated. DO NOT edit by hand

class HomeViewStrings {
  static String title = 'HomeView.title';
  static String subtitle = 'HomeView.subtitle';
}
```

It takes the name of the parent view and adds the word "Strings" behind it. This turns "HomeView" into "HomeViewStrings" and creates a property for each string value in that map.

### Setup in code

The localisation service requires a setup function to called and also an initialisation function to load all the strings into memory before starting the app. Lets start with the setup function. Open up your main.dart file and on the first line of the body call the static `setupLocator` function on the `LocalisationService`. We will also change the main function to a Future and change our setupLocator function to a future as well and await on the setup call.

```dart
Future main() async {
  // sets up the internal locator for the localisation service
  LocalisationService.setupLocator();
  await setupLocator();
  runApp(MyApp());
}
```

Then you can open up your setup_locator.dart file and create an instance of the `LocationServices` then await the initialise call before registering it as a singleton.

```dart
import 'package:get_it/get_it.dart';
import 'package:stacked_localisation/stacked_localisation.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  var localisationService = LocalisationService();
  await localisationService.initialise();
  locator.registerSingleton(localisationService);

  locator.registerLazySingleton(() => NavigationService());
  ...
}
```

### Usage in Code

The initialisation functionality will load the strings into the `LocalisationService` which is now accessible. Create a new view file, or in your current view file make the following adjustments.

```dart
class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(model.translate(HomeViewStrings.title)),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(model.translate(
              HomeViewStrings.subtitle,
            ))
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
```

You'll see the usage of the translate function on the model. Lets add that functionality. Open up your `ViewModel` file and add the `LocalisedClass` mixin to your `ViewModel` definition.

```dart
class HomeViewModel extends BaseViewModel with LocalisedClass {}
```

This provides you with a translate function that will return the value associated with the key. That's it for the basic usage.

## Outside of the code

The language files added into the lang folder can be specific en_US.json or en_UK.json or it can be general en.json which will ensure all localisations starting with en will be given the strings defined in the en.json file. Another thing with the language files is to make sure all the files has the same strings. The localisation keys will be generated using the file that's first in the lang folder. If it's missing strings you won't be able to access them through the string key classes.

## More Code

The `LocalisedClass` mixin can be used in services as well, the exact same way. Which will allow you to throw localised exceptions or show localised dialogs easily as well.

```dart
throw Exception(translate(ApiStrings.serialisationError));

// or

_dialogSerice.showDialog(title: translate(HomeView.favoriteAddedTitle));
```

If you have any requests, questions or pointers you can file an issue or [head over to our slack](https://join.slack.com/t/filledstacks/shared_invite/zt-8hae7yly-vjZX3sW5twN9v7DBlTsgrQ) and chat to use directly about improvements or just code in general.

## Upcoming Features

- [ ] Reload the language strings without having the restart the application. This will require adding something like the [LifeCycle manager shown here](https://youtu.be/NfvA-7-HzYk) to call the initialise function again which will load up the new strings and place them into memory.
