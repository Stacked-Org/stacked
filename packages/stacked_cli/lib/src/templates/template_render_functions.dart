import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recase/recase.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

/// Definition of a function that when executed returns a Map<String, String>
typedef RenderFunction = Map<String, String> Function(ReCase value);

Map<String, RenderFunction> renderFunctions = {
  kTemplateNameView: (ReCase value) {
    final configService = locator<ConfigService>();
    return {
      kTemplatePropertyViewName: '${value.pascalCase}View',
      kTemplatePropertyViewModelName: '${value.pascalCase}ViewModel',
      kTemplatePropertyViewModelFileName: '${value.snakeCase}_viewmodel.dart',
      kTemplatePropertyViewFolderName: value.snakeCase,
      kTemplatePropertyViewFileName: '${value.snakeCase}_view.dart',
      kTemplatePropertyRelativeLocatorPath: getRelativeLocatorPath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
    };
  },
  kTemplateNameService: (ReCase value, [map]) {
    final configService = locator<ConfigService>();
    return {
      kTemplatePropertyServiceName: value.pascalCase,
      kTemplatePropertyServiceFilename: '${value.snakeCase}_service.dart',
      kTemplatePropertyLocatorName: configService.locatorName,
      kTemplatePropertyRelativeLocatorPath: getRelativeLocatorPath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
      kTemplatePropertyRegisterMocksFunction:
          configService.registerMocksFunction,
    };
  },
  kTemplateNameApp: (ReCase value, [map]) {
    final configService = locator<ConfigService>();
    return {
      kTemplatePropertyRelativeLocatorPath: getRelativeLocatorPath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
    };
  },
};

@visibleForTesting
String getRelativeLocatorPath({required String stackedAppFilePath}) {
  final pathWithoutLib = stackedAppFilePath.replaceFirst('lib/', '');
  final pathWithLocator = pathWithoutLib.split('.')..insert(1, 'locator');

  return pathWithLocator.join('.');
}
