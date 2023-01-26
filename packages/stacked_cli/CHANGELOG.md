## 1.1.9+1

- Refactor ProcessService
- Improves version global option to be retrieved on the fly

## 1.1.9

- Fixes version global option

## 1.1.8

- Adds global option to show `stacked_cli` version
- Adds global option to enable sending of analytics data
- Adds global option to disable sending of analytics data
- Adds prompt for sending analytics at first run
- Fixes unit tests
- Fix: Delete service command removes correct dependencies and code

## 1.1.7

- Logs exception events to Google Analytics

## 1.1.6

- Adds create dialog command
- Improves shouldAppendTemplate function
- Executes `clean` function on create app command to
  - Deletes widget_test.dart file
  - Removes unused imports

## 1.1.5

- Fixes support for relative router file path

## 1.1.4

- Adds create bottom_sheet command
- Improves templates
- Improves analytics responsiveness, no more delays on commands execution
- Updates example app

## 1.1.3+1

- Replaces `stacked_tools` strings with `stacked_cli`

## 1.1.3

- Updates the `HomeViewModel` template to use `rebuildUi` instead of `notifyListeners`
- Updates `StartupViewModel` to use type safe navigation when going to the `HomeView`

## 1.1.2

- Adds the new Update command

## 1.1.1+1

- Updates cli link in readme
- Sets `runInShell` true in an attempt to fix [this issue](https://github.com/FilledStacks/stacked/issues/811?notification_referrer_id=NT_kwDOADbP6rI1MjQxODI0ODQ5OjM1OTIxNzA)

## 1.1.1

- Adds google analytics to see where to improve the app

## 1.1.0

We had to update this package version to 1.1.0 because this package use to belong to a different developer. They released starting at 1.0.0. This is why we're suddenly jumping from 0.2.6 to 1.1.0.

## 0.2.6

- Adds the new Generate command

## 0.2.5

- Adds Stacked route observer to app template

## 0.2.4

- Promotes the package to stable

## 0.2.4-beta.4

- Removes lib and test folder from the default paths because there is no need to include them as they can't be changed
- Changes getImportPath to sanitizePath, more appropriate method name
- Removes path of app name, if any, to render template
- Changes Stacked config filename to `stacked.json`
- Changes ConfigService to support XDG_CONFIG_HOME
- Moves again loadConfig to each command instead of bootstrap

## 0.2.4-beta.3

- Updates the compiled templates since the template was changes
- Updates viewModelBuilder on templates to use short hand function notation
- Updates ViewModel instance name from model to viewModel
- Updates StackedView template builder indentation

## 0.2.4-beta.2

- Removes the depdency override for stacked

## 0.2.4-beta.1

- Add lineLength to Config model
- Update stacked config on templates
- Use ConfigService for _formattingLineLength default value
- Add line-length option support to create app command
- Load configuration on bootstrap instead of each command
- Fix replaceCustomPaths, now only process values which keys contains `path` word
- Update example app

## 0.2.4-beta.0

- Changes View template to use StackedView, aka ViewModelWidget, as default
- Adds config option `v1` to use alternative view builder style
- Adds flag option `v1` to use alternative view builder style, overrides config option
- Adds `v1`support for create app command
- Removes `widget_test` after on create app command
- Uses relativeLocatorPath on every template
- Fixes TestHelpers import on views and services tests
- Improves getFilePathToHelpersAndMocks
- Updates example app to align changes

## 0.2.3-beta.0

- Fixes testHelpersPath default value
- Adds test_helpers filename to service_test template
- Changes default values on stacked config template
- Loads config on create app command

## 0.2.2

- Fixes the generated stacked config file

## 0.2.1

### Additions
- Adds config option to set the name of the locator used to register mocks for testing
- Adds config option to set the name of the function that registers all mocks for testing

### Fixes
- Makes test_helpers_path replace the entire value with the new value provided
- Fixes hard check for test location

## 0.2.0

### Feature: Stacked config
- Adds stacked config so you can use different paths for your file generation making it usable with all projects

### Bugs
- Fixes: Duplicate import in test_helper.dart file

## 0.2.0

- Adds stacked config so you can use different paths for your generating

## 0.1.6
- Updates Formatting to be only on specific files 
- Adds line-length or -l option for formatting length default is 80
- Adds delete service command 

## 0.1.5
- Updates dependencies 
  
## 0.1.4

- Adds colorized outputs on command line
- Runs build runner and pub get on view and service creation
- Adds delete command for views
  - you can now run `stacked delete view view_name ` to delete view_name view,viewmodel and tests also remove view from `app.dart`  
- Fixes wrong pubspec.yaml file selection on non-root commands

## 0.1.2+1

- Adds documentation link to basic docs

## 0.1.2

- Fixes bug that loads pubspec on project create

## 0.1.1

- Adds executable to the pubspec for global activation
- Fixes template bugs for app generate

## 0.1.0

### Initial Release

This version of the cli has 3 create commands:
- stacked create app: This creates a brand new flutter project with all the stacked functionality setup
- stacked create view: This creates a new view in the project and makes all required changes
- stacked create service: This creates a new service in the project and makes all required changes
