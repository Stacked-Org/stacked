import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked_services/src/models/overlay_request.dart';
import 'package:stacked_services/src/models/overlay_response.dart';

import 'bottom_sheet_ui.dart';

typedef SheetBuilder = Widget Function(
  BuildContext context,
  SheetRequest<dynamic> request,
  void Function(SheetResponse<dynamic> response) completer,
);

/// A service that allows you to show a bottom sheet
class BottomSheetService {
  Map<dynamic, SheetBuilder>? _sheetBuilders;

  void setCustomSheetBuilders(Map<dynamic, SheetBuilder> builders) {
    _sheetBuilders = builders;
  }

  Future<SheetResponse?> showBottomSheet({
    required String title,
    String? description,
    String confirmButtonTitle = 'Ok',
    String? cancelButtonTitle,
    bool enableDrag = true,
    bool barrierDismissible = true,
    bool isScrollControlled = false,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool useRootNavigator = false,
  }) {
    return Get.bottomSheet<SheetResponse?>(
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
      backgroundColor: Theme.of(Get.context!).brightness == Brightness.light
          ? Colors.white
          : Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isDismissible: barrierDismissible,
      isScrollControlled: isScrollControlled,
      enableDrag: barrierDismissible && enableDrag,
      exitBottomSheetDuration: exitBottomSheetDuration,
      enterBottomSheetDuration: enterBottomSheetDuration,
      ignoreSafeArea: ignoreSafeArea,
      settings: RouteSettings(
          name: 'general_${_hashConcateator([
            title,
            description,
          ])}'),
      useRootNavigator: useRootNavigator,
    );
  }

  /// Creates a popup with the given widget, a scale animation, and faded background.
  ///
  /// The first generic type argument will be the [BottomSheetResponse]
  /// while the second generic type argument is the [BottomSheetRequest]
  ///
  /// e.g.
  /// ```dart
  /// await _bottomSheetService.showCustomSheet<GenericBottomSheetResponse, GenericBottomSheetRequest>();
  /// ```
  ///
  /// Where [GenericBottomSheetResponse] is a defined model response,
  /// and [GenericBottomSheetRequest] is the request model.
  Future<SheetResponse<T>?> showCustomSheet<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool hasImage = false,
    String? imageUrl,
    bool showIconInMainButton = false,
    String? mainButtonTitle,
    bool showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool takesInput = false,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = true,
    bool isScrollControlled = false,
    String barrierLabel = '',
    @Deprecated('Use `data` and pass in a generic type.') dynamic customData,
    R? data,
    bool enableDrag = true,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool useRootNavigator = false,
  }) {
    assert(
      _sheetBuilders != null,
      '''
      There's no sheet builder supplied for the variant:$variant. If you haven't yet setup your
      custom builder. Please call the setCustomSheetBuilders function on the service and supply
      the UI that you'd like to build for each variant.

      If you have already done that. Make sure that the variant:$variant has a builder associated
      with it.
      ''',
    );

    final sheetBuilder = _sheetBuilders![variant];

    return Get.bottomSheet<SheetResponse<T>>(
      Material(
        type: MaterialType.transparency,
        child: sheetBuilder!(
          Get.context!,
          SheetRequest<R>(
            title: title,
            description: description,
            hasImage: hasImage,
            imageUrl: imageUrl,
            showIconInMainButton: showIconInMainButton,
            mainButtonTitle: mainButtonTitle,
            showIconInSecondaryButton: showIconInSecondaryButton,
            secondaryButtonTitle: secondaryButtonTitle,
            showIconInAdditionalButton: showIconInAdditionalButton,
            additionalButtonTitle: additionalButtonTitle,
            takesInput: takesInput,
            customData: customData,
            variant: variant,
            data: data,
          ),
          completeSheet,
        ),
      ),
      isDismissible: barrierDismissible,
      isScrollControlled: isScrollControlled,
      enableDrag: barrierDismissible && enableDrag,
      exitBottomSheetDuration: exitBottomSheetDuration,
      enterBottomSheetDuration: enterBottomSheetDuration,
      ignoreSafeArea: ignoreSafeArea,
      settings: RouteSettings(
          name: '$variant\_${_hashConcateator([
            title,
            description,
            mainButtonTitle,
            secondaryButtonTitle,
          ])}'),
      useRootNavigator: useRootNavigator,
    );
  }

  /// Check if bottomsheet is open
  bool? get isBottomSheetOpen => Get.isBottomSheetOpen;

  /// Completes the dialog and passes the [response] to the caller
  void completeSheet(SheetResponse response) {
    Get.back(result: response);
  }
}

String _hashConcateator(List<String?> objects) {
  return _generateMd5(objects.join(''));
}

String _generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
