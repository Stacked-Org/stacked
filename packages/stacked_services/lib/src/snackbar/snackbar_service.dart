import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked_services/src/exceptions/custom_snackbar_exception.dart';
import 'package:stacked_services/src/snackbar/snackbar_config.dart';

/// A service that allows the user to show the snackbar from a ViewModel
class SnackbarService {
  @Deprecated(
      'Prefer to use the StackedServices.navigatorKey instead of using this key. This will be removed in the next major version update for stacked.')
  get navigatorKey {
    return Get.key;
  }

  Map<dynamic, SnackbarConfig?> _customSnackbarConfigs =
      Map<dynamic, SnackbarConfig?>();

  Map<dynamic, SnackbarConfig Function()?> _customSnackbarConfigBuilders =
      Map<dynamic, SnackbarConfig Function()?>();

  Map<dynamic, Widget Function(String?, Function?)?> _mainButtonBuilder =
      Map<dynamic, Widget Function(String?, Function?)?>();

  SnackbarConfig? _snackbarConfig;

  /// Checks if there is a snackbar open
  bool? get isOpen => Get.isSnackbarOpen;

  /// Saves the [config] to be used for the [showSnackbar] function
  void registerSnackbarConfig(SnackbarConfig config) =>
      _snackbarConfig = config;

  /// Saves the [config] against the value of [customData]
  @Deprecated(
      'Prefer to use the registerCustomSnackbarConfig() method. Will be removed in future release')
  void registerCustomSnackbarconfig({
    @required dynamic customData,
    @required SnackbarConfig? config,
  }) =>
      registerCustomSnackbarConfig(
        variant: customData,
        config: config,
      );

  /// Registers a builder that will be used when showing a matching variant value. The builder
  /// function takes in a [String] to display as the title and a `Function` to be used to the
  /// onTap callback
  void registerCustomMainButtonBuilder({
    @required dynamic variant,
    @required Widget Function(String?, Function?)? builder,
  }) =>
      _mainButtonBuilder[variant] = builder;

  /// Saves the [config] against the value of [variant]. A [configBuilder] can also be
  /// supplied which will be chosen over the config for the same variant when requested.
  void registerCustomSnackbarConfig({
    required dynamic variant,
    SnackbarConfig? config,
    SnackbarConfig Function()? configBuilder,
  }) {
    _customSnackbarConfigs[variant] = config;
    _customSnackbarConfigBuilders[variant] = configBuilder;
  }

  /// Check if snackbar is open
  bool? get isSnackbarOpen => Get.isSnackbarOpen;

