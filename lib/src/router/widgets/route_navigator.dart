import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/src/router/controller/routing_controller.dart';
import 'package:stacked/src/router/route/page_route_info.dart';
import 'package:stacked/src/router/stacked_page.dart';

class RouteNavigator extends StatefulWidget {
  final StackRouter router;
  final String? navRestorationScopeId;
  final WidgetBuilder? placeholder;
  final List<NavigatorObserver> navigatorObservers;
  final RoutePopCallBack? didPop;
  final RoutesBuilder? declarativeRoutesBuilder;

  const RouteNavigator({
    required this.router,
    required this.navigatorObservers,
    this.navRestorationScopeId,
    this.didPop,
    this.declarativeRoutesBuilder,
    this.placeholder,
    super.key,
  });

  @override
  RouteNavigatorState createState() => RouteNavigatorState();
}

class RouteNavigatorState extends State<RouteNavigator> {
  List<PageRouteInfo>? _routesSnapshot;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.declarativeRoutesBuilder != null && _routesSnapshot == null) {
      _updateDeclarativeRoutes();
    }
  }

  void _updateDeclarativeRoutes() {
    final delegate = NestedRouterDelegate.of(context);
    var newRoutes =
        widget.declarativeRoutesBuilder!(widget.router.pendingRoutesHandler);
    if (!const ListEquality().equals(newRoutes, _routesSnapshot)) {
      _routesSnapshot = newRoutes;
      widget.router.updateDeclarativeRoutes(newRoutes);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        delegate.notifyUrlChanged();
      });
    }
  }

  @override
  void didUpdateWidget(covariant RouteNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.declarativeRoutesBuilder != null) {
      _updateDeclarativeRoutes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigator = widget.router.hasEntries
        ? Navigator(
            key: widget.router.navigatorKey,
            observers: [
              widget.router.pagelessRoutesObserver,
              ...widget.navigatorObservers
            ],
            restorationScopeId:
                widget.navRestorationScopeId ?? widget.router.routeData.name,
            pages: widget.router.stack,
            // ignore: deprecated_member_use
            onPopPage: (route, result) {
              // CRITICAL: Using deprecated onPopPage instead of onDidRemovePage
              // because we MUST update router state BEFORE the pop completes.
              // This is essential for Android predictive back gestures to work
              // without animation glitches (double animations or forward replays).
              // onDidRemovePage is called too late (after page removal) and causes
              // page list mismatch during the animation, triggering visual glitches.
              // See: https://github.com/flutter/flutter/issues/new (migration path unclear)
              if (!route.didPop(result)) {
                return false;
              }

              if (route.settings is StackedPage) {
                var page = route.settings as StackedPage;
                widget.router.removeRoute(page.routeData);
                widget.didPop?.call(page.routeData.route, result);
              }

              return true;
            },
          )
        : widget.placeholder?.call(context) ??
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
            );

    // fixes nested cupertino routes back gesture issue
    if (!widget.router.isRoot) {
      return PopScope(
        onPopInvokedWithResult: widget.router.canPop(ignoreParentRoutes: true)
            ? (didPop, result) => SynchronousFuture(true)
            : null,
        child: navigator,
      );
    }

    return navigator;
  }
}
