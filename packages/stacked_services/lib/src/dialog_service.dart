import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// A DialogService that uses the Get package to show dialogs
@lazySingleton
class DialogService {
  Completer<DialogResponse> _dialogCompleter;

  // TODO: Create a dialog UI registration factory that will allow users to register
  // dialogs to be built along with keys. the user should then be able to show the dialog
  // using that key and.

  // TODO: Allow the user to show cupertino or material dialogs.
  // - Add an enum for Material / Cupertino
  // - Add a flag for showDialogForPlatform that when true ignores the above enums

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String cancelTitle,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    var isConfirmationDialog = cancelTitle != null;

    // TODO: The dialog here should come from a dialog builder that will aid with the
    // configurable nature of the dialog service we intend to build.
    Get.dialog(
        AlertDialog(
            titleTextStyle: const TextStyle(color: Colors.black),
            contentTextStyle: const TextStyle(color: Colors.black),
            title: Text(title),
            content: Text(description),
            actions: <Widget>[
              if (isConfirmationDialog)
                FlatButton(
                  child: Text(cancelTitle),
                  onPressed: () {
                    if (!_dialogCompleter.isCompleted)
                      completeDialog(DialogResponse(confirmed: false));
                  },
                ),
              FlatButton(
                child: Text(buttonTitle),
                onPressed: () {
                  if (!_dialogCompleter.isCompleted)
                    completeDialog(DialogResponse(confirmed: true));
                },
              ),
            ]),
        barrierDismissible: false);
    return _dialogCompleter.future;
  }

  /// Shows a confirmation dialog with title and description
  Future<DialogResponse> showConfirmationDialog(
      {String title,
      String description,
      String confirmationTitle = 'Ok',
      String cancelTitle = 'Cancel'}) {
    _dialogCompleter = Completer<DialogResponse>();

    showDialog(
      title: title,
      description: description,
      buttonTitle: confirmationTitle,
      cancelTitle: cancelTitle,
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
  /// Indicates if a showConfirmationDialog has been confirmed or rejected.
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
