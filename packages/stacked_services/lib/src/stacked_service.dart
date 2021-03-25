import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This service exposes properties that is required to be set before any of the services can be used
class StackedService {
  /// Returns the [Get.key] value to be set in the applications navigation
  static GlobalKey<NavigatorState>? get navigatorKey => Get.key;

  /// Creates and/or returns a new navigator key based on the index passed in
  static GlobalKey<NavigatorState>? nestedNavigationKey(int index) =>
      Get.nestedKey(index);
}
