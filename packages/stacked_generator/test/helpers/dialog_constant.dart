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
basicDialog,
}
void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
  
  DialogType.basicDialog: (context, DialogRequest request, void Function(DialogResponse) completer) =>
        BasicDialog(request: request,completer: completer),
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
basicDialog,
complexDialog,
}
void setupDialogUi() {
  var dialogService = locator<DialogService>();

  final builders = {
  
  DialogType.basicDialog: (context, DialogRequest request, void Function(DialogResponse) completer) =>
        BasicDialog(request: request,completer: completer),
  DialogType.complexDialog: (context, DialogRequest request, void Function(DialogResponse) completer) =>
        ComplexDialog(request: request,completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
''';
