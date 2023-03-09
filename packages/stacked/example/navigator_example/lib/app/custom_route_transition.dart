import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CustomRouteTransition {
  static Widget sharedAxis(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.scaled,
      child: child,
    );
  }
}
