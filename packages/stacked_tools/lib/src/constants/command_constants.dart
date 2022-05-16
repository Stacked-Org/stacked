/// Stores all the commands used throughout the app that

const String ksFlutter = 'flutter';
const String ksCreate = 'create';
const String ksRun = 'run';
const String ksPub = 'pub';
const String ksGet = 'get';
const String ksFormat = 'format';
const String ksBuild = 'build';
const String ksBuildRunner = 'build_runner';
const String ksDeleteConflictingOutputs = '--delete-conflicting-outputs';
const String ksExcludeRoute = 'exclude-route';
const String ksExcludeDependency = 'exclude-dependency';
const String ksCurrentDirectory = '.';

/// A list of strings that are used to run the pub run build runner build --delete-conflicting-outputs command.
const List<String> buildRunnerArguments = [
  ksPub,
  ksRun,
  ksBuildRunner,
  ksBuild,
  ksDeleteConflictingOutputs,
];

/// A list of strings that are used to run the pub get command.
const List<String> pubGetArguments = [ksPub, ksGet];
