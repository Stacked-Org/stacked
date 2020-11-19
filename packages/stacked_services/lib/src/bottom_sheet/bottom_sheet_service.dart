import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked_services/src/models/overlay_response.dart';

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
          onConfirmTapped: () => completeSheet(SheetResponse(confirmed: true)),
          onCancelTapped: () => completeSheet(SheetResponse(confirmed: false)),
        ),
      ),
      backgroundColor: Theme.of(Get.context).brightness == Brightness.light
          ? Colors.white
          : Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );

    return _sheetCompleter.future;
  }

  /// Completes the dialog and passes the [response] to the caller
  void completeSheet(SheetResponse response) {
    Get.back();
    _sheetCompleter.complete(response);
    _sheetCompleter = null;
  }
}
