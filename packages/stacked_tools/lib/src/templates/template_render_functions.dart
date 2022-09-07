import 'package:recase/recase.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/config_service.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';

/// Definition of a function that when executed returns a Map<String, String>
typedef RenderFunction = Map<String, String> Function(ReCase value);

Map<String, RenderFunction> renderFunctions = {
  kTemplateNameView: (ReCase value) {
    return {
      kTemplatePropertyViewName: '${value.pascalCase}View',
      kTemplatePropertyViewModelName: '${value.pascalCase}ViewModel',
      kTemplatePropertyViewModelFileName: '${value.snakeCase}_viewmodel.dart',
      kTemplatePropertyViewFolderName: value.snakeCase,
      kTemplatePropertyViewFileName: '${value.snakeCase}_view.dart',
    };
  },
  kTemplateNameService: (ReCase value, [map]) => {
        kTemplatePropertyServiceName: value.pascalCase,
        kTemplatePropertyServiceFilename: '${value.snakeCase}_service.dart',
        kTemplatePropertyLocatorName: locator<ConfigService>().locatorName,
      },
  kTemplateNameApp: (ReCase value, [map]) => {},
};
