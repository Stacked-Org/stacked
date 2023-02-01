const kDialogsEmpty = '''

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

enum DialogType{
}
void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
  
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
  final dialogService = customLocator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
  
  };

  dialogService.registerCustomDialogBuilders(builders);
}
''';
const kOneDialog = '''

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import 'one.dart';

enum DialogType{
basic,
}
void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
  
  DialogType.basic: (context, request, completer) =>
        BasicDialog(request: request, completer: completer),
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
basic,
complex,
}
void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
  
  DialogType.basic: (context, request, completer) =>
        BasicDialog(request: request, completer: completer),
  DialogType.complex: (context, request, completer) =>
        ComplexDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
''';
