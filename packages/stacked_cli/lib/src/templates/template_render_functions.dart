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
      kTemplatePropertyViewFileName: '${value.snakeCase}_view.dart',
      kTemplatePropertyViewModelName: '${value.pascalCase}ViewModel',
      kTemplatePropertyViewModelFileName: '${value.snakeCase}_viewmodel.dart',
      kTemplatePropertyViewFolderName: value.snakeCase,
      kTemplatePropertyRelativeLocatorFilePath: getRelativeLocatorFilePath(
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
      kTemplatePropertyRelativeLocatorFilePath: getRelativeLocatorFilePath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
      kTemplatePropertyRegisterMocksFunction:
          configService.registerMocksFunction,
    };
  },
  kTemplateNameApp: (ReCase value, [map]) {
    final configService = locator<ConfigService>();
    return {
      kTemplatePropertyRelativeBottomSheetFilePath:
          getRelativeBottomSheetFilePath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
      kTemplatePropertyRelativeDialogFilePath: getRelativeDialogFilePath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
      kTemplatePropertyRelativeLocatorFilePath: getRelativeLocatorFilePath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
      kTemplatePropertyRelativeRouterFilePath: getRelativeRouterFilePath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
    };
  },
  kTemplateNameBottomSheet: (ReCase value) {
    final configService = locator<ConfigService>();
    return {
      kTemplatePropertySheetName: '${value.pascalCase}Sheet',
      kTemplatePropertySheetFilename: '${value.snakeCase}_sheet',
      kTemplatePropertySheetModelName: '${value.pascalCase}SheetModel',
      kTemplatePropertySheetModelFilename:
          '${value.snakeCase}_sheet_model.dart',
      kTemplatePropertySheetFolderName: value.snakeCase,
      kTemplatePropertySheetType: value.camelCase,
      kTemplatePropertyRelativeLocatorFilePath: getRelativeLocatorFilePath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
    };
  },
  kTemplateNameDialog: (ReCase value) {
    final configService = locator<ConfigService>();
    return {
      kTemplatePropertyDialogName: '${value.pascalCase}Dialog',
      kTemplatePropertyDialogFilename: '${value.snakeCase}_dialog',
      kTemplatePropertyDialogModelName: '${value.pascalCase}DialogModel',
      kTemplatePropertyDialogModelFilename:
          '${value.snakeCase}_dialog_model.dart',
      kTemplatePropertyDialogFolderName: value.snakeCase,
      kTemplatePropertyDialogType: value.camelCase,
      kTemplatePropertyRelativeLocatorFilePath: getRelativeLocatorFilePath(
        stackedAppFilePath: configService.stackedAppFilePath,
      ),
    };
  },
};

@visibleForTesting
String getRelativeLocatorFilePath({required String stackedAppFilePath}) {
  final pathWithoutLib = stackedAppFilePath.replaceFirst('lib/', '');
  final pathWithLocator = pathWithoutLib.split('.')..insert(1, 'locator');

  return pathWithLocator.join('.');
}

String getRelativeRouterFilePath({required String stackedAppFilePath}) {
  final pathWithoutLib = stackedAppFilePath.replaceFirst('lib/', '');
  final pathWithRouter = pathWithoutLib.split('.')..insert(1, 'router');

  return pathWithRouter.join('.');
}

String getRelativeBottomSheetFilePath({required String stackedAppFilePath}) {
  final pathWithoutLib = stackedAppFilePath.replaceFirst('lib/', '');
  final pathWithBottomSheets = pathWithoutLib.split('.')
    ..insert(1, 'bottomsheets');

  return pathWithBottomSheets.join('.');
}

String getRelativeDialogFilePath({required String stackedAppFilePath}) {
  final pathWithoutLib = stackedAppFilePath.replaceFirst('lib/', '');
  final pathWithDialog = pathWithoutLib.split('.')..insert(1, 'dialogs');

  return pathWithDialog.join('.');
}
