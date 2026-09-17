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

  /// Boxed reference to the most recently created [Route] for this page.
  ///
  /// Flutter's Navigator can call [createRoute] more than once for the same
  /// [StackedPage] instance (e.g. when a page is briefly recreated during a
  /// predictive back gesture that gets cancelled, or through other page
  /// reuse scenarios). We keep track of the latest route here so that only
  /// its pop result is ever forwarded through [popped], and so a stale route
  /// created by an earlier call can't complete [_popCompleter] a second time.
  ///
  /// This is boxed in a single-element, `final` list (instead of a plain
  /// mutable field) because [StackedPage] extends the `@immutable`-annotated
  /// [Page], which requires every instance field to be `final`.
  final _latestRouteBox = List<Route<T>?>.filled(1, null);

  Future<T?> get popped => _popCompleter.future;

  Widget get child => _child;

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
    final route = onCreateRoute(context);
    _latestRouteBox[0] = route;
    route.popped.then((result) {
      // Guard against this being a stale route from an earlier call to
      // createRoute (only the latest route's result should ever be
      // forwarded) and against _popCompleter already being completed by a
      // previous call. Without these checks, Flutter calling createRoute
      // more than once for the same page instance can complete the same
      // completer twice, throwing "Bad state: Future already completed".
      if (!identical(route, _latestRouteBox[0]) || _popCompleter.isCompleted) {
        return;
      }
      _popCompleter.complete(result);

      // Eagerly remove this page from the router's stack instead of relying
      // only on the async `onDidRemovePage` callback in RouteNavigator. The
      // Navigator can rebuild between this pop and that callback (routinely
      // during an Android predictive-back gesture). If `_pages` still holds
      // this page with no live Route behind it, the Navigator calls
      // createRoute again and produces a phantom second Route, which caused
      // the forward-transition flash on back gestures. `removeRoute` is
      // idempotent, so the later onDidRemovePage call is a harmless no-op.
      //
      // This runs in a `Future.then` microtask, after the synchronous call
      // stack (including any in-progress frame) has unwound, so notifying
      // listeners here does not happen during a build.
      //
      // Approach based on #1188 by @Vinsho.
      final router = routeData.router;
      if (router is StackRouter) {
        router.removeRoute(routeData, notify: true);
      }
    });
    return route;
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
