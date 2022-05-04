import 'package:flutter/material.dart';
import 'package:get/get.dart' as G;
import 'package:stacked_services/stacked_services.dart';

@Deprecated(
    'This will be deprecated in future release,Consider using Transition enum instead')
class NavigationTransition {
  static const String Fade = 'fade';
  static const String RightToLeft = 'righttoleft';
  static const String LeftToRight = 'lefttoright';
  static const String UpToDown = 'uptodown';
  static const String DownToUp = 'downtoup';
  static const String Rotate = 'zoom';
  static const String RightToLeftWithFade = 'righttoleftwithfade';
  static const String LeftToRighttWithFade = 'lefttorightwithfade';
}

/// Provides a service that can be injected into the ViewModels for navigation.
///
/// Uses the Get library for all navigation requirements
class NavigationService {
  Map<String, Transition> _transitions = {
    NavigationTransition.Fade: Transition.fade,
    NavigationTransition.RightToLeft: Transition.rightToLeft,
    NavigationTransition.LeftToRight: Transition.leftToRight,
    NavigationTransition.UpToDown: Transition.upToDown,
    NavigationTransition.DownToUp: Transition.downToUp,
    NavigationTransition.Rotate: Transition.zoom,
    NavigationTransition.RightToLeftWithFade: Transition.rightToLeftWithFade,
    NavigationTransition.LeftToRighttWithFade: Transition.leftToRightWithFade,
  };

  @Deprecated(
      'Prefer to use the StackedServices.navigatorKey instead of using this key. This will be removed in the next major version update for stacked.')
  GlobalKey<NavigatorState>? get navigatorKey => G.Get.key;

  /// Returns the previous route
  String get previousRoute => G.Get.previousRoute;

  /// Returns the current route
  String get currentRoute => G.Get.currentRoute;

  /// Returns the current arguments
  dynamic get currentArguments => G.Get.arguments;

  /// Creates and/or returns a new navigator key based on the index passed in
  @Deprecated(
      'Prefer to use the StackedServices.nestedNavigationKey instead of using this property. This will be removed in the next major version update for stacked.')
  GlobalKey<NavigatorState>? nestedNavigationKey(int index) =>
      G.Get.nestedKey(index);

  /// Allows you to configure the default behaviour for navigation.
  ///
  /// [defaultTransition] can be set using the static members of [NavigationTransition]
  ///
  /// If you want to use the string directly. Defined [transition] values are
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
  void config({
    bool? enableLog,
    bool? defaultPopGesture,
    bool? defaultOpaqueRoute,
    Duration? defaultDurationTransition,
    bool? defaultGlobalState,
    Transition? defaultTransitionStyle,
    @Deprecated('Prefer to use the defaultTransitionStyle instead of using this property. This will be removed in the next major version update for stacked.')
        String? defaultTransition,
  }) {
    G.Get.config(
        enableLog: enableLog,
        defaultPopGesture: defaultPopGesture,
        defaultOpaqueRoute: defaultOpaqueRoute,
        defaultDurationTransition: defaultDurationTransition,
        defaultGlobalState: defaultGlobalState,
        defaultTransition: defaultTransitionStyle?.toGet ??
            _getTransitionOrDefault(defaultTransition!));
  }

  /// Pushes [page] onto the navigation stack. This uses the [page] itself (Widget) instead
  /// of routeName (String).
  ///
  /// Defined [transition] values can be accessed as static memebers of [NavigationTransition]
  ///
  /// If you want to use the string directly. Defined [transition] values are
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
  Future<T?>? navigateWithTransition<T>(
    Widget page, {
    bool? opaque,
    @Deprecated('Prefer to use the transitionStyle instead of using this property. This will be removed in the next major version update for stacked.')
        String transition = '',
    Duration? duration,
    bool? popGesture,
    int? id,
    Curve? curve,
    G.Bindings? binding,
    bool fullscreenDialog = false,
    bool preventDuplicates = true,
    @Deprecated('Prefer to use the transitionStyle instead of using this property. This will be removed in the next major version update for stacked.')
        Transition? transitionClass,
    Transition? transitionStyle,
  }) {
    return G.Get.to<T?>(
      () => page,
      transition: transitionStyle?.toGet ??
          transitionClass?.toGet ??
          _getTransitionOrDefault(transition),
      duration: duration ?? G.Get.defaultTransitionDuration,
      popGesture: popGesture ?? G.Get.isPopGestureEnable,
      opaque: opaque ?? G.Get.isOpaqueRouteDefault,
      id: id,
      preventDuplicates: preventDuplicates,
      curve: curve,
      binding: binding,
      fullscreenDialog: fullscreenDialog,
    );
  }

