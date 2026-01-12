import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/src/router/controller/routing_controller.dart';
import 'package:stacked/src/router/route/route_data_scope.dart';
import 'package:stacked/src/router/widgets/custom_cupertino_transitions_builder.dart';

import 'common/route_wrapper.dart';
import 'widgets/wrapped_route.dart';

abstract class StackedPage<T> extends Page<T> {
  final RouteData routeData;
  final Widget _child;
  final bool fullscreenDialog;
  final bool maintainState;
  final bool opaque;

  final _popCompleter = Completer<T?>();

  Future<T?> get popped => _popCompleter.future;

  Widget get child => _child;

  // Track current route and listener state to prevent double-completion
  // Navigator 2.0 can call createRoute() multiple times on the same Page instance
  Route<T>? _currentRoute;
  bool _hasAttachedListener = false;

  StackedPage({
    required this.routeData,
    required Widget child,
    this.fullscreenDialog = false,
    this.maintainState = true,
    this.opaque = true,
    LocalKey? key,
  })  : _child = child is RouteWrapper
            ? WrappedRoute(
                child: child as RouteWrapper,
              )
            : child,
        super(
          restorationId: routeData.name,
          name: routeData.name,
          arguments: routeData.route.args,
        );

  @override
  bool canUpdate(Page<dynamic> other) {
    return other.runtimeType == runtimeType &&
        (other as StackedPage).routeKey == routeKey;
  }

  LocalKey get routeKey => routeData.key;

  Widget buildPage(BuildContext context) {
    return RouteDataScope(
      routeData: routeData,
      child: _child,
    );
  }

  Route<T> onCreateRoute(BuildContext context);

  @override
  Route<T> createRoute(BuildContext context) {
    // Clear previous route reference to allow garbage collection
    _currentRoute = null;

    // Create the new route
    _currentRoute = onCreateRoute(context);

    // Only attach listener once to prevent "Future already completed" error
    // Navigator 2.0 can call createRoute() multiple times during back gestures
    if (!_hasAttachedListener) {
      _currentRoute!.popped.then(_popCompleter.complete);
      _hasAttachedListener = true;
    }

    return _currentRoute!;
  }
}

class MaterialPageX<T> extends StackedPage<T> {
  MaterialPageX({
    required super.routeData,
    required super.child,
    super.fullscreenDialog,
    super.maintainState,
    super.key,
  });

  @override
  Route<T> onCreateRoute(BuildContext context) {
    return PageBasedMaterialPageRoute<T>(page: this);
  }
}

class PageBasedMaterialPageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T> {
  PageBasedMaterialPageRoute({
    required StackedPage page,
  }) : super(settings: page);

  StackedPage get _page => settings as StackedPage;

  List<VoidCallback> scopes = [];

  @override
  Widget buildContent(BuildContext context) => _page.buildPage(context);

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}

class _CustomPageBasedPageRouteBuilder<T> extends PageRoute<T>
    with _CustomPageRouteTransitionMixin<T> {
  _CustomPageBasedPageRouteBuilder({
    required StackedPage page,
  }) : super(settings: page);

  @override
  Widget buildContent(BuildContext context) => _page.buildPage(context);

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}

class _NoAnimationPageRouteBuilder<T> extends PageRoute<T>
    with _NoAnimationPageRouteTransitionMixin<T> {
  _NoAnimationPageRouteBuilder({
    required StackedPage page,
  }) : super(settings: page);

  @override
  Widget buildContent(BuildContext context) => _page.buildPage(context);

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';

  @override
  Duration get transitionDuration => Duration.zero;
}

mixin _NoAnimationPageRouteTransitionMixin<T> on PageRoute<T> {
  /// Builds the primary contents of the route.
  StackedPage<T> get _page => settings as StackedPage<T>;

  @protected
  Widget buildContent(BuildContext context);

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => _page.opaque;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    // Don't perform outgoing animation if the next route is a fullscreen dialog.
    return (nextRoute is _CustomPageBasedPageRouteBuilder &&
                !nextRoute.fullscreenDialog ||
            nextRoute is MaterialRouteTransitionMixin &&
                !nextRoute.fullscreenDialog) ||
        (nextRoute is _NoAnimationPageRouteTransitionMixin &&
            !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoRouteTransitionMixin &&
            !nextRoute.fullscreenDialog);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: buildContent(context),
    );
  }
}

