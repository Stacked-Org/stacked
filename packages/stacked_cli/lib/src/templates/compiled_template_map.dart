// ignore_for_file: unnecessary_string_escapes

import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';

Map<String, Map<String, StackedTemplate>> kCompiledStackedTemplates = {
  'app': {
      'web' : StackedTemplate(
        templateFiles: [
          TemplateFile(
            relativeOutputPath: kAppWebTemplateStackedJsonStkPath,
            content: kAppWebTemplateStackedJsonStkContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateHomeViewmodelTestPath,
            content: kAppWebTemplateHomeViewmodelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateNoticeSheetModelTestPath,
            content: kAppWebTemplateNoticeSheetModelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateInfoAlertDialogModelTestPath,
            content: kAppWebTemplateInfoAlertDialogModelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateTestHelpersPath,
            content: kAppWebTemplateTestHelpersContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateBuildYamlStkPath,
            content: kAppWebTemplateBuildYamlStkContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateMainIconPngStkPath,
            content: kAppWebTemplateMainIconPngStkContent,
            fileType: FileType.image
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateIndexHtmlStkPath,
            content: kAppWebTemplateIndexHtmlStkContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateFaviconPngStkPath,
            content: kAppWebTemplateFaviconPngStkContent,
            fileType: FileType.image
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateREADMEMdStkPath,
            content: kAppWebTemplateREADMEMdStkContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateMainPath,
            content: kAppWebTemplateMainContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateAppConstantsPath,
            content: kAppWebTemplateAppConstantsContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateUiHelpersPath,
            content: kAppWebTemplateUiHelpersContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateAppStringsPath,
            content: kAppWebTemplateAppStringsContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateAppColorsPath,
            content: kAppWebTemplateAppColorsContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateNoticeSheetModelPath,
            content: kAppWebTemplateNoticeSheetModelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateNoticeSheetPath,
            content: kAppWebTemplateNoticeSheetContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateInfoAlertDialogModelPath,
            content: kAppWebTemplateInfoAlertDialogModelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateInfoAlertDialogPath,
            content: kAppWebTemplateInfoAlertDialogContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateStartupViewmodelPath,
            content: kAppWebTemplateStartupViewmodelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateStartupViewPath,
            content: kAppWebTemplateStartupViewContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateScaleOnHoverPath,
            content: kAppWebTemplateScaleOnHoverContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateTranslateOnHoverPath,
            content: kAppWebTemplateTranslateOnHoverContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateAppPath,
            content: kAppWebTemplateAppContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateHoverExtensionsPath,
            content: kAppWebTemplateHoverExtensionsContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplatePubspecYamlStkPath,
            content: kAppWebTemplatePubspecYamlStkContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppWebTemplateSettingsJsonStkPath,
            content: kAppWebTemplateSettingsJsonStkContent,
            fileType: FileType.text
          ),
        ],
        modificationFiles: [
        ],
      ),
      'mobile' : StackedTemplate(
        templateFiles: [
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateStackedJsonStkPath,
            content: kAppMobileTemplateStackedJsonStkContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateHomeViewmodelTestPath,
            content: kAppMobileTemplateHomeViewmodelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateNoticeSheetModelTestPath,
            content: kAppMobileTemplateNoticeSheetModelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateInfoAlertDialogModelTestPath,
            content: kAppMobileTemplateInfoAlertDialogModelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateTestHelpersPath,
            content: kAppMobileTemplateTestHelpersContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateREADMEMdStkPath,
            content: kAppMobileTemplateREADMEMdStkContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateMainPath,
            content: kAppMobileTemplateMainContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateUiHelpersPath,
            content: kAppMobileTemplateUiHelpersContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateAppStringsPath,
            content: kAppMobileTemplateAppStringsContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateAppColorsPath,
            content: kAppMobileTemplateAppColorsContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateNoticeSheetModelPath,
            content: kAppMobileTemplateNoticeSheetModelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateNoticeSheetPath,
            content: kAppMobileTemplateNoticeSheetContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateInfoAlertDialogModelPath,
            content: kAppMobileTemplateInfoAlertDialogModelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateInfoAlertDialogPath,
            content: kAppMobileTemplateInfoAlertDialogContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateHomeViewV1Path,
            content: kAppMobileTemplateHomeViewV1Content,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateHomeViewPath,
            content: kAppMobileTemplateHomeViewContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateHomeViewmodelPath,
            content: kAppMobileTemplateHomeViewmodelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateStartupViewmodelPath,
            content: kAppMobileTemplateStartupViewmodelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateStartupViewV1Path,
            content: kAppMobileTemplateStartupViewV1Content,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateStartupViewPath,
            content: kAppMobileTemplateStartupViewContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplateAppPath,
            content: kAppMobileTemplateAppContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kAppMobileTemplatePubspecYamlStkPath,
            content: kAppMobileTemplatePubspecYamlStkContent,
            fileType: FileType.text
          ),
        ],
        modificationFiles: [
        ],
      ),
  },
  
  'dialog': {
      'empty' : StackedTemplate(
        templateFiles: [
          TemplateFile(
            relativeOutputPath: kDialogEmptyTemplateGenericDialogModelTestPath,
            content: kDialogEmptyTemplateGenericDialogModelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kDialogEmptyTemplateGenericDialogModelPath,
            content: kDialogEmptyTemplateGenericDialogModelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kDialogEmptyTemplateGenericDialogUseModelPath,
            content: kDialogEmptyTemplateGenericDialogUseModelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kDialogEmptyTemplateGenericDialogPath,
            content: kDialogEmptyTemplateGenericDialogContent,
            fileType: FileType.text
          ),
        ],
        modificationFiles: [
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-dialog',
            modificationTemplate: '''StackedDialog(classType: {{dialogName}}),''',
            modificationProblemError: 'The dialog registration should be stored in lib/app/app.dart',
            modificationName: 'Add \'{{dialogName}}\' dependency to StackedApp annotations file',
          ),
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-import',
            modificationTemplate: '''import \'package:{{packageName}}/{{{dialogsPath}}}/{{dialogFolderName}}/{{dialogFilename}}\';''',
            modificationProblemError: 'The dialog registration should be stored in lib/app/app.dart',
            modificationName: 'Add import for \'{{dialogName}}\' class',
          ),
        ],
      ),
  },
  
  'view': {
      'empty' : StackedTemplate(
        templateFiles: [
          TemplateFile(
            relativeOutputPath: kViewEmptyTemplateGenericViewmodelTestPath,
            content: kViewEmptyTemplateGenericViewmodelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewEmptyTemplateGenericViewmodelPath,
            content: kViewEmptyTemplateGenericViewmodelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewEmptyTemplateGenericViewPath,
            content: kViewEmptyTemplateGenericViewContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewEmptyTemplateGenericViewV1Path,
            content: kViewEmptyTemplateGenericViewV1Content,
            fileType: FileType.text
          ),
        ],
        modificationFiles: [
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-route',
            modificationTemplate: '''MaterialRoute(page: {{viewName}}),''',
            modificationProblemError: 'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/',
            modificationName: 'Add {{viewName}} route where @StackedApp annotation is located',
          ),
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-import',
            modificationTemplate: '''import \'package:{{packageName}}/{{{viewImportPath}}}/{{viewFolderName}}/{{viewFileName}}\';''',
            modificationProblemError: 'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/',
            modificationName: 'Add {{viewName}} route import where @StackedApp annotation is located',
          ),
        ],
      ),
      'web' : StackedTemplate(
        templateFiles: [
          TemplateFile(
            relativeOutputPath: kViewWebTemplateGenericViewmodelTestPath,
            content: kViewWebTemplateGenericViewmodelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewWebTemplateGenericViewmodelPath,
            content: kViewWebTemplateGenericViewmodelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewWebTemplateHomeViewDesktopPath,
            content: kViewWebTemplateHomeViewDesktopContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewWebTemplateHomeViewMobilePath,
            content: kViewWebTemplateHomeViewMobileContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewWebTemplateGenericViewPath,
            content: kViewWebTemplateGenericViewContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewWebTemplateHomeViewPath,
            content: kViewWebTemplateHomeViewContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewWebTemplateHomeViewmodelPath,
            content: kViewWebTemplateHomeViewmodelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kViewWebTemplateHomeViewTabletPath,
            content: kViewWebTemplateHomeViewTabletContent,
            fileType: FileType.text
          ),
        ],
        modificationFiles: [
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-route',
            modificationTemplate: '''MaterialRoute(page: {{viewName}}),''',
            modificationProblemError: 'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/',
            modificationName: 'Add {{viewName}} route where @StackedApp annotation is located',
          ),
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-import',
            modificationTemplate: '''import \'package:{{packageName}}/{{{viewImportPath}}}/{{viewFolderName}}/{{viewFileName}}\';''',
            modificationProblemError: 'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/',
            modificationName: 'Add {{viewName}} route import where @StackedApp annotation is located',
          ),
        ],
      ),
  },
  
  'service': {
      'empty' : StackedTemplate(
        templateFiles: [
          TemplateFile(
            relativeOutputPath: kServiceEmptyTemplateGenericServiceTestPath,
            content: kServiceEmptyTemplateGenericServiceTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kServiceEmptyTemplateGenericServicePath,
            content: kServiceEmptyTemplateGenericServiceContent,
            fileType: FileType.text
          ),
        ],
        modificationFiles: [
          ModificationFile(
            relativeModificationPath: 'test/helpers/test_helpers.dart',
            modificationIdentifier: '// @stacked-mock-create',
            modificationTemplate: '''Mock{{serviceName}} getAndRegister{{serviceName}}() { 
_removeRegistrationIfExists<{{serviceName}}>(); 
final service = Mock{{serviceName}}(); 
{{locatorName}}.registerSingleton<{{serviceName}}>(service); 
return service; 
}''',
            modificationProblemError: 'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
            modificationName: 'Add {{serviceName}} mock to test helpers',
          ),
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-service',
            modificationTemplate: '''LazySingleton(classType: {{serviceName}}),''',
            modificationProblemError: 'The service registration should be stored in lib/app/app.dart',
            modificationName: 'Add {{serviceName}} dependency to StackedApp annotations file',
          ),
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-import',
            modificationTemplate: '''import \'package:{{packageName}}/{{{serviceImportPath}}}/{{serviceFilename}}\';''',
            modificationProblemError: 'The service registration should be stored in lib/app/app.dart',
            modificationName: 'Add {{serviceName}} import to StackedApp annotations file',
          ),
          ModificationFile(
            relativeModificationPath: 'test/helpers/test_helpers.dart',
            modificationIdentifier: '// @stacked-mock-spec',
            modificationTemplate: '''MockSpec<{{serviceName}}>(onMissingStub: OnMissingStub.returnDefault),''',
            modificationProblemError: 'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
            modificationName: 'Create {{serviceName}} mock to test helpers',
          ),
          ModificationFile(
            relativeModificationPath: 'test/helpers/test_helpers.dart',
            modificationIdentifier: '// @stacked-mock-register',
            modificationTemplate: '''getAndRegister{{serviceName}}();''',
            modificationProblemError: 'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
            modificationName: 'Add {{serviceName}} register to test helpers',
          ),
          ModificationFile(
            relativeModificationPath: 'test/helpers/test_helpers.dart',
            modificationIdentifier: '// @stacked-import',
            modificationTemplate: '''import \'package:{{packageName}}/{{{serviceImportPath}}}/{{serviceFilename}}\';''',
            modificationProblemError: 'It seems your test_helpers.dart file is not in test/helpers/test_helpers.dart. Add a stacked.json file and set the path for \'test_helpers_path\' to the folder we can locate your test_helpers.dart file',
            modificationName: 'Add {{serviceName}} import to test helpers',
          ),
        ],
      ),
  },
  
  'bottom_sheet': {
      'empty' : StackedTemplate(
        templateFiles: [
          TemplateFile(
            relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetModelTestPath,
            content: kBottomSheetEmptyTemplateGenericSheetModelTestContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetModelPath,
            content: kBottomSheetEmptyTemplateGenericSheetModelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetUseModelPath,
            content: kBottomSheetEmptyTemplateGenericSheetUseModelContent,
            fileType: FileType.text
          ),
          TemplateFile(
            relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetPath,
            content: kBottomSheetEmptyTemplateGenericSheetContent,
            fileType: FileType.text
          ),
        ],
        modificationFiles: [
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-bottom-sheet',
            modificationTemplate: '''StackedBottomsheet(classType: {{sheetName}}),''',
            modificationProblemError: 'The bottom sheet registration should be stored in lib/app/app.dart',
            modificationName: 'Add \'{{sheetName}}\' dependency to StackedApp annotations file',
          ),
          ModificationFile(
            relativeModificationPath: 'lib/app/app.dart',
            modificationIdentifier: '// @stacked-import',
            modificationTemplate: '''import \'package:{{packageName}}/{{{bottomSheetsPath}}}/{{sheetFolderName}}/{{sheetFilename}}\';''',
            modificationProblemError: 'The bottom sheet registration should be stored in lib/app/app.dart',
            modificationName: 'Add import for \'{{sheetName}}\' class',
          ),
        ],
      ),
  },
  
};
