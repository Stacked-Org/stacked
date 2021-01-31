import 'dart:math';

import 'package:flutter/material.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceRegular = SizedBox(width: 18.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

const double VerticalMediumSpacingAmount = 25;

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceRegular = SizedBox(height: 18.0);
const Widget verticalSpaceMedium =
    SizedBox(height: VerticalMediumSpacingAmount);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget responsiveVerticalSpace(BuildContext context, {int dividedBy}) =>
    verticalSpace(screenHeightFraction(
      context,
      dividedBy: dividedBy,
    ));

Widget responsiveVerticalSpaceSmall(BuildContext context) =>
    responsiveVerticalSpace(context, dividedBy: 40);

Widget verticalSpace(double height) => SizedBox(height: height);
Widget horizontalSpace(double height) => SizedBox(width: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context,
        {double percentageOf = 0}) =>
    screenHeight(context) * percentageOf;

double screenWidthPercentage(BuildContext context, {double percentageOf = 0}) =>
    screenWidth(context) * percentageOf;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

/// Returns a font size that simulates 12 on all devices with a max of 14
double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 12, max: 14);

/// Returns a font size that simulates 14 on all devices with a max of 16
double getResponsiveRegularFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 14, max: 16);

double getResponsiveFontSize(BuildContext context,
    {double fontSize, double max}) {
  if (max == null) {
    max = 100;
  }
  var responsiveSize =
      min(screenWidthFraction(context) * (fontSize / 100), max);

  return responsiveSize;
}

/// This section defines the 4 text sizes used in the app
