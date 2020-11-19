import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked_services/src/dialog/platform_dialog.dart';
import 'package:stacked_services/src/models/overlay_request.dart';
import 'package:stacked_services/src/models/overlay_response.dart';

enum DialogPlatform {
  Cupertino,
  Material,
  Custom,
}

/// A DialogService that uses the Get package to show dialogs
class DialogService {
  Completer<DialogResponse> _dialogCompleter;

  Map<dynamic, Widget Function(BuildContext, DialogRequest)>
      _customDialogBuilders =
      Map<dynamic, Widget Function(BuildContext, DialogRequest)>();

  @Deprecated(
    'Prefer to use the _customDialogBuilders property. Will be removed in future release',
  )
  Widget Function(BuildContext, DialogRequest) _customDialogUI;

  get navigatorKey {
    return Get.key;
  }

  @Deprecated(
    'Prefer to use the registerCustomDialogBuilder() method. Will be removed in future release',
  )
  void registerCustomDialogUi(
    Widget Function(BuildContext, DialogRequest) dialogBuilder,
  ) {
    _customDialogUI = dialogBuilder;
  }

  void registerCustomDialogBuilder({
    @required dynamic variant,
    @required Widget Function(BuildContext, DialogRequest) builder,
  }) {
    _customDialogBuilders[variant] = builder;
  }

  // TODO: Create a dialog UI registration factory that will allow users to register
  // dialogs to be built along with keys. the user should then be able to show the dialog
  // using that key.

  /// Shows a dialog to the user
  ///
  /// It will show a platform specific dialog by default. This can be changed by setting [dialogPlatform]
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String cancelTitle,
    String buttonTitle = 'Ok',
    bool barrierDismissible = false,

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
        cancelTitle: cancelTitle,
        buttonTitle: buttonTitle,
        dialogPlatform: dialogPlatform,
        barrierDismissible: barrierDismissible,
      ).then((_) => _dialogCompleter?.complete());
    } else {
      var _dialogType = GetPlatform.isAndroid
          ? DialogPlatform.Material
          : DialogPlatform.Cupertino;
      _showDialog(
        title: title,
        description: description,
        cancelTitle: cancelTitle,
        buttonTitle: buttonTitle,
        dialogPlatform: _dialogType,
        barrierDismissible: barrierDismissible,
      ).then((_) => _dialogCompleter?.complete());
    }

    return _dialogCompleter.future;
  }

  Future _showDialog({
    String title,
    String description,
    String cancelTitle,
    String buttonTitle,
    DialogPlatform dialogPlatform,
    bool barrierDismissible = false,
  }) {
    var isConfirmationDialog = cancelTitle != null;
    return Get.dialog(
      PlatformDialog(
        dialogPlatform: dialogPlatform,
        title: title,
        content: description,
        actions: <Widget>[
          if (isConfirmationDialog)
            PlatformButton(
              dialogPlatform: dialogPlatform,
              text: cancelTitle,
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
            text: buttonTitle,
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
      barrierDismissible: barrierDismissible,
    );
  }

  // Creates a popup with the given widget, a scale animation, and faded background.
  Future<DialogResponse> showCustomDialog({
    dynamic variant,
    String title,
    String description,
    bool hasImage = false,
    String imageUrl,
    bool showIconInMainButton = false,
    String mainButtonTitle,
    bool showIconInSecondaryButton = false,
    String secondaryButtonTitle,
    bool showIconInAdditionalButton = false,
    String additionalButtonTitle,
    bool takesInput = false,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = false,
    String barrierLabel = '',
    dynamic customData,
  }) {
    // TODO: Remove the _customDialogUI in the next release
    final customDialogUI =
        variant != null ? _customDialogBuilders[variant] : _customDialogUI;

    assert(
      customDialogUI != null,
      'You have to call registerCustomDialogBuilder to use this function. Look at the custom dialog UI section in the stacked_services readme.',
    );

    _dialogCompleter = Completer<DialogResponse>();

    Get.generalDialog(
      barrierColor: barrierColor,
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useRootNavigator: true,
      pageBuilder: (BuildContext buildContext, _, __) => SafeArea(
        child: Builder(
          builder: (BuildContext context) => customDialogUI(
            context,
            DialogRequest(
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
            ),
          ),
        ),
      ),
      // TODO: Add configurable transition builders to set  from the outside as well
      // transitionBuilder: (context, animation, _, child) {
      //   return ScaleTransition(
      //     scale: CurvedAnimation(
      //       parent: animation,
      //       curve: Curves.decelerate,
      //     ),
      //     child: child,
      //   );
      // },
    ).then((_) => _dialogCompleter?.complete());

    return _dialogCompleter.future;
  }

  /// Shows a confirmation dialog with title and description
  Future<DialogResponse> showConfirmationDialog({
    String title,
    String description,
    String cancelTitle = 'Cancel',
    String confirmationTitle = 'Ok',
    bool barrierDismissible = false,

    /// Indicates which [DialogPlatform] to show.
    ///
    /// When not set a Platform specific dialog will be shown
    DialogPlatform dialogPlatform,
  }) =>
      showDialog(
        title: title,
        description: description,
        buttonTitle: confirmationTitle,
        cancelTitle: cancelTitle,
        dialogPlatform: dialogPlatform,
        barrierDismissible: barrierDismissible,
      );

  /// Completes the dialog and passes the [response] to the caller
  void completeDialog(DialogResponse response) {
    Get.back();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}



