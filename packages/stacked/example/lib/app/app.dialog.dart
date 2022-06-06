// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';
import 'app.locator.dart';

import '../ui/dialogs/basic_dialog.dart';

enum DialogType {
  basicDialog,
}

void setupDialogUi() {
  var dialogService = exampleLocator<DialogService>();

  final builders = {
    DialogType.basicDialog: (context, DialogRequest request,
            void Function(DialogResponse) completer) =>
        BasicDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
