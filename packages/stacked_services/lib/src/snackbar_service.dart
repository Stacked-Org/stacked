import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// A service that allows the user to show the snackbar from a ViewModel
@lazySingleton
class SnackbarService {
  /// Shows a snack bar with the details passed in
  void showSnackbar({
    String title,
    String message,
    IconData iconData,
    Function onTap,
    bool shouldIconPulse = false,
    double barBlur = 0,
    bool isDissmissible = true,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title, // title
      message, // message
      icon: Icon(iconData),
      shouldIconPulse: shouldIconPulse,
      onTap: onTap,
      barBlur: barBlur,
      isDismissible: isDissmissible,
      duration: duration,
    );
  }

  // TODO: I don't want UI code in the viewmodels so we will allow users to register UI builders that they can show
  // using a custom key.
  /// Allows you to build a custom snack bar
  Future showCustomSnackBar(
      {Key key,
      String title,
      String message,
      Widget titleText,
      Widget messageText,
      Widget icon,
      bool shouldIconPulse = true,
      double maxWidth,
      EdgeInsets margin = const EdgeInsets.all(0.0),
      EdgeInsets padding = const EdgeInsets.all(16),
      double borderRadius = 0.0,
      Color borderColor,
      double borderWidth = 1.0,
      Color backgroundColor = const Color(0xFF303030),
      Color leftBarIndicatorColor,
      List<BoxShadow> boxShadows,
      Gradient backgroundGradient,
      FlatButton mainButton,
      OnTap onTap,
      Duration duration,
      bool isDismissible = true,
      SnackDismissDirection dismissDirection = SnackDismissDirection.VERTICAL,
      bool showProgressIndicator = false,
      AnimationController progressIndicatorController,
      Color progressIndicatorBackgroundColor,
      Animation<Color> progressIndicatorValueColor,
      SnackPosition snackPosition = SnackPosition.BOTTOM,
      SnackStyle snackStyle = SnackStyle.FLOATING,
      Curve forwardAnimationCurve = Curves.easeOutCirc,
      Curve reverseAnimationCurve = Curves.easeOutCirc,
      Duration animationDuration = const Duration(seconds: 1),
      SnackStatusCallback onStatusChanged,
      double barBlur = 0.0,
      double overlayBlur = 0.0,
      Color overlayColor = Colors.transparent,
      Form userInputForm}) {
    return GetBar(
            key: key,
            title: title,
            message: message,
            titleText: titleText,
            messageText: messageText,
            icon: icon,
            shouldIconPulse: shouldIconPulse,
            maxWidth: maxWidth,
            margin: margin,
            padding: padding,
            borderRadius: borderRadius,
            borderColor: borderColor,
            borderWidth: borderWidth,
            backgroundColor: backgroundColor,
            leftBarIndicatorColor: leftBarIndicatorColor,
            boxShadows: boxShadows,
            backgroundGradient: backgroundGradient,
            mainButton: mainButton,
            onTap: onTap,
            duration: duration,
            isDismissible: isDismissible,
            dismissDirection: dismissDirection,
            showProgressIndicator: showProgressIndicator,
            progressIndicatorController: progressIndicatorController,
            progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
            progressIndicatorValueColor: progressIndicatorValueColor,
            snackPosition: snackPosition,
            snackStyle: snackStyle,
            forwardAnimationCurve: forwardAnimationCurve,
            reverseAnimationCurve: reverseAnimationCurve,
            animationDuration: animationDuration,
            onStatusChanged: onStatusChanged,
            barBlur: barBlur,
            overlayBlur: overlayBlur,
            overlayColor: overlayColor,
            userInputForm: userInputForm)
        .show();
  }
}
