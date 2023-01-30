import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

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
        relativeOutputPath: kAppTemplateSetupDialogUiPath,
        content: kAppTemplateSetupDialogUiContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateSetupBottomSheetUiPath,
        content: kAppTemplateSetupBottomSheetUiContent,
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
        relativeOutputPath: kAppTemplateDialogTypePath,
        content: kAppTemplateDialogTypeContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateBottomSheetTypePath,
        content: kAppTemplateBottomSheetTypeContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplatePubspecYamlStkPath,
        content: kAppTemplatePubspecYamlStkContent,
      ),
    ],
    modificationFiles: [
    ],
  ),
  
  'dialog': StackedTemplate(
    templateFiles: [
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
        relativeModificationPath: 'lib/ui/setup/setup_dialog_ui.dart',
        modificationIdentifier: '// @stacked-import',
        modificationTemplate: '''import \'package:{{packageName}}/{{{dialogsPath}}}/{{dialogFolderName}}/{{dialogFilename}}.dart\';''',
        modificationProblemError: 'It seems your file where custom dialog builders are set is not in lib/ui/setup/setup_dialog_ui.dart. Add a stacked.json file and set \'dialog_builder_file_path\' so we can locate your file.',
        modificationName: 'Add import for \'{{dialogName}}\' Dialog',
      ),
      ModificationFile(
        relativeModificationPath: 'lib/ui/setup/setup_dialog_ui.dart',
        modificationIdentifier: '// @stacked-dialog-builder',
        modificationTemplate: '''DialogType.{{dialogType}}: (context, request, completer) => {{dialogName}}(completer: completer, request: request),''',
        modificationProblemError: 'It seems your file where custom dialog builders are set is not in lib/ui/setup/setup_dialog_ui.dart. Add a stacked.json file and set \'dialog_builder_file_path\' so we can locate your file.',
        modificationName: 'Add \'{{dialogName}}\' custom builder',
      ),
      ModificationFile(
        relativeModificationPath: 'lib/enums/dialog_type.dart',
        modificationIdentifier: '// @stacked-dialog-type',
        modificationTemplate: '''{{dialogType}},''',
        modificationProblemError: 'It seems your file for DialogType class is not in lib/enums/dialog_type.dart. Add a stacked.json file and set the path for \'dialog_type_file_path\' to the folder so we can locate your DialogType class.',
        modificationName: 'Add \'{{dialogType}}\' value to DialogType',
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
  
  'bottom_sheet': StackedTemplate(
    templateFiles: [
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
        relativeModificationPath: 'lib/ui/setup/setup_bottom_sheet_ui.dart',
        modificationIdentifier: '// @stacked-import',
        modificationTemplate: '''import \'package:{{packageName}}/{{{bottomSheetsPath}}}/{{sheetFolderName}}/{{sheetFilename}}.dart\';''',
        modificationProblemError: 'It seems your file where custom bottom sheet builders are set is not in lib/ui/setup/setup_bottom_sheet_ui.dart. Add a stacked.json file and set \'bottom_sheet_custom_builders_path\' so we can locate your file.',
        modificationName: 'Add import for \'{{sheetName}}\' BottomSheet',
      ),
      ModificationFile(
        relativeModificationPath: 'lib/enums/bottom_sheet_type.dart',
        modificationIdentifier: '// @stacked-bottom-sheet-type',
        modificationTemplate: '''{{sheetType}},''',
        modificationProblemError: 'It seems your file for BottomSheetType class is not in lib/enums/bottom_sheet_type.dart. Add a stacked.json file and set the path for \'bottom_sheet_type_enums\' to the folder so we can locate your BottomSheetType class.',
        modificationName: 'Add \'{{sheetType}}\' type to BottomSheetType',
      ),
      ModificationFile(
        relativeModificationPath: 'lib/ui/setup/setup_bottom_sheet_ui.dart',
        modificationIdentifier: '// @stacked-bottom-sheet-builder',
        modificationTemplate: '''BottomSheetType.{{sheetType}}: (context, request, completer) => {{sheetName}}(completer: completer, request: request),''',
        modificationProblemError: 'It seems your file where custom bottom sheet builders are set is not in lib/ui/setup/setup_bottom_sheet_ui.dart. Add a stacked.json file and set \'bottom_sheet_custom_builders_path\' so we can locate your file.',
        modificationName: 'Add \'{{sheetName}}\' custom builder',
      ),
    ],
  ),
  
};
