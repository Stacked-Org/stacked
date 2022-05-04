import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation/route_observer.dart';

/// This service exposes properties that is required to be set before any of the services can be used
class StackedService {
  const StackedService._();

  /// Returns the [Get.key] value to be set in the applications navigation
  static GlobalKey<NavigatorState>? get navigatorKey => Get.key;

  /// Creates and/or returns a new navigator key based on the index passed in
  static GlobalKey<NavigatorState>? nestedNavigationKey(int index) =>
      Get.nestedKey(index);

  /// Returns the [GetObserver] to be passed through navigatorObservers in MaterialApp to use all the functionalities
  static NavigatorObserver get routeObserver => StackObserver();
}
