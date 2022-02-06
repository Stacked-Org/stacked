/// The name of the view class in dart.
/// Given a name 'details' expects viewName to equal DetailsView
const String kTemplatePropertyViewName = 'viewName';

// ------- File Modification identifiers --------

const String kModificationIdentifierAppRoutes = '// @stacked-routes';
const String kModificationIdentifierAppImports = '// @stacked-imports';

// ------- Property names for Rendering replacement -------

/// The name of the viewmodel class in dart.
/// Given a name 'details' expects viewModelName to equal DetailsViewModel
const String kTemplatePropertyViewModelName = 'viewModelName';

/// The name of the file that the viewmodel is created in with the dart extension.
/// Given a name 'details' expects viewModelFileName to equal details_viewmodel.dart
const String kTemplatePropertyViewModelFileName = 'viewModelFileName';

/// The name of the folder that the view will be created in. This is the exact name that's
/// passed to us in the command line for the view.
const String kTemplateViewFolderName = 'viewFolderName';

/// The name of the file that the view is create in with the dart extension.
/// Given a name 'details' expects viewFileName to equal `details_view.dart`
const String kTemplateViewFileName = 'viewFileName';

/// The name of the package that the cli tool is running in. This is read from the
/// pubspec.yaml file in the root folder.
const String kTemplatePropertyPackageName = 'packageName';

// -------- Compiled Template Structure ---------

const String kTemplateDataStructure = '''
/// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
///       This file should be checked into source control.

{{#templateItems}}

// -------- {{templateFileName}} Template Data ----------

const String k{{templateName}}Template{{templateFileName}}Path =
    '{{templateFilePath}}';

const String k{{templateName}}Template{{templateFileName}}Content = \'''
{{{templateFileContent}}}
\''';

// --------------------------------------------------

{{/templateItems}}
''';
