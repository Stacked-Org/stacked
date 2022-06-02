// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import '../../../helpers/basic_dialog.dart';
import '../../../helpers/complex_dialog.dart';

enum DialogType {
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
