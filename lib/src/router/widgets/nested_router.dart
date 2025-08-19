import 'package:flutter/material.dart';
import 'package:stacked/src/router/controller/controller_scope.dart';
import 'package:stacked/src/router/controller/routing_controller.dart';
import 'package:stacked/src/router/route/page_route_info.dart';
import 'package:stacked/src/router/widgets/route_navigator.dart';

class NestedRouter extends StatefulWidget {
  final NavigatorObserversBuilder navigatorObservers;
  final Widget Function(BuildContext context, Widget content)? builder;
  final String? navRestorationScopeId;
  final bool inheritNavigatorObservers;
  final GlobalKey<NavigatorState>? navigatorKey;
  final WidgetBuilder? placeholder;

  const NestedRouter({
    super.key,
    this.navigatorObservers =
        NestedRouterDelegate.defaultNavigatorObserversBuilder,
    this.builder,
    this.navRestorationScopeId,
    this.navigatorKey,
    this.inheritNavigatorObservers = true,
    this.placeholder,
  });

  static Widget declarative({
    Key? key,
    NavigatorObserversBuilder navigatorObservers =
        NestedRouterDelegate.defaultNavigatorObserversBuilder,
    required RoutesBuilder routes,
    RoutePopCallBack? onPopRoute,
    String? navRestorationScopeId,
    bool inheritNavigatorObservers = true,
    GlobalKey<NavigatorState>? navigatorKey,
    OnNestedNavigateCallBack? onNavigate,
    WidgetBuilder? placeholder,
  }) =>
      _DeclarativeStackedRouter(
        onPopRoute: onPopRoute,
        navigatorKey: navigatorKey,
        navRestorationScopeId: navRestorationScopeId,
        navigatorObservers: navigatorObservers,
        inheritNavigatorObservers: inheritNavigatorObservers,
        onNavigate: onNavigate,
        placeholder: placeholder,
        routes: routes,
      );

  @override
  NestedRouterState createState() => NestedRouterState();

  static StackRouter of(BuildContext context, {bool watch = false}) {
    var scope = StackRouterScope.of(context, watch: watch);
    assert(() {
      if (scope == null) {
        throw FlutterError(
            'NestedRouter operation requested with a context that does not include an NestedRouter.\n'
            'The context used to retrieve the Router must be that of a widget that '
            'is a descendant of an NestedRouter widget.');
      }
      return true;
    }());
    return scope!.controller;
  }

  static StackRouter? innerRouterOf(BuildContext context, String routeName) {
    return of(context).innerRouterOf<StackRouter>(routeName);
  }
}

class NestedRouterState extends State<NestedRouter> {
  StackRouter? _controller;

  StackRouter? get controller => _controller;
  late List<NavigatorObserver> _navigatorObservers;
  late NavigatorObserversBuilder _inheritableObserversBuilder;
  late RoutingController _parentController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller == null) {
      final parentRouteData = RouteData.of(context);
      final parentScope = RouterScope.of(context, watch: true);
      _inheritableObserversBuilder = () {
        var observers = widget.navigatorObservers();
        if (!widget.inheritNavigatorObservers) {
          return observers;
        }
        var inheritedObservers = parentScope.inheritableObserversBuilder();
        return inheritedObservers + observers;
      };
      _navigatorObservers = _inheritableObserversBuilder();
      _parentController = parentScope.controller;
      _controller = NestedStackRouter(
        parent: _parentController,
        key: parentRouteData.key,
        routeData: parentRouteData,
        navigatorKey: widget.navigatorKey,
        routeCollection: _parentController.routeCollection.subCollectionOf(
          parentRouteData.name,
        ),
        pageBuilder: _parentController.pageBuilder,
      );

      _parentController.attachChildController(_controller!);
      _controller!.addListener(_rebuildListener);
    }
  }

  void _rebuildListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(_controller != null);
    var navigator = RouteNavigator(
      router: _controller!,
      navRestorationScopeId: widget.navRestorationScopeId,
      navigatorObservers: _navigatorObservers,
      placeholder: widget.placeholder,
    );
    final stateHash = controller!.stateHash;
    return RouterScope(
      controller: _controller!,
      inheritableObserversBuilder: _inheritableObserversBuilder,
      navigatorObservers: _navigatorObservers,
      stateHash: stateHash,
      child: StackRouterScope(
        controller: _controller!,
        stateHash: stateHash,
        child: widget.builder == null
            ? navigator
            : Builder(
                builder: (ctx) => widget.builder!(ctx, navigator),
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller!.removeListener(_rebuildListener);
      _controller!.dispose();
      _parentController.removeChildController(_controller!);
      _controller = null;
    }
  }
}

