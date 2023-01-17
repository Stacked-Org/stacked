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
      kTemplatePropertyServiceName: '${value.pascalCase}Service',
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
      kTemplatePropertyRelativeRouterPath: getRelativeRouterFilePath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
    };
  },
  kTemplateNameBottomSheet: (ReCase value) {
    return {
      kTemplatePropertySheetName: '${value.pascalCase}Sheet',
      kTemplatePropertySheetFilename: '${value.snakeCase}_sheet',
      kTemplatePropertySheetFolderName: value.snakeCase,
      kTemplatePropertySheetType: value.camelCase,
    };
  },
  kTemplateNameDialog: (ReCase value) {
    return {
      kTemplatePropertyDialogName: '${value.pascalCase}Dialog',
      kTemplatePropertyDialogFilename: '${value.snakeCase}_dialog',
      kTemplatePropertyDialogFolderName: value.snakeCase,
      kTemplatePropertyDialogType: value.camelCase,
    };
  },
};

@visibleForTesting
String getRelativeLocatorPath({required String stackedAppFilePath}) {
  final pathWithoutLib = stackedAppFilePath.replaceFirst('lib/', '');
  final pathWithLocator = pathWithoutLib.split('.')..insert(1, 'locator');

  return pathWithLocator.join('.');
}

String getRelativeRouterFilePath({required String stackedAppFilePath}) {
  final pathWithoutLib = stackedAppFilePath.replaceFirst('lib/', '');
  final pathWithLocator = pathWithoutLib.split('.')..insert(1, 'router');

  return pathWithLocator.join('.');
}
