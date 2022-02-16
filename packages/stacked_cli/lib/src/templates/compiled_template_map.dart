import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/templates/compiled_templates.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

Map<String, StackedTemplate> kCompiledStackedTemplates = {
  kTemplateNameService: StackedTemplate(
    templateFiles: [
      TemplateFile(
        relativeOutputPath: kServiceTemplateGenericServicePath,
        content: kServiceTemplateGenericServiceContent,
      ),
      TemplateFile(
        relativeOutputPath: kServiceTemplateGenericServiceTestPath,
        content: kServiceTemplateGenericServiceTestContent,
      ),
    ],
    modificationFiles: [
      ModificationFile(
        relativeModificationPath: 'test/helpers/test_helper.dart',
        modificationIdentifier: '// @stacked-service-mock',
        modificationTemplate:
            'MockSpec<{{serviceName}}Service>(returnNullOnMissingStub: true),',
        modificationProblemError:
            'The test mocks and helpers should be stored in test&#x2F;helpers&#x2F;test_helper.dart',
      ),
    ],
  ),
  kTemplateNameView: StackedTemplate(
    templateFiles: [
      TemplateFile(
        relativeOutputPath: kViewTemplateGenericViewPath,
        content: kViewTemplateGenericViewContent,
      ),
      TemplateFile(
        relativeOutputPath: kViewTemplateGenericViewmodelPath,
        content: kViewTemplateGenericViewmodelContent,
      ),
      TemplateFile(
        relativeOutputPath: kViewTemplateGenericViewmodelTestPath,
        content: kViewTemplateGenericViewmodelTestContent,
      ),
    ],
    modificationFiles: [
      ModificationFile(
        relativeModificationPath: 'lib/app/app.dart',
        modificationIdentifier: '// @stacked-route',
        modificationTemplate:
            'import \'package:{{packageName}}/ui/views/{{viewFolderName}}/{{viewFileName}}\';',
        modificationProblemError:
            'The structure of your stacked application is invalid. The app.dart file should be located in lib&#x2F;app&#x2F;',
      ),
      ModificationFile(
        relativeModificationPath: 'lib/app/app.dart',
        modificationIdentifier: '// @stacked-import',
        modificationTemplate: 'MaterialRoute(page: {{viewName}}),',
        modificationProblemError:
            'The structure of your stacked application is invalid. The app.dart file should be located in lib&#x2F;app&#x2F;',
      ),
    ],
  ),
};
