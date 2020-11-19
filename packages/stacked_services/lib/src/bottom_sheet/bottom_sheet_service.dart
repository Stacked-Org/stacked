import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_sheet_ui.dart';

/// A service that allows you to show a bottom sheet
class BottomSheetService {
  Completer<SheetResponse> _sheetCompleter;

  Future<SheetResponse> showBottomSheet({
    @required String title,
    String description,
    String confirmButtonTitle = 'Ok',
    String cancelButtonTitle,
  }) {
    _sheetCompleter = Completer<SheetResponse>();

    Get.bottomSheet(
        Material(
          type: MaterialType.transparency,
          child: GeneralBottomSheet(
            title: title,
            description: description ?? '',
            confirmButtonTitle: confirmButtonTitle,
            cancelButtonTitle: cancelButtonTitle,
          ),
        ),
        backgroundColor: Theme.of(Get.context).brightness == Brightness.light
            ? Colors.white
            : Colors.grey[800]);

    return _sheetCompleter.future;
  }

  /// Completes the dialog and passes the [response] to the caller
  void completeSheet(SheetResponse response) {
    Get.back();
    _sheetCompleter.complete(response);
    _sheetCompleter = null;
  }
}

class SheetResponse {
  /// Indicates if a show confirmation call has been confirmed or rejected.
  /// null will be returned when it's not a confirmation dialog.
  final bool confirmed;

  /// A place to put any response data from dialogs that may contain text fields
  /// or multi selection options
  final dynamic responseData;

  SheetResponse({
    this.confirmed,
    this.responseData,
  });
}