typedef RoutesGenerator = List<PageRouteInfo> Function(
    BuildContext context, List<PageRouteInfo> routes);

class _DeclarativeStackedRouter extends StatefulWidget {
  final RoutesBuilder routes;
  final RoutePopCallBack? onPopRoute;
  final NavigatorObserversBuilder navigatorObservers;
  final String? navRestorationScopeId;
  final bool inheritNavigatorObservers;
  final GlobalKey<NavigatorState>? navigatorKey;
  final OnNestedNavigateCallBack? onNavigate;
  final WidgetBuilder? placeholder;

  const _DeclarativeStackedRouter({
    required this.routes,
    this.navigatorObservers =
        NestedRouterDelegate.defaultNavigatorObserversBuilder,
    this.onPopRoute,
    this.navigatorKey,
    this.navRestorationScopeId,
    this.inheritNavigatorObservers = true,
    this.onNavigate,
    this.placeholder,
  });

  @override
  _DeclarativeStackedRouterState createState() =>
      _DeclarativeStackedRouterState();
}

class _DeclarativeStackedRouterState extends State<_DeclarativeStackedRouter> {
  StackRouter? _controller;
  late HeroController _heroController;

  StackRouter? get controller => _controller;
  late List<NavigatorObserver> _navigatorObservers;
  late NavigatorObserversBuilder _inheritableObserversBuilder;
  late RoutingController _parentController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final parentData = RouteData.of(context);
    if (_controller == null) {
      _heroController = HeroController();
      final parentScope = RouterScope.of(context);
      _inheritableObserversBuilder = () {
        var observers = widget.navigatorObservers();
        if (!widget.inheritNavigatorObservers) {
          return observers;
        }
        var inheritedObservers = parentScope.inheritableObserversBuilder();
        return inheritedObservers + observers;
      };
      _navigatorObservers = _inheritableObserversBuilder();
      _parentController = parentScope.controller;
      _controller = NestedStackRouter(
          parent: _parentController,
          key: parentData.key,
          routeData: parentData,
          managedByWidget: true,
          onNavigate: widget.onNavigate,
          navigatorKey: widget.navigatorKey,
          routeCollection: _parentController.routeCollection.subCollectionOf(
            parentData.name,
          ),
          pageBuilder: _parentController.pageBuilder);
      _parentController.attachChildController(_controller!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller!.dispose();
      _parentController.removeChildController(_controller!);
      _controller = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(_controller != null);
    final stateHash = controller!.stateHash;

    return RouterScope(
      controller: _controller!,
      inheritableObserversBuilder: _inheritableObserversBuilder,
      navigatorObservers: _navigatorObservers,
      stateHash: stateHash,
      child: HeroControllerScope(
        controller: _heroController,
        child: RouteNavigator(
          router: _controller!,
          declarativeRoutesBuilder: widget.routes,
          navRestorationScopeId: widget.navRestorationScopeId,
          navigatorObservers: _navigatorObservers,
          didPop: widget.onPopRoute,
          placeholder: widget.placeholder,
        ),
      ),
    );
  }
}
