import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/src/platform_dialog.dart';

enum DialogPlatform {
  Cupertino,
  Material,
  Custom,
}

/// A DialogService that uses the Get package to show dialogs
@lazySingleton
class DialogService {
  Completer<DialogResponse> _dialogCompleter;

  // TODO: Create a dialog UI registration factory that will allow users to register
  // dialogs to be built along with keys. the user should then be able to show the dialog
  // using that key.

  /// Shows a dialog to the user
  ///
  /// It will show a platform specific dialog by default. This can be changed by setting [dialogPlatform]
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String cancelText,
    String confirmText = 'Ok',

    /// Indicates which [DialogPlatform] to show.
    ///
    /// When not set a Platform specific dialog will be shown
    DialogPlatform dialogPlatform,
  }) {
    _dialogCompleter = Completer<DialogResponse>();

    if (dialogPlatform != null) {
      _showDialog(
          title: title,
          description: description,
          cancelText: cancelText,
          confirmText: confirmText,
          dialogPlatform: dialogPlatform);
    } else {
      var _dialogType = GetPlatform.isAndroid
          ? DialogPlatform.Material
          : DialogPlatform.Cupertino;
      _showDialog(
          title: title,
          description: description,
          cancelText: cancelText,
          confirmText: confirmText,
          dialogPlatform: _dialogType);
    }

    return _dialogCompleter.future;
  }

  Future _showDialog({
    String title,
    String description,
    String cancelText,
    String confirmText,
    DialogPlatform dialogPlatform,
  }) {
    var isConfirmationDialog = cancelText != null;
    return Get.dialog(
      PlatformDialog(
        dialogPlatform: dialogPlatform,
        title: title,
        content: description,
        actions: <Widget>[
          if (isConfirmationDialog)
            PlatformButton(
              dialogPlatform: dialogPlatform,
              text: cancelText,
              isCancelButton: true,
              onPressed: () {
                if (!_dialogCompleter.isCompleted)
                  completeDialog(
                    DialogResponse(
                      confirmed: false,
                    ),
                  );
              },
            ),
          PlatformButton(
            dialogPlatform: dialogPlatform,
            text: confirmText,
            onPressed: () {
              if (!_dialogCompleter.isCompleted)
                completeDialog(
                  DialogResponse(
                    confirmed: true,
                  ),
                );
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  /// Shows a confirmation dialog with title and description
  Future<DialogResponse> showConfirmationDialog({
    String title,
    String description,
    String cancelText = 'Cancel',
    String confirmText = 'Ok',

    /// Indicates which [DialogPlatform] to show.
    ///
    /// When not set a Platform specific dialog will be shown
    DialogPlatform dialogPlatform,
  }) {
    _dialogCompleter = Completer<DialogResponse>();

    showDialog(
      title: title,
      description: description,
      confirmText: confirmText,
      cancelText: cancelText,
      dialogPlatform: dialogPlatform,
    );

    return _dialogCompleter.future;
  }

  /// Completes the dialog and passes the [response] to the caller
  void completeDialog(DialogResponse response) {
    Get.back();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}

/// The response returned from awaiting a call on the [DialogService]
class DialogResponse {
  /// Indicates if a [showConfirmationDialog] has been confirmed or rejected.
  /// null will be returned when it's not a confirmation dialog.
  final bool confirmed;

  /// A place to put any response data from dialogs that may contain text fields
  /// or multi selection options
  final List<String> responseData;

  DialogResponse({
    this.confirmed,
    this.responseData,
  });
}
