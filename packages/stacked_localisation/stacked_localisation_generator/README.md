# Stacked Localisation Generator

A code generator that generates all the keys in a language file to be used with the [stacked_localisation](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_localisation/stacked_localisation) package.

## Setup

This package should be added as a dev dependency in the project you're using.

```yaml
dev_dependencies:
  ...
  stacked_localisation_generator:
```

Then create a new folder in root called assets with another folder inside it called lang. This folder will contain the language json files. Here's an example of a file called en.json

```json
{
  "HomeView": {
    "title": "This is my Home",
    "subtitle": "I live in this Home"
  }
}
```

When you run `flutter pub run build_runner build --delete-conflicting-outputs` the package will generate a new file called `localisation_string_keys.dart` that can be found at the root of the lib folder that contains type save keys for the language string definition above. The json above will produce the following keys.

```dart
/// This code is generated. DO NOT edit by hand

class HomeViewStrings {
  static String title = 'HomeView.title';
  static String subtitle = 'HomeView.subtitle';
}
```

This can be accessed statically throughout the application where the keys are required. To see a full example of using stacked_localisaion you can check out the walkthrough [here](https://github.com/FilledStacks/stacked/tree/master/packages/stacked_localisation/stacked_localisation).
