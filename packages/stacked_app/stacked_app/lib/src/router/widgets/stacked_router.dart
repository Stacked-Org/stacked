import 'package:stacked_app/src/route/page_route_info.dart';
import 'package:stacked_app/src/route/route_data.dart';
import 'package:stacked_app/src/router/controller/routing_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../controller/routing_controller.dart';
import 'stacked_router_delegate.dart';

class StackedRouter extends StatefulWidget {
  final List<PageRouteInfo> Function(BuildContext context, List<PageRouteInfo> routes) onGenerateRoutes;
  final bool _isDeclarative;
  final Function(PageRouteInfo route) onPopRoute;
  final List<NavigatorObserver> navigatorObservers;

  const StackedRouter({Key key, this.navigatorObservers})
      : _isDeclarative = false,
        onGenerateRoutes = null,
        onPopRoute = null,
        super(key: key);

  const StackedRouter.declarative({
    Key key,
    this.navigatorObservers,
    @required this.onGenerateRoutes,
    this.onPopRoute,
  })  : _isDeclarative = true,
        super(key: key);

  @override
  StackedRouterState createState() => StackedRouterState();

  static RoutingController of(BuildContext context) {
    var scope = RoutingControllerScope.of(context);
    assert(() {
      if (scope == null) {
        throw FlutterError('AutoRouter operation requested with a context that does not include an AutoRouter.\n'
            'The context used to retrieve the Router must be that of a widget that '
            'is a descendant of an AutoRouter widget.');
      }
      return true;
    }());

    return RoutingControllerScope.of(context).routerNode;
  }

  static RoutingController ofChildRoute(BuildContext context, String routeKey) {
    return of(context)?.findRouterOf(routeKey);
  }
}

class StackedRouterState extends State<StackedRouter> {
  ChildBackButtonDispatcher _backButtonDispatcher;
  StackedRouterDelegate _routerDelegate;
  List<PageRouteInfo> _routes;

  RoutingController get controller => _routerDelegate?.routerNode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_routerDelegate == null) {
      final router = Router.of(context);
      assert(router != null);
      _backButtonDispatcher = router.backButtonDispatcher.createChildBackButtonDispatcher();

      assert(router.routerDelegate is StackedRouterDelegate);
      final autoRouterDelegate = (router.routerDelegate as StackedRouterDelegate);
      final parentData = RouteData.of(context);
      assert(parentData != null);
      RouterNode routerNode = autoRouterDelegate.routerNode.routerOf(parentData);
      assert(routerNode != null);
      if (widget._isDeclarative) {
        _routes = routerNode.preMatchedRoutes;
        _routerDelegate = DeclarativeRouterDelegate(
          routerNode: routerNode,
          navigatorObservers: widget.navigatorObservers,
          routes: widget.onGenerateRoutes(context, _routes),
          onPopRoute: widget.onPopRoute,
          rootDelegate: autoRouterDelegate.rootDelegate,
        );
      } else {
        _routerDelegate = InnerRouterDelegate(
          routerNode: routerNode,
          navigatorObservers: widget.navigatorObservers,
          defaultRoutes: routerNode.preMatchedRoutes,
          rootDelegate: autoRouterDelegate.rootDelegate,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: _routerDelegate,
      backButtonDispatcher: _backButtonDispatcher..takePriority(),
    );
  }

  @override
  void didUpdateWidget(covariant StackedRouter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._isDeclarative) {
      var newRoutes = widget.onGenerateRoutes(context, _routes);
      if (!ListEquality().equals(newRoutes, _routes)) {
        _routes = newRoutes;
        (_routerDelegate as DeclarativeRouterDelegate).updateRoutes(newRoutes);
      }
    }
  }
}
