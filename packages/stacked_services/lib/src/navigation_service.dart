import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

/// Provides a service that can be injected into the ViewModels for navigation.
///
/// Uses the Get library for all navigation requirements
@lazySingleton
class NavigationService {
  get navigatorKey => Get.key;

  /// Pushes [page] onto the navigation stack. This uses the [page] itself (Widget) instead
  /// of routeName (String).
  ///
  /// Defined [transition] values:
  /// - fade
  /// - rightToLeft
  /// - leftToRight
  /// - upToDown
  /// - downToUp
  /// - scale
  /// - rotate
  /// - size
  /// - rightToLeftWithFade
  /// - leftToRightWithFade
  /// - cupertino
  Future<dynamic> toPageWithTransition(Widget page,
      {bool opaque, String transition, Duration duration, bool popGesture}) {
    String _transition = transition.toLowerCase();
    Map<String, Transition> _transitions = {
      "fade": Transition.fade,
      "righttoleft": Transition.rightToLeft,
      "lefttoright": Transition.leftToRight,
      "uptodown": Transition.upToDown,
      "downtoup": Transition.downToUp,
      "scale": Transition.scale,
      "rotate": Transition.rotate,
      "size": Transition.size,
      "righttoleftwithfade": Transition.rightToLeftWithFade,
      "lefttorightwithfade": Transition.leftToRightWithFade,
      "cupertino": Transition.cupertino,
    };
    return Get.to(
      page,
      transition: _transitions[_transition] ?? Get.defaultTransition,
      duration: duration ?? Get.defaultDurationTransition,
      popGesture: popGesture ?? Get.isPopGestureEnable,
      opaque: opaque ?? Get.isOpaqueRouteDefault,
    );
  }

  /// Pops the current scope and indicates if you can pop again
  bool back({dynamic result}) {
    Get.back(result: result);
    return Get.key.currentState.canPop();
  }

  /// Pops the back stack until the predicate is satisfied
  void popUntil(RoutePredicate predicate) {
    Get.key.currentState.popUntil(predicate);
  }

  /// Pops the back stack the number of times you indicate with [popTimes]
  void popRepeated(int popTimes) {
    Get.close(popTimes);
  }

  /// Pushes [routeName] onto the navigation stack
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return Get.toNamed(routeName, arguments: arguments);
  }

  /// Replaces the current route with the [routeName]
  Future<dynamic> replaceWith(String routeName, {dynamic arguments}) {
    return Get.offNamed(routeName, arguments: arguments);
  }

  /// Clears the entire back stack and shows [routeName]
  Future<dynamic> clearStackAndShow(String routeName, {dynamic arguments}) {
    _clearBackstackCompletely();

    return replaceWith(routeName, arguments: arguments);
  }

  /// Pops the navigation stack until there's 1 view left then pushes [routeName] onto the stack
  Future<dynamic> clearTillFirstAndShow(String routeName, {dynamic arguments}) {
    _clearBackstackTillFirst();

    return navigateTo(routeName, arguments: arguments);
  }

  /// Push route and clear stack until predicate is satisfied
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {RoutePredicate predicate, arguments, int id}) {
    return Get.offAllNamed(routeName,
        predicate: predicate, arguments: arguments, id: id);
  }

  void _clearBackstackCompletely() {
    navigatorKey.currentState.popUntil((route) => false);
  }

  void _clearBackstackTillFirst() {
    navigatorKey.currentState.popUntil((route) => route.isFirst);
  }
}
