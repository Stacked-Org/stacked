import 'package:stacked_cli/src/message_constants.dart';
import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

Map<String, StackedTemplate> kCompiledStackedTemplates = {
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
        modificationProblemError: 'The structure of your stacked application is invalid. The app.dart file should be located in lib&#x2F;app&#x2F;',
      ),
      ModificationFile(
        relativeModificationPath: 'lib/app/app.dart',
        modificationIdentifier: '// @stacked-import',
        modificationTemplate: '''import \'package:{{packageName}}/ui/views/{{viewFolderName}}/{{viewFileName}}\';''',
        modificationProblemError: 'The structure of your stacked application is invalid. The app.dart file should be located in lib&#x2F;app&#x2F;',
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
        relativeModificationPath: 'test/helpers/test_helper.dart',
        modificationIdentifier: '// @stacked-mock-helper-register',
        modificationTemplate: '''getAndRegister{{serviceName}}Service();''',
        modificationProblemError: 'The test mocks and helpers should be stored in test&#x2F;helpers&#x2F;test_helper.dart',
      ),
      ModificationFile(
        relativeModificationPath: 'test/helpers/test_helper.dart',
        modificationIdentifier: '// @stacked-import',
        modificationTemplate: '''import \'package:{{packageName}}/services/{{serviceFilename}}\';''',
        modificationProblemError: 'The test mocks and helpers should be stored in test&#x2F;helpers&#x2F;test_helper.dart',
      ),
      ModificationFile(
        relativeModificationPath: 'test/helpers/test_helper.dart',
        modificationIdentifier: '// @stacked-mock-helper',
        modificationTemplate: '''Mock{{serviceName}}Service getAndRegister{{serviceName}}Service() { 
_removeRegistrationIfExists<{{serviceName}}Service>(); 
final service = Mock{{serviceName}}Service(); 
locator.registerSingleton<{{serviceName}}Service>(service); 
return service; 
}''',
        modificationProblemError: 'The test mocks and helpers should be stored in test&#x2F;helpers&#x2F;test_helper.dart',
      ),
      ModificationFile(
        relativeModificationPath: 'test/helpers/test_helper.dart',
        modificationIdentifier: '// @stacked-service-mock',
        modificationTemplate: '''MockSpec<{{serviceName}}Service>(returnNullOnMissingStub: true),''',
        modificationProblemError: 'The test mocks and helpers should be stored in test&#x2F;helpers&#x2F;test_helper.dart',
      ),
    ],
  ),
  
};
