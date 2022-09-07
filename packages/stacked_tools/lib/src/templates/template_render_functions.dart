import 'package:freezed_annotation/freezed_annotation.dart';
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
  kTemplateNameService: (ReCase value, [map]) {
    final configService = locator<ConfigService>();
    return {
      kTemplatePropertyServiceName: value.pascalCase,
      kTemplatePropertyServiceFilename: '${value.snakeCase}_service.dart',
      kTemplatePropertyLocatorName: configService.locatorName,
      kTemplatePropertyRelativeLocatorPath: getRelativeLocatorPath(
        stackedAppPath: configService.stackedAppPath,
      ),
    };
  },
  kTemplateNameApp: (ReCase value, [map]) => {},
};

@visibleForTesting
String getRelativeLocatorPath({required String stackedAppPath}) {
  final pathWithoutLib = stackedAppPath.replaceFirst('lib/', '');
  final pathWithLocator = pathWithoutLib.split('.')..insert(1, 'locator');

  return pathWithLocator.join('.');
}
