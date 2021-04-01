/// This class contains all the bottom sheet UI's used in the bottom sheet

import 'package:flutter/material.dart';
import 'package:stacked_services/src/bottom_sheet/responsive_reducers.dart';

class GeneralBottomSheet extends StatelessWidget {
  final String title;
  final String? description;
  final String confirmButtonTitle;
  final String? cancelButtonTitle;
  final void Function() onConfirmTapped;
  final void Function()? onCancelTapped;
  final double sidePadding;
  const GeneralBottomSheet({
    Key? key,
    required this.title,
    required this.confirmButtonTitle,
    required this.onConfirmTapped,
    this.description,
    this.cancelButtonTitle,
    this.onCancelTapped,
    this.sidePadding = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(sidePadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (description != null) verticalSpaceSmall,
          if (description != null)
            Text(
              description!,
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          verticalSpaceMedium,
          FullScreenButton(
            title: confirmButtonTitle,
            onPressed: onConfirmTapped,
          ),
          verticalSpaceTiny,
          if (cancelButtonTitle != null)
            FullScreenButton(
              title: cancelButtonTitle!,
              onPressed: onCancelTapped,
              color: Colors.white,
              textColor: Theme.of(context).primaryColor,
            ),
        ],
      ),
    );
  }
}

class FullScreenButton extends StatelessWidget {
  final double horizontalPadding;
  final Color? color;
  final Color textColor;
  final bool busy;
  final String title;
  final bool outline;
  final void Function()? onPressed;
  final bool enabled;
  final bool hasDropShadow;

  /// Height of the button. Default value is [screenHeightFraction(context, dividedBy: 18)]
  final double? height;

  static BorderRadius _borderRadius = BorderRadius.circular(8);

  FullScreenButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.horizontalPadding = 25,
    this.height,
    this.color,
    this.textColor = Colors.white,
    this.busy = false,
    this.outline = false,
    this.enabled = true,
    this.hasDropShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        height: height ?? screenHeightFraction(context, dividedBy: 15),
        width: screenWidthFraction(context, offsetBy: horizontalPadding * 2),
        decoration: outline
            ? BoxDecoration(
                border: Border.all(
                  color: enabled
                      ? (color ?? Theme.of(context).primaryColor)
                      : Colors.grey[350]!,
                  width: 1,
                ),
                borderRadius: _borderRadius,
              )
            : BoxDecoration(
                color: enabled
                    ? (color ?? Theme.of(context).primaryColor)
                    : Colors.grey[350],
                borderRadius: _borderRadius,
                boxShadow: [
                    if (hasDropShadow)
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                      )
                  ]),
        child: busy
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(!enabled
                    ? Colors.grey[350]
                    : outline
                        ? color
                        : textColor),
              )
            : Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: !enabled
                      ? Colors.grey[350]
                      : outline
                          ? (color ?? Theme.of(context).primaryColor)
                          : textColor,
                ),
              ),
      ),
    );
  }
}
