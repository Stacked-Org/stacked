import 'package:flutter/widgets.dart';
import 'package:stacked/src/router/auto_router_x.dart';
import 'package:stacked/src/router/controller/controller_scope.dart';
import 'package:stacked/src/router/controller/routing_controller.dart';
import 'package:stacked/src/router/matcher/route_match.dart';
import 'package:stacked/src/router/stacked_page.dart';

class RouterObserver extends NavigatorObserver {
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {}
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {}
}

abstract class RouteAware {
  /// Called when the top route has been popped off, and the current route
  /// shows up.
  void didPopNext() {}

  /// Called when the current route has been pushed.
  void didPush() {}

  /// Called when the current route has been popped off.
  void didPop() {}

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  void didPushNext() {}

  // called when a tab route activates
  void didInitTabRoute(TabPageRoute? previousRoute) {}
  // called when tab route reactivates
  void didChangeTabRoute(TabPageRoute previousRoute) {}
}

mixin RouteAwareStateMixin<T extends StatefulWidget> on State<T>
    implements RouteAware {
  RouteObserver? _observer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // RouterScope exposes the list of provided observers
    // including inherited observers
    _observer = RouterScope.of(context).firstObserverOfType<RouteObserver>();
    if (_observer != null) {
      // we subscribe to the observer by passing our
      // RouteAware state and the scoped routeData
      _observer!.subscribe(this, context.routeData);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _observer?.unsubscribe(this);
  }

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {}

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {}

  @override
  void didPop() {}

  @override
  void didPush() {}

  @override
  void didPopNext() {}

  @override
  void didPushNext() {}
}

class RouteObserver extends RouterObserver {
  final Map<LocalKey, Set<RouteAware>> _listeners =
      <LocalKey, Set<RouteAware>>{};

  /// Subscribe [routeAware] to be informed about changes to [route].
  ///
  /// Going forward, [routeAware] will be informed about qualifying changes
  /// to [route], e.g. when [route] is covered by another route or when [route]
  /// is popped off the [Navigator] stack.
  void subscribe(RouteAware routeAware, RouteData route) {
    final Set<RouteAware> subscribers =
        _listeners.putIfAbsent(route.key, () => <RouteAware>{});
    if (subscribers.add(routeAware)) {
      if (route.router is TabsRouter) {
        routeAware.didInitTabRoute(null);
      } else {
        routeAware.didPush();
      }
    }
  }

  /// Unsubscribe [routeAware].
  ///
  /// [routeAware] is no longer informed about changes to its route. If the given argument was
  /// subscribed to multiple types, this will unregister it (once) from each type.

  void unsubscribe(RouteAware routeAware) {
    for (final route in _listeners.keys) {
      final Set<RouteAware>? subscribers = _listeners[route];
      subscribers?.remove(routeAware);
    }
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    final List<RouteAware>? subscribers =
        _listeners[route.routeInfo.key]?.toList();
    if (subscribers != null) {
      for (final RouteAware routeAware in subscribers) {
        routeAware.didInitTabRoute(previousRoute);
      }
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    final List<RouteAware>? subscribers =
        _listeners[route.routeInfo.key]?.toList();
    if (subscribers != null) {
      for (final RouteAware routeAware in subscribers) {
        routeAware.didChangeTabRoute(previousRoute);
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings is StackedPage &&
        previousRoute?.settings is StackedPage) {
      final previousKey = (previousRoute!.settings as StackedPage).routeKey;
      final List<RouteAware>? previousSubscribers =
          _listeners[previousKey]?.toList();

      if (previousSubscribers != null) {
        for (final RouteAware routeAware in previousSubscribers) {
          routeAware.didPopNext();
        }
      }
      final key = (route.settings as StackedPage).routeKey;

      final List<RouteAware>? subscribers = _listeners[key]?.toList();

      if (subscribers != null) {
        for (final RouteAware routeAware in subscribers) {
          routeAware.didPop();
        }
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings is StackedPage &&
        previousRoute?.settings is StackedPage) {
      final previousKey = (previousRoute!.settings as StackedPage).routeKey;
      final Set<RouteAware>? previousSubscribers = _listeners[previousKey];

      if (previousSubscribers != null) {
        for (final RouteAware routeAware in previousSubscribers) {
          routeAware.didPushNext();
        }
      }
    }
  }
}

class TabPageRoute {
  final RouteMatch routeInfo;

  final int index;
  const TabPageRoute({
    required this.routeInfo,
    required this.index,
  });

  String get name => routeInfo.name;
  String get path => routeInfo.path;
  String get match => routeInfo.stringMatch;
}
