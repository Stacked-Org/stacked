import 'package:flutter/widgets.dart';
import 'package:stacked/src/router/controller/routing_controller.dart';

@protected
class RouterScope extends InheritedWidget {
  final RoutingController controller;
  final NavigatorObserversBuilder inheritableObserversBuilder;
  final int stateHash;
  final List<NavigatorObserver> navigatorObservers;

  const RouterScope({
    super.key,
    required super.child,
    required this.controller,
    required this.navigatorObservers,
    required this.inheritableObserversBuilder,
    required this.stateHash,
  });

  static RouterScope of(BuildContext context, {bool watch = false}) {
    RouterScope? scope;
    if (watch) {
      scope = context.dependOnInheritedWidgetOfExactType<RouterScope>();
    } else {
      scope = context.findAncestorWidgetOfExactType<RouterScope>();
    }
    assert(() {
      if (scope == null) {
        throw FlutterError(
            'RouterScope operation requested with a context that does not include a RouterScope.\n'
            'The context used to retrieve the Router must be that of a widget that '
            'is a descendant of a RouterScope widget.');
      }
      return true;
    }());
    return scope!;
  }

  T? firstObserverOfType<T extends NavigatorObserver>() {
    final typedObservers = navigatorObservers.whereType<T>();
    if (typedObservers.isNotEmpty) {
      return typedObservers.first;
    } else {
      return null;
    }
  }

  @override
  bool updateShouldNotify(covariant RouterScope oldWidget) {
    return stateHash != oldWidget.stateHash;
  }
}

class StackRouterScope extends InheritedWidget {
  final StackRouter controller;
  final int stateHash;

  const StackRouterScope({
    super.key,
    required super.child,
    required this.controller,
    required this.stateHash,
  });

  static StackRouterScope? of(BuildContext context, {bool watch = false}) {
    if (watch) {
      return context.dependOnInheritedWidgetOfExactType<StackRouterScope>();
    }
    return context.findAncestorWidgetOfExactType<StackRouterScope>();
  }

  @override
  bool updateShouldNotify(covariant StackRouterScope oldWidget) {
    return stateHash != oldWidget.stateHash;
  }
}

class TabsRouterScope extends InheritedWidget {
  final TabsRouter controller;
  final int stateHash;

  const TabsRouterScope({
    super.key,
    required super.child,
    required this.stateHash,
    required this.controller,
  });

  static TabsRouterScope? of(BuildContext context, {bool watch = false}) {
    if (watch) {
      return context.dependOnInheritedWidgetOfExactType<TabsRouterScope>();
    }
    return context.findAncestorWidgetOfExactType<TabsRouterScope>();
  }

  @override
  bool updateShouldNotify(covariant TabsRouterScope oldWidget) {
    return stateHash != oldWidget.stateHash;
  }
}
