const kDialogsEmpty = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';


enum DialogType{
}
void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
  
  };

  dialogService.registerCustomDialogBuilders(builders);
}
''';
const kDialogsWithCustomNamedLocator = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';


enum DialogType{
}
void setupDialogUi() {
  var dialogService = customLocator<DialogService>();

  final builders = {
  
  };

  dialogService.registerCustomDialogBuilders(builders);
}
''';
const kOneDialog = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import 'one.dart';

enum DialogType{
BasicDialog,
}
void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
  
  DialogType.BasicDialog: (context, sheetRequest, completer) =>
        BasicDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
''';
const kTwoDialogs = '''

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import 'one.dart';
import 'two.dart';

enum DialogType{
BasicDialog,
ComplexDialog,
}
void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
  
  DialogType.BasicDialog: (context, sheetRequest, completer) =>
        BasicDialog(request: sheetRequest, completer: completer),
  DialogType.ComplexDialog: (context, sheetRequest, completer) =>
        ComplexDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
''';
