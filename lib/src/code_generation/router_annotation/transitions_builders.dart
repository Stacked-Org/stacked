// a class that holds a preset of
// common route transition builder
import 'package:flutter/material.dart';

class TransitionsBuilders {
  static const RouteTransitionsBuilder slideRight = _slideRight;

  static Widget _slideRight(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static const RouteTransitionsBuilder slideLeft = _slideLeft;

  static Widget _slideLeft(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static const RouteTransitionsBuilder slideRightWithFade = _slideRightWithFade;

  static Widget _slideRightWithFade(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  static const RouteTransitionsBuilder slideLeftWithFade = _slideLeftWithFade;

  static Widget _slideLeftWithFade(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  static const RouteTransitionsBuilder slideTop = _slideTop;

  static Widget _slideTop(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static const RouteTransitionsBuilder slideBottom = _slideBottom;

  static Widget _slideBottom(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static const RouteTransitionsBuilder fadeIn = _fadeIn;

  static Widget _fadeIn(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  static const RouteTransitionsBuilder zoomIn = _zoomIn;

  static Widget _zoomIn(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(scale: animation, child: child);
  }

  static const RouteTransitionsBuilder noTransition = _noTransition;

  static Widget _noTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  static const RouteTransitionsBuilder moveInLeft = _moveInLeft;

  static Widget _moveInLeft(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    Tween<Offset> t1 = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    );
    Tween<Offset> t5 = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-1.0, 0.0),
    );
    return SlideTransition(
      position: t1.animate(animation),
      child: SlideTransition(
        position: t5.animate(secondaryAnimation),
        child: child,
      ),
    );
  }
}
