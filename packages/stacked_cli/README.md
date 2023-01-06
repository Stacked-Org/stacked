# Stacked CLI

The official CLI (Command Line Interface) dev tools for working with the Stacked framework. Stacked is a framework built in Flutter for production teams. It is built for maintenance, readability, and scaleability. To read about the usage of this tool read the [Stacked CLI docs](https://stacked.filledstacks.com/docs/Tooling/stacked-cli)

## Running the code

_Todo: write out the steps to run this project locally_

To test the updated executable code locally run 

```shell
# If you're inside the stacked_cli folder use . otherwise use path to stacked_cli directory
dart pub global activate --source path .
```

## Code Structure

_Todo: Write out a code base overview to explain how things are built_

## Templates

Templates are written as normal dart files using mustache templating. A file that can be templated should end in .stk . All the constants that can be replaced in templates ca be found in `lib/src/templates/template_constants.dart`. The values we have to substitute at the moment is:

- viewName: The name of the view class in dart. Given a name 'details' expects viewName to equal DetailsView

- viewFolderName: The name of the folder that the view will be created in. This is a snake_case version of the name.

- viewFileName: The name of the file that the view is created in with the dart extension. Given a name 'details' expects viewFileName to equal `details_view.dart`

- viewModelName: The name of the viewmodel class in dart. Given a name 'details' expects viewModelName to equal DetailsViewModel

- viewModelFileName: The name of the file that the viewmodel is created in with the dart extension. Given a name 'details' expects viewModelFileName to equal details_viewmodel.dart

- packageName: The name of the package that the cli tool is running in. This is read from the pubspec.yaml file in the root folder.

- serviceName: The name of the service class in Dart. Given a service name stripe expect `StripeService`

- serviceFilename: The name of the file the service class will be stored in. Given a name stripe expect `stripe_service.dart` to be returned.

_Todo: Change to a table and add all other template variables here_