  /// Replaces current view in the navigation stack. This uses the [page] itself (Widget) instead
  /// of routeName (String).
  ///
  /// Defined [transition] values can be accessed as static memebers of [NavigationTransition]
  ///
  /// If you want to use the string directly. Defined [transition] values are
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
  Future<T?>? replaceWithTransition<T>(
    Widget page, {
    bool? opaque,
    @Deprecated('Prefer to use the transitionStyle instead of using this property. This will be removed in the next major version update for stacked.')
        String transition = '',
    Duration? duration,
    bool? popGesture,
    int? id,
    Curve? curve,
    G.Bindings? binding,
    bool fullscreenDialog = false,
    bool preventDuplicates = true,
    @Deprecated('Prefer to use the transitionStyle instead of using this property. This will be removed in the next major version update for stacked.')
        Transition? transitionClass,
    Transition? transitionStyle,
  }) {
    return G.Get.off<T?>(
      () => page,
      transition: transitionStyle?.toGet ??
          transitionClass?.toGet ??
          _getTransitionOrDefault(transition),
      duration: duration ?? G.Get.defaultTransitionDuration,
      popGesture: popGesture ?? G.Get.isPopGestureEnable,
      opaque: opaque ?? G.Get.isOpaqueRouteDefault,
      id: id,
      preventDuplicates: preventDuplicates,
      curve: curve,
      binding: binding,
      fullscreenDialog: fullscreenDialog,
    );
  }

  /// Pops the current scope and indicates if you can pop again
  bool back<T>({dynamic result, int? id}) {
    G.Get.back<T>(result: result, id: id);
    return G.Get.key.currentState?.canPop() ?? false;
  }

  /// Pops the back stack until the predicate is satisfied
  void popUntil(RoutePredicate predicate) {
    G.Get.key.currentState?.popUntil(predicate);
  }

  /// Pops the back stack the number of times you indicate with [popTimes]
  void popRepeated(int popTimes) {
    G.Get.close(popTimes);
  }

  /// Pushes [routeName] onto the navigation stack
  Future<T?>? navigateTo<T>(
    String routeName, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return G.Get.toNamed<T?>(
      routeName,
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  /// Pushes [view] onto the navigation stack
  Future<T?>? navigateToView<T>(
    Widget view, {
    dynamic arguments,
    int? id,
    bool? opaque,
    Curve? curve,
    G.Bindings? binding,
    Duration? duration,
    bool fullscreenDialog = false,
    bool? popGesture,
    bool preventDuplicates = true,
    @Deprecated('Prefer to use the transitionStyle instead of using this property. This will be removed in the next major version update for stacked.')
        Transition? transition,
    Transition? transitionStyle,
  }) {
    return G.Get.to<T?>(
      () => view,
      arguments: arguments,
      id: id,
      opaque: opaque,
      preventDuplicates: preventDuplicates,
      curve: curve,
      binding: binding,
      duration: duration,
      fullscreenDialog: fullscreenDialog,
      popGesture: popGesture,
      transition: transitionStyle?.toGet ?? transition?.toGet,
    );
  }

  /// Replaces the current route with the [routeName]
  Future<T?>? replaceWith<T>(
    String routeName, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    return G.Get.offNamed<T?>(
      routeName,
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  /// Clears the entire back stack and shows [routeName]
  Future<T?>? clearStackAndShow<T>(
    String routeName, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    return G.Get.offAllNamed<T?>(
      routeName,
      arguments: arguments,
      id: id,
      parameters: parameters,
    );
  }

  /// Pops the navigation stack until there's 1 view left then pushes [routeName] onto the stack
  Future<T?>? clearTillFirstAndShow<T>(
    String routeName, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    _clearBackstackTillFirst();

    return navigateTo<T?>(
      routeName,
      arguments: arguments,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
    );
  }

  /// Pops the navigation stack until there's 1 view left then pushes [view] onto the stack
  Future<T?>? clearTillFirstAndShowView<T>(Widget view,
      {dynamic arguments, int? id}) {
    _clearBackstackTillFirst();

    return navigateToView<T?>(view, arguments: arguments, id: id);
  }

  /// Push route and clear stack until predicate is satisfied
  Future<T?>? pushNamedAndRemoveUntil<T>(String routeName,
      {RoutePredicate? predicate, dynamic arguments, int? id}) {
    return G.Get.offAllNamed<T?>(
      routeName,
      predicate: predicate,
      arguments: arguments,
      id: id,
    );
  }

  void _clearBackstackTillFirst() {
    StackedService.navigatorKey?.currentState
        ?.popUntil((Route route) => route.isFirst);
  }

  G.Transition? _getTransitionOrDefault(String transition) {
    String _transition = transition.toLowerCase();
    return _transitions[_transition]?.toGet ?? G.Get.defaultTransition;
  }
}
