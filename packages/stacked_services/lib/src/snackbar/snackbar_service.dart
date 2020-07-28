import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked_services/src/exceptions/custom_snackbar_exception.dart';
import 'package:stacked_services/src/snackbar/snackbar_config.dart';

/// A service that allows the user to show the snackbar from a ViewModel
class SnackbarService {
  get navigatorKey {
    return Get.key;
  }

  Map<dynamic, SnackbarConfig> _customSnackbarConfigs =
      Map<dynamic, SnackbarConfig>();

  SnackbarConfig _snackbarConfig;

  /// Saves the [config] to be used for the [showSnackbar] function
  void registerSnackbarConfig(SnackbarConfig config) =>
      _snackbarConfig = config;

  /// Saves the [config] against the value of [customData]
  void registerCustomSnackbarconfig({
    @required dynamic customData,
    @required SnackbarConfig config,
  }) =>
      _customSnackbarConfigs[customData] = config;

  /// Shows a snack bar with the details passed in
  void showSnackbar({
    String title,
    @required String message,
    Function(dynamic) onTap,
    Duration duration = const Duration(seconds: 3),
    String mainButtonTitle,
    Function onMainButtonTapped,
  }) {
    final mainButtonWidget = _getMainButtonWidget(
      mainButtonTitle: mainButtonTitle,
      onMainButtonTapped: onMainButtonTapped,
      config: _snackbarConfig,
    );

    Get.snackbar(
      title,
      message,
      titleText: _snackbarConfig?.titleColor != null
          ? Text(
              title,
              style: TextStyle(
                  color: _snackbarConfig.titleColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            )
          : null,
      messageText: _snackbarConfig?.messageColor != null
          ? Text(
              message,
              style: TextStyle(
                  color: _snackbarConfig.messageColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
            )
          : null,
      colorText: _snackbarConfig?.textColor ?? Colors.white,
      shouldIconPulse: _snackbarConfig?.shouldIconPulse,
      onTap: onTap,
      barBlur: _snackbarConfig?.barBlur,
      isDismissible: _snackbarConfig?.isDismissible ?? true,
      duration: duration,
      snackPosition: _snackbarConfig?.snackPosition ?? SnackPosition.BOTTOM,
      backgroundColor: _snackbarConfig?.backgroundColor ?? Colors.grey[800],
      margin: _snackbarConfig?.margin ??
          const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      mainButton: mainButtonWidget,
    );
  }

  Future showCustomSnackBar({
    @required String message,
    @required dynamic customData,
    String title,
    String mainButtonTitle,
    Function onMainButtonTapped,
    Function onTap,
    Duration duration = const Duration(seconds: 1),
  }) {
    var snackbarConfig = _customSnackbarConfigs[customData];
    if (snackbarConfig == null) {
      throw CustomSnackbarException(
          'No config found for $customData make sure you have called registerCustomConfig. See [README LINK HERE] for implementation details.');
    }

    final mainButtonWidget = _getMainButtonWidget(
      mainButtonTitle: mainButtonTitle,
      onMainButtonTapped: onMainButtonTapped,
      config: snackbarConfig,
    );

    final getBar = GetBar(
      title: title,
      message: message,
      titleText: snackbarConfig.titleText,
      messageText: snackbarConfig.messageText,
      icon: snackbarConfig.icon,
      shouldIconPulse: snackbarConfig.shouldIconPulse,
      maxWidth: snackbarConfig.maxWidth,
      margin: snackbarConfig.margin,
      padding: snackbarConfig.padding,
      borderRadius: snackbarConfig.borderRadius,
      borderColor: snackbarConfig.borderColor,
      borderWidth: snackbarConfig.borderWidth,
      backgroundColor: snackbarConfig.backgroundColor,
      leftBarIndicatorColor: snackbarConfig.leftBarIndicatorColor,
      boxShadows: snackbarConfig.boxShadows,
      backgroundGradient: snackbarConfig.backgroundGradient,
      mainButton: mainButtonWidget,
      onTap: onTap,
      duration: duration,
      isDismissible: snackbarConfig.isDismissible,
      dismissDirection: snackbarConfig.dismissDirection,
      showProgressIndicator: snackbarConfig.showProgressIndicator,
      progressIndicatorController: snackbarConfig.progressIndicatorController,
      progressIndicatorBackgroundColor:
          snackbarConfig.progressIndicatorBackgroundColor,
      progressIndicatorValueColor: snackbarConfig.progressIndicatorValueColor,
      snackPosition: snackbarConfig.snackPosition,
      snackStyle: snackbarConfig.snackStyle,
      forwardAnimationCurve: snackbarConfig.forwardAnimationCurve,
      reverseAnimationCurve: snackbarConfig.reverseAnimationCurve,
      animationDuration: snackbarConfig.animationDuration,
      onStatusChanged: snackbarConfig.onStatusChanged,
      barBlur: snackbarConfig.barBlur,
      overlayBlur: snackbarConfig.overlayBlur,
      overlayColor: snackbarConfig.overlayColor,
      userInputForm: snackbarConfig.userInputForm,
    );

    if (snackbarConfig.instantInit) {
      return getBar.show();
    } else {
      Completer completer = new Completer();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final result = await getBar.show();
        completer.complete(result);
      });
      return completer.future;
    }
  }

  Widget _getMainButtonWidget({
    String mainButtonTitle,
    Function onMainButtonTapped,
    SnackbarConfig config,
  }) {
    return mainButtonTitle != null
        ? FlatButton(
            child: Text(
              mainButtonTitle,
              style: TextStyle(
                  color: config?.mainButtonTextColor ??
                      config?.textColor ??
                      Colors.white),
            ),
            onPressed: onMainButtonTapped,
          )
        : null;
  }
}
