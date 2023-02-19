// ignore_for_file: unnecessary_string_escapes

import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';

Map<String, StackedTemplate> kCompiledStackedTemplates = {
  'app': StackedTemplate(
    templateFiles: [
      TemplateFile(
        relativeOutputPath: kAppTemplateStackedJsonStkPath,
        content: kAppTemplateStackedJsonStkContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateHomeViewmodelTestPath,
        content: kAppTemplateHomeViewmodelTestContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateNoticeSheetModelTestPath,
        content: kAppTemplateNoticeSheetModelTestContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateInfoAlertDialogModelTestPath,
        content: kAppTemplateInfoAlertDialogModelTestContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateTestHelpersPath,
        content: kAppTemplateTestHelpersContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateREADMEMdStkPath,
        content: kAppTemplateREADMEMdStkContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateMainPath,
        content: kAppTemplateMainContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateUiHelpersPath,
        content: kAppTemplateUiHelpersContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateAppStringsPath,
        content: kAppTemplateAppStringsContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateAppColorsPath,
        content: kAppTemplateAppColorsContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateNoticeSheetModelPath,
        content: kAppTemplateNoticeSheetModelContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateNoticeSheetPath,
        content: kAppTemplateNoticeSheetContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateInfoAlertDialogModelPath,
        content: kAppTemplateInfoAlertDialogModelContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateInfoAlertDialogPath,
        content: kAppTemplateInfoAlertDialogContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateHomeViewV1Path,
        content: kAppTemplateHomeViewV1Content,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateHomeViewPath,
        content: kAppTemplateHomeViewContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateHomeViewmodelPath,
        content: kAppTemplateHomeViewmodelContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateStartupViewmodelPath,
        content: kAppTemplateStartupViewmodelContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateStartupViewV1Path,
        content: kAppTemplateStartupViewV1Content,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateStartupViewPath,
        content: kAppTemplateStartupViewContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateAppPath,
        content: kAppTemplateAppContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplatePubspecYamlStkPath,
        content: kAppTemplatePubspecYamlStkContent,
      ),
    ],
    modificationFiles: [],
  ),
  'dialog': StackedTemplate(
    templateFiles: [
      TemplateFile(
        relativeOutputPath: kDialogTemplateGenericDialogModelTestPath,
        content: kDialogTemplateGenericDialogModelTestContent,
      ),
      TemplateFile(
        relativeOutputPath: kDialogTemplateGenericDialogModelPath,
        content: kDialogTemplateGenericDialogModelContent,
      ),
      TemplateFile(
        relativeOutputPath: kDialogTemplateGenericDialogUseModelPath,
        content: kDialogTemplateGenericDialogUseModelContent,
      ),
      TemplateFile(
        relativeOutputPath: kDialogTemplateGenericDialogPath,
        content: kDialogTemplateGenericDialogContent,
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
  'view': StackedTemplate(
    templateFiles: [
      TemplateFile(
        relativeOutputPath: kViewTemplateGenericViewmodelTestPath,
        content: kViewTemplateGenericViewmodelTestContent,
      ),
      TemplateFile(
        relativeOutputPath: kViewTemplateGenericViewmodelPath,
        content: kViewTemplateGenericViewmodelContent,
      ),
      TemplateFile(
        relativeOutputPath: kViewTemplateGenericViewPath,
        content: kViewTemplateGenericViewContent,
      ),
      TemplateFile(
        relativeOutputPath: kViewTemplateGenericViewV1Path,
        content: kViewTemplateGenericViewV1Content,
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
  'service': StackedTemplate(
    templateFiles: [
      TemplateFile(
        relativeOutputPath: kServiceTemplateGenericServiceTestPath,
        content: kServiceTemplateGenericServiceTestContent,
      ),
      TemplateFile(
        relativeOutputPath: kServiceTemplateGenericServicePath,
        content: kServiceTemplateGenericServiceContent,
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
        modificationTemplate: '''LazySingleton(classType: {{serviceName}}),''',
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
  'bottom_sheet': StackedTemplate(
    templateFiles: [
      TemplateFile(
        relativeOutputPath: kBottomSheetTemplateGenericSheetModelTestPath,
        content: kBottomSheetTemplateGenericSheetModelTestContent,
      ),
      TemplateFile(
        relativeOutputPath: kBottomSheetTemplateGenericSheetModelPath,
        content: kBottomSheetTemplateGenericSheetModelContent,
      ),
      TemplateFile(
        relativeOutputPath: kBottomSheetTemplateGenericSheetUseModelPath,
        content: kBottomSheetTemplateGenericSheetUseModelContent,
      ),
      TemplateFile(
        relativeOutputPath: kBottomSheetTemplateGenericSheetPath,
        content: kBottomSheetTemplateGenericSheetContent,
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
};
