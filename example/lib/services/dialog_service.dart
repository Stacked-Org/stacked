import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DialogService {
  Completer<DialogResponse> _dialogCompleter;

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String cancelTitle,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    var isConfirmationDialog = cancelTitle != null;

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

  /// Shows a confirmation dialog
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

  /// Completes the _dialogCompleter and returns the awaited future from the DialogCompleter
  void completeDialog(DialogResponse response) {
    Get.back();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}

class DialogResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}
