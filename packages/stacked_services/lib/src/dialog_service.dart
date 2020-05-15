import 'dart:io' show Platform;
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

enum PlatformDesignType {
  Cupertino,
  Material,
}

/// A DialogService that uses the Get package to show dialogs
@lazySingleton
class DialogService {
  Completer<DialogResponse> _dialogCompleter;

  // TODO: Create a dialog UI registration factory that will allow users to register
  // dialogs to be built along with keys. the user should then be able to show the dialog
  // using that key.

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  /// if you want it to be a confirmation dialog then you can set `isConfirmationDialog` to `true`
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String cancelText,
    String confirmText = 'Ok',

    /// ignored when `showDialogForPlatform` is `true`
    /// you must change `showDialogForPlatform` to `false` to use this property
    /// providing nothing in here and setting the `showDialogForPlatform` to `false`
    /// will result in using material desing all the time
    PlatformDesignType platformDesignType,

    /// setting to `false` will not ignore `platform` :)
    /// default is `true` which ignores `platform` :)
    bool showDialogForPlatform = true,
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    var isConfirmationDialog = cancelText != null;

    /// Dialog Design For Android (Material)
    _materialDesignDialog() {
      return Get.dialog(
        AlertDialog(
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
          contentTextStyle: TextStyle(
            color: Colors.black,
          ),
          title: Text(
            title,
          ),
          content: Text(
            description,
          ),
          actions: <Widget>[
            if (isConfirmationDialog)
              FlatButton(
                child: Text(
                  cancelText,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  if (!_dialogCompleter.isCompleted)
                    completeDialog(
                      DialogResponse(
                        confirmed: false,
                      ),
                    );
                },
              ),
            FlatButton(
              child: Text(
                confirmText,
                style: TextStyle(),
              ),
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

    /// Dialog Design For iOS (Cupertino)
    _cupertinoDesignDialog() {
      return Get.dialog(
        CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            description,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            if (isConfirmationDialog)
              CupertinoButton(
                child: Text(
                  cancelText,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  if (!_dialogCompleter.isCompleted)
                    completeDialog(
                      DialogResponse(
                        confirmed: false,
                      ),
                    );
                },
              ),
            CupertinoButton(
              child: Text(
                confirmText,
                style: TextStyle(),
              ),
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

    /// Logic for deciding which design to use :)
    if (showDialogForPlatform) {
      if (Platform.isAndroid) {
        _materialDesignDialog();
        return _dialogCompleter.future;
      } else if (Platform.isIOS) {
        _cupertinoDesignDialog();
        return _dialogCompleter.future;
      }
    }
    switch (platformDesignType) {
      case PlatformDesignType.Material:
        _materialDesignDialog();
        return _dialogCompleter.future;
        break;
      case PlatformDesignType.Cupertino:
        _cupertinoDesignDialog();
        return _dialogCompleter.future;
        break;
      default:
        _materialDesignDialog();
        return _dialogCompleter.future;
        break;
    }
  }

  /// Shows a confirmation dialog with title and description
  Future<DialogResponse> showConfirmationDialog({
    String title,
    String description,
    String cancelText = 'Cancel',
    String confirmText = 'Ok',

    /// ignored when `showDialogForPlatform` is `true`
    /// you must change `showDialogForPlatform` to `false` to use this property
    /// providing nothing in here and setting the `showDialogForPlatform` to `false`
    /// will result in using material desing all the time
    PlatformDesignType platformDesignType,

    /// setting to `false` will not ignore `platform` :)
    /// default is `true` which ignores `platform` :)
    bool showDialogForPlatform = true,
  }) {
    _dialogCompleter = Completer<DialogResponse>();

    showDialog(
      title: title,
      description: description,
      confirmText: confirmText,
      cancelText: cancelText,
      platformDesignType: platformDesignType,
      showDialogForPlatform: showDialogForPlatform,
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
