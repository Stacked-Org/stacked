import 'package:example/app/app.locator.dart';
import 'package:example/enums/dialog_type.dart';
import 'package:example/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<dynamic, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    // @stacked-dialog-builder
  };

  dialogService.registerCustomDialogBuilders(builders);
}
