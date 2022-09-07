/// Stores all the messages used throughout the app that communicates
/// with the user of the package.

/// Message shown when we encounter a failure during generation that's caused by an invalid
/// app structure.
const String kInvalidStackedStructureAppFile =
    'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/';

/// The message shows when we detect no pubspec.yaml file in the folder that the cli is
/// running from.
const String kInvalidRootDirectory = '''
    No pubspec.yaml detected. It seems that you are not running the cli from the root of a flutter project. 
    Please ensure that you are in the root of a flutter project when using stacked_tools.
    ''';

/// The message shown when we detect that the stacked structure does not follow the latest
/// recommendation of the file structure.
const String kInvalidStackedStructure = '''
No app.dart found in lib/app folder. We currently do not support scaffolding for stacked apps
that do not make use of the app.dart file for route generation and dependency inversion.

We have plans to support this in the future. If you want to help build it, check out the project
for the stacked-cli roadmap.
''';

const String kCommandHelpExcludeRoute =
    'When a route is excluded it will not be added to your app.dart routes collection.';

const String kCommandHelpLineLength =
    'When a number is provided, it will be used as the line length for formatting code.';

const String kCommandHelpExcludeDependency =
    'When a service is excluded it will not be added to your app.dart dependencies collection.';

const String kConfigFileNotFound =
    'We could not read your stacked.config.json file. ERROR: Configuration file is not available.';

const String kConfigFileMalformed =
    'Your stacked.config.json is malformed. Double check to make sure you have properly formatted json.';