mixin _CustomPageRouteTransitionMixin<T> on PageRoute<T> {
  /// Builds the primary contents of the route.
  CustomPage<T> get _page => settings as CustomPage<T>;

  @protected
  Widget buildContent(BuildContext context);

  @override
  Duration get transitionDuration => Duration(
        milliseconds: _page.durationInMilliseconds,
      );

  @override
  Duration get reverseTransitionDuration => Duration(
        milliseconds: _page.reverseDurationInMilliseconds,
      );

  @override
  bool get barrierDismissible => _page.barrierDismissible;

  @override
  Color? get barrierColor =>
      _page.barrierColor == null ? null : Color(_page.barrierColor!);

  @override
  String? get barrierLabel => _page.barrierLabel;

  @override
  bool get opaque => _page.opaque;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    // Don't perform outgoing animation if the next route is a fullscreen dialog.
    return (nextRoute is MaterialRouteTransitionMixin &&
            !nextRoute.fullscreenDialog) ||
        (nextRoute is _NoAnimationPageRouteTransitionMixin &&
            !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoRouteTransitionMixin &&
            !nextRoute.fullscreenDialog);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: buildContent(context),
    );
  }

  Widget _defaultTransitionsBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final transitionsBuilder =
        _page.transitionsBuilder ?? _defaultTransitionsBuilder;
    return transitionsBuilder(context, animation, secondaryAnimation, child);
  }
}

abstract class _TitledAutoRoutePage<T> extends StackedPage<T> {
  final String? title;

  _TitledAutoRoutePage({
    required super.routeData,
    required super.child,
    this.title,
    super.fullscreenDialog,
    super.maintainState,
    super.opaque,
  });
}

class CupertinoPageX<T> extends _TitledAutoRoutePage<T> {
  CupertinoPageX({
    required super.routeData,
    required super.child,
    super.title,
    super.fullscreenDialog,
    super.maintainState,
  });

  @override
  Route<T> onCreateRoute(BuildContext context) {
    return _PageBasedCupertinoPageRoute<T>(page: this);
  }
}

class _PageBasedCupertinoPageRoute<T> extends PageRoute<T>
    with CustomCupertinoRouteTransitionMixin<T> {
  _PageBasedCupertinoPageRoute({
    required _TitledAutoRoutePage page,
  }) : super(settings: page);

  _TitledAutoRoutePage get _page => settings as _TitledAutoRoutePage;

  @override
  Widget buildContent(BuildContext context) => _page.buildPage(context);

  @override
  String? get title => _page.title;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}

class AdaptivePage<T> extends _TitledAutoRoutePage<T> {
  AdaptivePage({
    required super.routeData,
    required super.child,
    super.title,
    super.fullscreenDialog,
    super.maintainState,
    super.opaque,
  });

  @override
  Route<T> onCreateRoute(BuildContext context) {
    if (kIsWeb) {
      return _NoAnimationPageRouteBuilder<T>(page: this);
    }

    return PageBasedMaterialPageRoute<T>(page: this);
  }
}

typedef CustomRouteBuilder = Route<T> Function<T>(
    BuildContext context, Widget child, CustomPage<T> page);

class CustomPage<T> extends StackedPage<T> {
  final int durationInMilliseconds;
  final int reverseDurationInMilliseconds;
  final int? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final RouteTransitionsBuilder? transitionsBuilder;
  final CustomRouteBuilder? customRouteBuilder;

  CustomPage({
    required super.routeData,
    required super.child,
    super.fullscreenDialog,
    super.maintainState,
    super.opaque,
    this.durationInMilliseconds = 300,
    this.reverseDurationInMilliseconds = 300,
    this.barrierColor,
    this.barrierDismissible = false,
    this.barrierLabel,
    this.transitionsBuilder,
    this.customRouteBuilder,
    super.key,
  });

  @override
  Route<T> onCreateRoute(BuildContext context) {
    final result = buildPage(context);
    if (customRouteBuilder != null) {
      return customRouteBuilder!<T>(context, result, this);
    }
    return _CustomPageBasedPageRouteBuilder<T>(page: this);
  }
}
