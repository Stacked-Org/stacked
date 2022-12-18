import 'package:stacked_hooks_example/app/app.locator.dart';
import 'package:stacked_hooks_example/enums/dialog_type.dart';
import 'package:stacked_hooks_example/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<dynamic, DialogBuilder> builders = {
    DialogType.infoAlert: (context, sheetRequest, completer) =>
        InfoAlertDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
