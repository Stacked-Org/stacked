import 'package:stacked_tools/src/models/template_models.dart';
import 'package:stacked_tools/src/templates/compiled_templates.dart';

Map<String, StackedTemplate> kCompiledStackedTemplates = {
  'app': StackedTemplate(
    templateFiles: [
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
        relativeOutputPath: kAppTemplateNoticeSheetPath,
        content: kAppTemplateNoticeSheetContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateNoticeSheetViewmodelPath,
        content: kAppTemplateNoticeSheetViewmodelContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateInfoAlertDialogPath,
        content: kAppTemplateInfoAlertDialogContent,
      ),
      TemplateFile(
        relativeOutputPath: kAppTemplateInfoAlertViewmodelPath,
        content: kAppTemplateInfoAlertViewmodelContent,
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
    modificationFiles: [],
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
    ],
    modificationFiles: [
      ModificationFile(
        relativeModificationPath: 'lib/app/app.dart',
        modificationIdentifier: '// @stacked-route',
        modificationTemplate: '''MaterialRoute(page: {{viewName}}),''',
        modificationProblemError:
            'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/',
        modificationName: 'Add {{viewName}} route to app.dart',
      ),
      ModificationFile(
        relativeModificationPath: 'lib/app/app.dart',
        modificationIdentifier: '// @stacked-import',
        modificationTemplate:
            '''import \'package:{{packageName}}/{{{viewImportPath}}}/{{viewFolderName}}/{{viewFileName}}\';''',
        modificationProblemError:
            'The structure of your stacked application is invalid. The app.dart file should be located in lib/app/',
        modificationName: 'Add {{viewName}} route import to app.dart',
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
            '''Mock{{serviceName}}Service getAndRegister{{serviceName}}Service() { 
_removeRegistrationIfExists<{{serviceName}}Service>(); 
final service = Mock{{serviceName}}Service(); 
locator.registerSingleton<{{serviceName}}Service>(service); 
return service; 
}''',
        modificationProblemError:
            'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
        modificationName: 'Add {{serviceName}} mock to test helpers',
      ),
      ModificationFile(
        relativeModificationPath: 'test/helpers/test_helpers.dart',
        modificationIdentifier: '// @stacked-import',
        modificationTemplate:
            '''import \'package:{{packageName}}/{{{serviceImportPath}}}/{{serviceFilename}}\';''',
        modificationProblemError:
            'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
        modificationName: 'Add {{serviceName}} import to test helpers',
      ),
      ModificationFile(
        relativeModificationPath: 'lib/app/app.dart',
        modificationIdentifier: '// @stacked-service',
        modificationTemplate:
            '''LazySingleton(classType: {{serviceName}}Service),''',
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
            '''MockSpec<{{serviceName}}Service>(onMissingStub: OnMissingStub.returnDefault),''',
        modificationProblemError:
            'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
        modificationName: 'Create {{serviceName}} mock to test helpers',
      ),
      ModificationFile(
        relativeModificationPath: 'test/helpers/test_helpers.dart',
        modificationIdentifier: '// @stacked-mock-register',
        modificationTemplate: '''getAndRegister{{serviceName}}Service();''',
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
            'The test mocks and helpers should be stored in test/helpers/test_helpers.dart',
        modificationName: 'Add {{serviceName}} import to test helpers',
      ),
    ],
  ),
};
