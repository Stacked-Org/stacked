import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recase/recase.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

/// Definition of a function that when executed returns a Map<String, String>
typedef RenderFunction = Map<String, String> Function(ReCase value);

Map<String, RenderFunction> renderFunctions = {
  kTemplateNameView: (ReCase value) {
    return {
      kTemplatePropertyViewName: '${value.pascalCase}View',
      kTemplatePropertyViewFileName: '${value.snakeCase}_view.dart',
      kTemplatePropertyViewFileNameWithoutExtension: value.snakeCase,
      kTemplatePropertyViewModelName: '${value.pascalCase}ViewModel',
      kTemplatePropertyViewModelFileName: '${value.snakeCase}_viewmodel.dart',
      kTemplatePropertyViewFolderName: value.snakeCase,
      kTemplatePropertyRelativeLocatorFilePath: getFilePath(builder: 'locator'),
    };
  },
  kTemplateNameService: (ReCase value, [map]) {
    final configService = locator<ConfigService>();
    return {
      kTemplatePropertyServiceName: '${value.pascalCase}Service',
      kTemplatePropertyServiceFilename: '${value.snakeCase}_service.dart',
      kTemplatePropertyLocatorName: configService.locatorName,
      kTemplatePropertyRelativeLocatorFilePath: getFilePath(builder: 'locator'),
      kTemplatePropertyRegisterMocksFunction:
          configService.registerMocksFunction,
    };
  },
  kTemplateNameApp: (ReCase value, [map]) {
    return {
      kTemplatePropertyRelativeBottomSheetFilePath: getFilePath(
        builder: 'bottomsheets',
      ),
      kTemplatePropertyRelativeDialogFilePath: getFilePath(builder: 'dialogs'),
      kTemplatePropertyRelativeLocatorFilePath: getFilePath(builder: 'locator'),
      kTemplatePropertyRelativeRouterFilePath: getFilePath(builder: 'router'),
    };
  },
  kTemplateNameBottomSheet: (ReCase value) {
    return {
      kTemplatePropertySheetName: '${value.pascalCase}Sheet',
      kTemplatePropertySheetFilename: '${value.snakeCase}_sheet.dart',
      kTemplatePropertySheetModelName: '${value.pascalCase}SheetModel',
      kTemplatePropertySheetModelFilename:
          '${value.snakeCase}_sheet_model.dart',
      kTemplatePropertySheetFolderName: value.snakeCase,
      kTemplatePropertySheetType: value.camelCase,
      kTemplatePropertyRelativeLocatorFilePath: getFilePath(builder: 'locator'),
    };
  },
  kTemplateNameDialog: (ReCase value) {
    return {
      kTemplatePropertyDialogName: '${value.pascalCase}Dialog',
      kTemplatePropertyDialogFilename: '${value.snakeCase}_dialog.dart',
      kTemplatePropertyDialogModelName: '${value.pascalCase}DialogModel',
      kTemplatePropertyDialogModelFilename:
          '${value.snakeCase}_dialog_model.dart',
      kTemplatePropertyDialogFolderName: value.snakeCase,
      kTemplatePropertyDialogType: value.camelCase,
      kTemplatePropertyRelativeLocatorFilePath: getFilePath(builder: 'locator'),
    };
  },
};

/// Returns file path of the [builder]
@visibleForTesting
String getFilePath({required String builder}) {
  final path = locator<ConfigService>()
      .stackedAppFilePath
      .replaceFirst('lib/', '')
      .split('.')
    ..insert(1, builder);

  return path.join('.');
}
