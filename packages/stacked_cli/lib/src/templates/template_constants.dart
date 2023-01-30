// ------- Template names --------
const String kTemplateNameView = 'view';
const String kTemplateNameService = 'service';
const String kTemplateNameApp = 'app';
const String kTemplateNameBottomSheet = 'bottom_sheet';
const String kTemplateNameDialog = 'dialog';

// ------- File Modification identifiers --------

const String kModificationIdentifierAppImports = '// @stacked-import';
const String kModificationIdentifierAppRoutes = '// @stacked-route';
const String kModificationIdentifierAppServices = '// @stacked-service';
const String kModificationIdentifierServiceMock = '// @stacked-service-mock';
const String kModificationIdentifierServiceMockHelper =
    '// @stacked-mock-create';
const String kModificationIdentifierServiceMockHelperRegister =
    '// @stacked-mock-register';

// ------- Property names for Rendering replacement -------

/// The name of the view class in dart.
/// Given a name 'details' expects viewName to equal DetailsView
const String kTemplatePropertyViewName = 'viewName';

/// The name of the viewmodel class in dart.
/// Given a name 'details' expects viewModelName to equal DetailsViewModel
const String kTemplatePropertyViewModelName = 'viewModelName';

/// The name of the file that the viewmodel is created in with the dart extension.
/// Given a name 'details' expects viewModelFileName to equal details_viewmodel.dart
const String kTemplatePropertyViewModelFileName = 'viewModelFileName';

/// The name of the folder that the view will be created in. This is a snake_case version
/// of the name.
const String kTemplatePropertyViewFolderName = 'viewFolderName';

/// The name of the file that the view is creatde in with the dart extension.
/// Given a name 'details' expects viewFileName to equal `details_view.dart`
const String kTemplatePropertyViewFileName = 'viewFileName';

/// The name of the package that the cli tool is running in. This is read from the
/// pubspec.yaml file in the root folder.
const String kTemplatePropertyPackageName = 'packageName';

/// The name of the service class in pascal case
const String kTemplatePropertyServiceName = 'serviceName';

const String kTemplatePropertyServiceFilename = 'serviceFilename';

const String kTemplatePropertyLocatorName = 'locatorName';

const String kTemplatePropertyRelativeLocatorPath = 'relativeLocatorPath';

const String kTemplatePropertyRelativeRouterPath = 'relativeRouterFilePath';

const String kTemplatePropertyRegisterMocksFunction = 'registerMocksFunction';

const String kTemplatePropertyServiceImportPath = 'serviceImportPath';

const String kTemplatePropertyServiceTestHelpersImport =
    'serviceTestHelpersImport';

const String kTemplatePropertyViewImportPath = 'viewImportPath';

const String kTemplatePropertyViewTestHelpersImport = 'viewTestHelpersImport';

const String kTemplatePropertySheetName = 'sheetName';

const String kTemplatePropertySheetFilename = 'sheetFilename';

const String kTemplatePropertySheetModelName = 'sheetModelName';

const String kTemplatePropertySheetModelFilename = 'sheetModelFilename';

const String kTemplatePropertySheetFolderName = 'sheetFolderName';

const String kTemplatePropertySheetType = 'sheetType';

const String kTemplatePropertySheetsPath = 'bottomSheetsPath';

const String kTemplatePropertySheetTypeFilePath = 'bottomSheetTypeFilePath';

const String kTemplatePropertySheetBuilderFilePath =
    'bottomSheetBuilderFilePath';

const String kTemplatePropertyDialogName = 'dialogName';

const String kTemplatePropertyDialogFilename = 'dialogFilename';

const String kTemplatePropertyDialogModelName = 'dialogModelName';

const String kTemplatePropertyDialogModelFilename = 'dialogModelFilename';

const String kTemplatePropertyDialogFolderName = 'dialogFolderName';

const String kTemplatePropertyDialogType = 'dialogType';

const String kTemplatePropertyDialogsPath = 'dialogsPath';

const String kTemplatePropertyDialogTypeFilePath = 'dialogTypeFilePath';

const String kTemplatePropertyDialogBuilderFilePath = 'dialogBuilderFilePath';

// -------- Compiled Template Structure ---------

const String kTemplateDataStructure = '''
/// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
///       This file should be checked into source control.

{{#templateItems}}

// -------- {{fileName}} Template Data ----------

const String k{{name}}Template{{fileName}}Path =
    '{{{path}}}';

const String k{{name}}Template{{fileName}}Content = \'''
{{{content}}}
\''';

// --------------------------------------------------

{{/templateItems}}
''';

// TODO: add an option to create Cupertino or custom routes
const String kTemplateMapDataStructure = '''
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

Map<String, StackedTemplate> kCompiledStackedTemplates = {
  {{#stackedTemplates}}
  '{{name}}': StackedTemplate(
    templateFiles: [
    {{#templateFiles}}
      TemplateFile(
        relativeOutputPath: k{{name}}Template{{fileName}}Path,
        content: k{{name}}Template{{fileName}}Content,
      ),
    {{/templateFiles}}
    ],
    modificationFiles: [
      {{#modificationFiles}}
      ModificationFile(
        relativeModificationPath: '{{{path}}}',
        modificationIdentifier: '{{{identifier}}}',
        modificationTemplate: \'''{{{template}}}\''',
        modificationProblemError: '{{{error}}}',
        modificationName: '{{{name}}}',
      ),
      {{/modificationFiles}}
    ],
  ),
  
  {{/stackedTemplates}}
};
''';
