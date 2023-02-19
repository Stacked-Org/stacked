// ignore_for_file: unnecessary_string_escapes

import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';

Map<String, Map<String, StackedTemplate>> kCompiledStackedTemplates = {
  'app': {
    'web': StackedTemplate(
      templateFiles: [
        TemplateFile(
          relativeOutputPath: kAppWebTemplateStackedJsonStkPath,
          content: kAppWebTemplateStackedJsonStkContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateHomeViewmodelTestPath,
          content: kAppWebTemplateHomeViewmodelTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateNoticeSheetModelTestPath,
          content: kAppWebTemplateNoticeSheetModelTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateInfoAlertDialogModelTestPath,
          content: kAppWebTemplateInfoAlertDialogModelTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateTestHelpersPath,
          content: kAppWebTemplateTestHelpersContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateREADMEMdStkPath,
          content: kAppWebTemplateREADMEMdStkContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateMainPath,
          content: kAppWebTemplateMainContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateUiHelpersPath,
          content: kAppWebTemplateUiHelpersContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateAppStringsPath,
          content: kAppWebTemplateAppStringsContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateAppColorsPath,
          content: kAppWebTemplateAppColorsContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateNoticeSheetModelPath,
          content: kAppWebTemplateNoticeSheetModelContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateNoticeSheetPath,
          content: kAppWebTemplateNoticeSheetContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateInfoAlertDialogModelPath,
          content: kAppWebTemplateInfoAlertDialogModelContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateInfoAlertDialogPath,
          content: kAppWebTemplateInfoAlertDialogContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateHomeViewV1Path,
          content: kAppWebTemplateHomeViewV1Content,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateHomeViewPath,
          content: kAppWebTemplateHomeViewContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateHomeViewmodelPath,
          content: kAppWebTemplateHomeViewmodelContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateStartupViewmodelPath,
          content: kAppWebTemplateStartupViewmodelContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateStartupViewV1Path,
          content: kAppWebTemplateStartupViewV1Content,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateStartupViewPath,
          content: kAppWebTemplateStartupViewContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplateAppPath,
          content: kAppWebTemplateAppContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppWebTemplatePubspecYamlStkPath,
          content: kAppWebTemplatePubspecYamlStkContent,
        ),
      ],
      modificationFiles: [],
    ),
    'mobile': StackedTemplate(
      templateFiles: [
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateStackedJsonStkPath,
          content: kAppMobileTemplateStackedJsonStkContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateHomeViewmodelTestPath,
          content: kAppMobileTemplateHomeViewmodelTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateNoticeSheetModelTestPath,
          content: kAppMobileTemplateNoticeSheetModelTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateInfoAlertDialogModelTestPath,
          content: kAppMobileTemplateInfoAlertDialogModelTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateTestHelpersPath,
          content: kAppMobileTemplateTestHelpersContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateREADMEMdStkPath,
          content: kAppMobileTemplateREADMEMdStkContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateMainPath,
          content: kAppMobileTemplateMainContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateUiHelpersPath,
          content: kAppMobileTemplateUiHelpersContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateAppStringsPath,
          content: kAppMobileTemplateAppStringsContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateAppColorsPath,
          content: kAppMobileTemplateAppColorsContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateNoticeSheetModelPath,
          content: kAppMobileTemplateNoticeSheetModelContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateNoticeSheetPath,
          content: kAppMobileTemplateNoticeSheetContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateInfoAlertDialogModelPath,
          content: kAppMobileTemplateInfoAlertDialogModelContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateInfoAlertDialogPath,
          content: kAppMobileTemplateInfoAlertDialogContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateHomeViewV1Path,
          content: kAppMobileTemplateHomeViewV1Content,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateHomeViewPath,
          content: kAppMobileTemplateHomeViewContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateHomeViewmodelPath,
          content: kAppMobileTemplateHomeViewmodelContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateStartupViewmodelPath,
          content: kAppMobileTemplateStartupViewmodelContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateStartupViewV1Path,
          content: kAppMobileTemplateStartupViewV1Content,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateStartupViewPath,
          content: kAppMobileTemplateStartupViewContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplateAppPath,
          content: kAppMobileTemplateAppContent,
        ),
        TemplateFile(
          relativeOutputPath: kAppMobileTemplatePubspecYamlStkPath,
          content: kAppMobileTemplatePubspecYamlStkContent,
        ),
      ],
      modificationFiles: [],
    ),
  },
  'dialog': {
    'empty': StackedTemplate(
      templateFiles: [
        TemplateFile(
          relativeOutputPath: kDialogEmptyTemplateGenericDialogModelTestPath,
          content: kDialogEmptyTemplateGenericDialogModelTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kDialogEmptyTemplateGenericDialogModelPath,
          content: kDialogEmptyTemplateGenericDialogModelContent,
        ),
        TemplateFile(
          relativeOutputPath: kDialogEmptyTemplateGenericDialogUseModelPath,
          content: kDialogEmptyTemplateGenericDialogUseModelContent,
        ),
        TemplateFile(
          relativeOutputPath: kDialogEmptyTemplateGenericDialogPath,
          content: kDialogEmptyTemplateGenericDialogContent,
        ),
      ],
      modificationFiles: [
        ModificationFile(
          relativeModificationPath: 'lib/app/app.dart',
          modificationIdentifier: '// @stacked-dialog',
          modificationTemplate: '''StackedDialog(classType: {{dialogName}}),''',
          modificationProblemError:
              'The dialog registration should be stored in lib/app/app.dart',
          modificationName:
              'Add \'{{dialogName}}\' dependency to StackedApp annotations file',
        ),
        ModificationFile(
          relativeModificationPath: 'lib/app/app.dart',
          modificationIdentifier: '// @stacked-import',
          modificationTemplate:
              '''import \'package:{{packageName}}/{{{dialogsPath}}}/{{dialogFolderName}}/{{dialogFilename}}\';''',
          modificationProblemError:
              'The dialog registration should be stored in lib/app/app.dart',
          modificationName: 'Add import for \'{{dialogName}}\' class',
        ),
      ],
    ),
  },
  'view': {
    'empty': StackedTemplate(
      templateFiles: [
        TemplateFile(
          relativeOutputPath: kViewEmptyTemplateGenericViewmodelTestPath,
          content: kViewEmptyTemplateGenericViewmodelTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kViewEmptyTemplateGenericViewmodelPath,
          content: kViewEmptyTemplateGenericViewmodelContent,
        ),
        TemplateFile(
          relativeOutputPath: kViewEmptyTemplateGenericViewPath,
          content: kViewEmptyTemplateGenericViewContent,
        ),
        TemplateFile(
          relativeOutputPath: kViewEmptyTemplateGenericViewV1Path,
          content: kViewEmptyTemplateGenericViewV1Content,
        ),
      ],
      modificationFiles: [
        ModificationFile(
          relativeModificationPath: 'lib/app/app.dart',
          modificationIdentifier: '// @stacked-route',
          modificationTemplate: '''MaterialRoute(page: {{viewName}}),''',
          modificationProblemError:
              'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/',
          modificationName:
              'Add {{viewName}} route where @StackedApp annotation is located',
        ),
        ModificationFile(
          relativeModificationPath: 'lib/app/app.dart',
          modificationIdentifier: '// @stacked-import',
          modificationTemplate:
              '''import \'package:{{packageName}}/{{{viewImportPath}}}/{{viewFolderName}}/{{viewFileName}}\';''',
          modificationProblemError:
              'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/',
          modificationName:
              'Add {{viewName}} route import where @StackedApp annotation is located',
        ),
      ],
    ),
  },
  'service': {
    'empty': StackedTemplate(
      templateFiles: [
        TemplateFile(
          relativeOutputPath: kServiceEmptyTemplateGenericServiceTestPath,
          content: kServiceEmptyTemplateGenericServiceTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kServiceEmptyTemplateGenericServicePath,
          content: kServiceEmptyTemplateGenericServiceContent,
        ),
      ],
      modificationFiles: [
        ModificationFile(
          relativeModificationPath: 'test/helpers/test_helpers.dart',
          modificationIdentifier: '// @stacked-mock-create',
          modificationTemplate:
              '''Mock{{serviceName}} getAndRegister{{serviceName}}() { 
_removeRegistrationIfExists<{{serviceName}}>(); 
final service = Mock{{serviceName}}(); 
{{locatorName}}.registerSingleton<{{serviceName}}>(service); 
return service; 
}''',
          modificationProblemError:
              'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
          modificationName: 'Add {{serviceName}} mock to test helpers',
        ),
        ModificationFile(
          relativeModificationPath: 'lib/app/app.dart',
          modificationIdentifier: '// @stacked-service',
          modificationTemplate:
              '''LazySingleton(classType: {{serviceName}}),''',
          modificationProblemError:
              'The service registration should be stored in lib/app/app.dart',
          modificationName:
              'Add {{serviceName}} dependency to StackedApp annotations file',
        ),
        ModificationFile(
          relativeModificationPath: 'lib/app/app.dart',
          modificationIdentifier: '// @stacked-import',
          modificationTemplate:
              '''import \'package:{{packageName}}/{{{serviceImportPath}}}/{{serviceFilename}}\';''',
          modificationProblemError:
              'The service registration should be stored in lib/app/app.dart',
          modificationName:
              'Add {{serviceName}} import to StackedApp annotations file',
        ),
        ModificationFile(
          relativeModificationPath: 'test/helpers/test_helpers.dart',
          modificationIdentifier: '// @stacked-mock-spec',
          modificationTemplate:
              '''MockSpec<{{serviceName}}>(onMissingStub: OnMissingStub.returnDefault),''',
          modificationProblemError:
              'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
          modificationName: 'Create {{serviceName}} mock to test helpers',
        ),
        ModificationFile(
          relativeModificationPath: 'test/helpers/test_helpers.dart',
          modificationIdentifier: '// @stacked-mock-register',
          modificationTemplate: '''getAndRegister{{serviceName}}();''',
          modificationProblemError:
              'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
          modificationName: 'Add {{serviceName}} register to test helpers',
        ),
        ModificationFile(
          relativeModificationPath: 'test/helpers/test_helpers.dart',
          modificationIdentifier: '// @stacked-import',
          modificationTemplate:
              '''import \'package:{{packageName}}/{{{serviceImportPath}}}/{{serviceFilename}}\';''',
          modificationProblemError:
              'It seems your test_helpers.dart file is not in test/helpers/test_helpers.dart. Add a stacked.json file and set the path for \'test_helpers_path\' to the folder we can locate your test_helpers.dart file',
          modificationName: 'Add {{serviceName}} import to test helpers',
        ),
      ],
    ),
  },
  'bottom_sheet': {
    'empty': StackedTemplate(
      templateFiles: [
        TemplateFile(
          relativeOutputPath:
              kBottomSheetEmptyTemplateGenericSheetModelTestPath,
          content: kBottomSheetEmptyTemplateGenericSheetModelTestContent,
        ),
        TemplateFile(
          relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetModelPath,
          content: kBottomSheetEmptyTemplateGenericSheetModelContent,
        ),
        TemplateFile(
          relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetUseModelPath,
          content: kBottomSheetEmptyTemplateGenericSheetUseModelContent,
        ),
        TemplateFile(
          relativeOutputPath: kBottomSheetEmptyTemplateGenericSheetPath,
          content: kBottomSheetEmptyTemplateGenericSheetContent,
        ),
      ],
      modificationFiles: [
        ModificationFile(
          relativeModificationPath: 'lib/app/app.dart',
          modificationIdentifier: '// @stacked-bottom-sheet',
          modificationTemplate:
              '''StackedBottomsheet(classType: {{sheetName}}),''',
          modificationProblemError:
              'The bottom sheet registration should be stored in lib/app/app.dart',
          modificationName:
              'Add \'{{sheetName}}\' dependency to StackedApp annotations file',
        ),
        ModificationFile(
          relativeModificationPath: 'lib/app/app.dart',
          modificationIdentifier: '// @stacked-import',
          modificationTemplate:
              '''import \'package:{{packageName}}/{{{bottomSheetsPath}}}/{{sheetFolderName}}/{{sheetFilename}}\';''',
          modificationProblemError:
              'The bottom sheet registration should be stored in lib/app/app.dart',
          modificationName: 'Add import for \'{{sheetName}}\' class',
        ),
      ],
    ),
  },
};
