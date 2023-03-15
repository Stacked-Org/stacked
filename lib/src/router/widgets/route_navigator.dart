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
    Key? key,
  }) : super(key: key);

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
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }
              if (route.settings is StackedPage) {
                var routeData = (route.settings as StackedPage).routeData;
                widget.router.removeRoute(routeData);
                widget.didPop?.call(routeData.route, result);
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
      return WillPopScope(
        onWillPop: widget.router.canPop(ignoreParentRoutes: true)
            ? () => SynchronousFuture(true)
            : null,
        child: navigator,
      );
    }

    return navigator;
  }
}