  /// Shows a snack bar with the details passed in
  void showSnackbar({
    String title = '',
    required String message,
    Function(dynamic)? onTap,
    Duration duration = const Duration(seconds: 3),
    String? mainButtonTitle,
    void Function()? onMainButtonTapped,
  }) {
    final mainButtonWidget = _getMainButtonWidget(
      mainButtonTitle: mainButtonTitle,
      onMainButtonTapped: onMainButtonTapped,
      config: _snackbarConfig,
    );

    Get.snackbar(
      title,
      message,
      titleText: _snackbarConfig?.titleColor != null || title.isNotEmpty
          ? Text(
              title,
              key: Key('snackbar_text_title'),
              style: TextStyle(
                color: _snackbarConfig?.titleColor,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
              textAlign: _snackbarConfig?.titleTextAlign ?? TextAlign.left,
            )
          : SizedBox.shrink(),
      messageText: _snackbarConfig?.messageColor != null || message.isNotEmpty
          ? Text(
              message,
              key: Key('snackbar_text_message'),
              style: TextStyle(
                color: _snackbarConfig?.messageColor,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
              textAlign: _snackbarConfig?.messageTextAlign ?? TextAlign.left,
            )
          : SizedBox.shrink(),
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

  Future? showCustomSnackBar({
    required String message,
    @deprecated dynamic customData,
    dynamic variant,
    String? title,
    String? mainButtonTitle,
    void Function()? onMainButtonTapped,
    Function? onTap,
    Duration duration = const Duration(seconds: 1),
  }) async {
    // TODO: Remove customData in the future release and set variant as required
    final snackbarVariant = variant ?? customData;
    assert(
      snackbarVariant != null,
      'No variant defined, you should provide the variant property to show a custom snackbar',
    );

    final snackbarConfigSupplied = _customSnackbarConfigs[snackbarVariant];
    final snackbarConfigBuilder =
        _customSnackbarConfigBuilders[snackbarVariant];

    final snackbarConfig = snackbarConfigBuilder != null
        ? snackbarConfigBuilder()
        : snackbarConfigSupplied;

    if (snackbarConfig == null) {
      throw CustomSnackbarException(
        'No config found for $snackbarVariant make sure you have called registerCustomConfig with a config or a builder. See [https://pub.dev/packages/stacked_services#custom-styles] for implementation details.',
      );
    }

    final mainButtonBuilder = _mainButtonBuilder[variant];
    final hasMainButtonBuilder = mainButtonBuilder != null;

    final mainButtonWidget = hasMainButtonBuilder
        ? mainButtonBuilder!(mainButtonTitle, onMainButtonTapped)
        : _getMainButtonWidget(
            mainButtonTitle: mainButtonTitle,
            onMainButtonTapped: onMainButtonTapped,
            config: snackbarConfig,
          );

    final getBar = GetSnackBar(
      key: Key('snackbar_view'),
      titleText: title != null
          ? Text(
              title,
              key: Key('snackbar_text_title'),
              style: snackbarConfig.titleTextStyle ?? TextStyle(
                color: snackbarConfig.titleColor ?? snackbarConfig.textColor,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
              textAlign: snackbarConfig.titleTextAlign,
            )
          : null,
      messageText: Text(
        message,
        key: Key('snackbar_text_message'),
        style: snackbarConfig.messageTextStyle ?? TextStyle(
          color: snackbarConfig.messageColor ?? snackbarConfig.textColor,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        textAlign: snackbarConfig.messageTextAlign,
      ),
      icon: snackbarConfig.icon,
      shouldIconPulse: snackbarConfig.shouldIconPulse,
      maxWidth: snackbarConfig.maxWidth,
      margin: snackbarConfig.margin ?? EdgeInsets.zero,
      padding: snackbarConfig.padding,
      borderRadius: snackbarConfig.borderRadius,
      borderColor: snackbarConfig.borderColor,
      borderWidth: snackbarConfig.borderWidth,
      backgroundColor: snackbarConfig.backgroundColor,
      leftBarIndicatorColor: snackbarConfig.leftBarIndicatorColor,
      boxShadows: snackbarConfig.boxShadows,
      backgroundGradient: snackbarConfig.backgroundGradient,
      mainButton: mainButtonWidget,
      onTap: (object) => onTap!(),
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
      barBlur: snackbarConfig.barBlur,
      overlayBlur: snackbarConfig.overlayBlur,
      overlayColor: snackbarConfig.overlayColor,
      userInputForm: snackbarConfig.userInputForm,
    );

    if (snackbarConfig.instantInit) {
      return getBar.show();
    } else {
      Completer completer = new Completer();
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        final result = await getBar.show();
        completer.complete(result);
      });
      return completer.future;
    }
  }

  TextButton? _getMainButtonWidget({
    String? mainButtonTitle,
    void Function()? onMainButtonTapped,
    SnackbarConfig? config,
  }) {
    if (mainButtonTitle == null) {
      return null;
    }

    return TextButton(
      key: Key('snackbar_touchable_mainButton'),
      child: Text(
        mainButtonTitle,
        key: Key('snackbar_text_mainButtonTitle'),
        style: TextStyle(
          color:
              config?.mainButtonTextColor ?? config?.textColor ?? Colors.white,
        ),
      ),
      onPressed: onMainButtonTapped,
    );
  }
}
