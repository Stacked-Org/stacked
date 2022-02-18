import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../stacked_services.dart';

/// Stores the configuration for the visual appearance of a snackbar
class SnackbarConfig {
  Widget? titleText;
  Widget? messageText;
  Widget? icon;

  /// with instantInit = false you can put Get.snackbar on initState
  bool instantInit;
  bool shouldIconPulse;
  double? maxWidth;
  EdgeInsets? margin;
  EdgeInsets padding;
  double borderRadius;
  Color? borderColor;
  double borderWidth;
  Color backgroundColor;
  Color? leftBarIndicatorColor;

  /// Sets the color of the title text regardless of [textColor]
  Color? titleColor;

  /// Defines a custom style for the title shown in [showCustomSnackbar].
  TextStyle? titleTextStyle;

  /// Sets the color of all the test
  Color textColor;

  /// Sets the color of the message text regardless of [textColor]
  Color? messageColor;

  /// Sets a custom style for the message shown in [showCustomSnackbar].
  TextStyle? messageTextStyle;

  /// Sets the color of the main button text regardless of [textColor]
  Color? mainButtonTextColor;

  List<BoxShadow>? boxShadows;
  Gradient? backgroundGradient;
  bool isDismissible;
  bool showProgressIndicator;
  AnimationController? progressIndicatorController;
  Color? progressIndicatorBackgroundColor;
  Animation<Color>? progressIndicatorValueColor;
  SnackPosition snackPosition;
  SnackStyle snackStyle;
  Curve forwardAnimationCurve;
  Curve reverseAnimationCurve;
  Duration animationDuration;
  double barBlur;
  double overlayBlur;
  Color overlayColor;
  Form? userInputForm;
  TextAlign titleTextAlign;
  TextAlign messageTextAlign;
  DismissDirection dismissDirection;

  SnackbarConfig({
    this.titleText,
    this.messageText,
    this.icon,
    this.textColor = Colors.white,
    this.titleColor,
    this.titleTextStyle,
    this.messageColor,
    this.messageTextStyle,
    this.mainButtonTextColor,
    this.instantInit = false,
    this.shouldIconPulse = true,
    this.maxWidth,
    this.margin,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 0.0,
    this.borderColor,
    this.borderWidth = 1.0,
    this.backgroundColor = const Color(0xFF303030),
    this.leftBarIndicatorColor,
    this.boxShadows,
    this.backgroundGradient,
    this.isDismissible = true,
    this.dismissDirection = DismissDirection.vertical,
    this.showProgressIndicator = false,
    this.progressIndicatorController,
    this.progressIndicatorBackgroundColor,
    this.progressIndicatorValueColor,
    this.snackPosition = SnackPosition.BOTTOM,
    this.snackStyle = SnackStyle.FLOATING,
    this.forwardAnimationCurve = Curves.easeOutCirc,
    this.reverseAnimationCurve = Curves.easeOutCirc,
    this.animationDuration = const Duration(seconds: 1),
    this.barBlur = 0.0,
    this.overlayBlur = 0.0,
    this.overlayColor = Colors.transparent,
    this.userInputForm,
    this.titleTextAlign = TextAlign.left,
    this.messageTextAlign = TextAlign.left,
  });
}
