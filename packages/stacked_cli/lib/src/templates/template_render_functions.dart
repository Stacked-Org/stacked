import 'package:recase/recase.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

/// Definition of a function that when executed returns a Map<String, String>
typedef RenderFunction = Map<String, String> Function(ReCase value);

Map<String, RenderFunction> renderFunctions = {
  kTemplateNameView: (ReCase value) => {
        kTemplatePropertyViewName: '${value.pascalCase}View',
        kTemplatePropertyViewModelName: '${value.pascalCase}ViewModel',
        kTemplatePropertyViewModelFileName: '${value.snakeCase}_viewmodel.dart',
      },
  kTemplateNameService: (ReCase value) => {
        'serviceName': value.pascalCase,
      },
};
