import 'dart:async';

import 'route_data.dart';
import 'router_base.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'router_utils.dart';
import 'package:stacked_shared/stacked_shared.dart';

import 'uri_extension.dart';

RectTween _createRectTween(Rect? begin, Rect? end) {
  return MaterialRectArcTween(begin: begin, end: end);
}

extension BuildContextX on BuildContext {
  ExtendedNavigatorState? get navigator =>
      ExtendedNavigator.of(this, nullOk: true);

  ExtendedNavigatorState? get rootNavigator =>
      ExtendedNavigator.of(this, rootRouter: true, nullOk: true);
}

class ExtendedNavigator<T extends RouterBase?> extends StatefulWidget {
  static TransitionBuilder builder<T extends RouterBase>({
    GlobalKey<NavigatorState>? navigatorKey,
    List<NavigatorObserver> observers = const [],
    RouteFactory? onUnknownRoute,
    String? initialRoute,
    Object? initialRouteArgs,
    required T router,
    String? name,
    TransitionBuilder? builder,
  }) =>
      (context, nav) {
        var extendedNav = ExtendedNavigator<T>(
          key: GlobalObjectKey(nav!.key!),
          navigatorKey: navigatorKey,
          observers: observers,
          onUnknownRoute: onUnknownRoute,
          initialRoute: initialRoute,
          initialRouteArgs: initialRouteArgs,
          router: router,
          name: name,
        );
        if (builder != null) {
          return builder(context, extendedNav);
        }
        return extendedNav;
      };

  ExtendedNavigator({
    this.router,
    this.name,
    this.initialRoute,
    this.onUnknownRoute,
    this.initialRouteArgs,
    this.navigatorKey,
    this.observers = const <NavigatorObserver>[],
    Key? key,
  }) : super(key: key);

  final GlobalKey<NavigatorState>? navigatorKey;
  final List<NavigatorObserver> observers;
  final RouteFactory? onUnknownRoute;
  final String? initialRoute;
  final Object? initialRouteArgs;
  final T? router;
  final String? name;

  @override
  ExtendedNavigatorState createState() => ExtendedNavigatorState<T>();

  static get _placeHolderRoute => PageRouteBuilder(
        pageBuilder: (context, __, ___) => Container(
          color: Theme.of(context).colorScheme.background,
        ),
      );

  static List<Route<dynamic>> _generateInitialRoutes(
    ExtendedNavigatorState router,
    Uri initialUri,
    Object? initialRouteArgs,
  ) {
    var initialRoutes = <Route>[];
    var navigator = router._navigator!;

    var initialRouteName = initialUri.path;
    if (!kIsWeb &&
        initialRouteName.startsWith('/') &&
        initialRouteName.length > 1) {
      var root = initialUri.replace(path: "/").normalizedPath;
      var rootRoute =
          navigator.widget.onGenerateRoute!(RouteSettings(name: root));
      if (rootRoute != null) {
        initialRoutes.add(rootRoute);
      }
    }

    var settings = RouteSettings(
        name: initialUri.normalizedPath, arguments: initialRouteArgs);
    var route = navigator.widget.onGenerateRoute!(settings);

    if (route != null) {
      if (router._guardedInitialRoutes.isNotEmpty) {
        router._guardedInitialRoutes.add(route);
        if (initialRoutes.isEmpty) {
          initialRoutes.add(_placeHolderRoute);
        }
      } else {
        initialRoutes.add(route);
      }
    } else {
      var unknownRoute = navigator.widget.onUnknownRoute!(settings);
      if (unknownRoute != null) {
        initialRoutes.add(unknownRoute);
      }
    }

    return initialRoutes;
  }

  @Deprecated("use ExtendedNavigator.builder instead")
  ExtendedNavigator<T> call(_, navigator) => this;

  static ExtendedNavigatorState? named(String name) {
    return _NavigatorsContainer._instance.get(name);
  }

  static ExtendedNavigatorState? get root =>
      _NavigatorsContainer._instance.getRootRouter();

  static ExtendedNavigatorState? of(
    BuildContext context, {
    bool rootRouter = false,
    bool nullOk = false,
  }) {
    final ExtendedNavigatorState? router = rootRouter
        ? context.findRootAncestorStateOfType<ExtendedNavigatorState>()
        : context.findAncestorStateOfType<ExtendedNavigatorState>();
    assert(() {
      if (router == null && !nullOk) {
        throw FlutterError(
            'ExtendedNavigator operation requested with a context that does not include an ExtendedNavigator.\n'
            'The context used to push or pop routes from the ExtendedNavigator must be that of a '
            'widget that is a descendant of an ExtendedNavigator widget.');
      }
      return true;
    }());
    return router;
  }
}

class ExtendedNavigatorState<T extends RouterBase?>
    extends State<ExtendedNavigator<T>> with WidgetsBindingObserver {
  T? router;
  List<Route> _guardedInitialRoutes = [];

  ExtendedNavigatorState? get parent => _parent;

  ExtendedNavigatorState? _parent;
  final List<ExtendedNavigatorState<RouterBase?>> children =
      <ExtendedNavigatorState>[];
  GlobalKey<NavigatorState>? _navigatorKey;

  NavigatorState? get _navigator => _navigatorKey!.currentState;

  bool get isRoot => parent == null;

  WillPopCallback? _willPopCallback;

  ExtendedNavigatorState get root =>
      context.findRootAncestorStateOfType<ExtendedNavigatorState>() ?? this;

  HeroController? _heroController;

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    _navigatorKey = widget.navigatorKey ?? GlobalKey<NavigatorState>();
    _heroController = HeroController(createRectTween: _createRectTween);
    if (_guardedInitialRoutes.isNotEmpty) {
      ambiguate(SchedulerBinding.instance)!.addPostFrameCallback((_) {
        _pushAllGuarded(_guardedInitialRoutes);
      });
    }
  }

  Future<void> _pushAllGuarded(Iterable<Route> routes) async {
    for (var route in routes) {
      var data = (route.settings as RouteDataV1);

      if (data.template == Navigator.defaultRouteName) {
        _navigator!
            .pushAndRemoveUntil(route, RouteDataV1.withPath(data.template));
      } else {
        _navigator!.push(route);
      }
    }
  }

  // On Android: the user has pressed the back button.
  @override
  Future<bool> didPopRoute() async {
    assert(mounted);
    if (_navigator == null) return false;
    return await _navigator!.maybePop();
  }

  @override
  Future<bool> didPushRoute(String route) async {
    assert(mounted);
    if (_navigator == null) return false;
    push(route);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    router = widget.router;
    var initial = widget.initialRoute;
    var initialRouteArgs = widget.initialRouteArgs;
    var basePath;
    var parentData = ParentRouteData.of(context);
    if (router == null && parentData != null) {
      router = parentData.router as T?;
      basePath = parentData.name;
      if (parentData.initialRouteArgs != null) {
        initialRouteArgs = parentData.initialRouteArgs;
      }
    }

    assert(router != null);
    return Navigator(
      key: _navigatorKey,
      initialRoute:
          ambiguate(WidgetsBinding.instance)!.window.defaultRouteName !=
                  Navigator.defaultRouteName
              ? ambiguate(WidgetsBinding.instance)!.window.defaultRouteName
              : initial ??
                  ambiguate(WidgetsBinding.instance)!.window.defaultRouteName,
      observers: List.from(widget.observers)..add(_heroController!),
      onGenerateRoute: (RouteSettings settings) {
        return router!.onGenerateRoute(settings, basePath);
      },
      onUnknownRoute: widget.onUnknownRoute ?? defaultUnknownRoutePage,
      onGenerateInitialRoutes: (NavigatorState navigator, String initialRoute) {
        var initialUri;
        if (parentData != null) {
          if (parentData.initialRoute!.hasEmptyPath) {
            initialUri = parentData.initialRoute!.replace(path: initialRoute);
          } else {
            initialUri = parentData.initialRoute;
          }
        } else {
          initialUri = Uri.parse(initialRoute);
        }
        return ExtendedNavigator._generateInitialRoutes(
          this,
          initialUri,
          initialRouteArgs,
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _parent = context.findAncestorStateOfType<ExtendedNavigatorState>();
    if (_parent != null) {
      _parent!.children.add(this);
    }

    if (routerName != null) {
      _NavigatorsContainer._instance.register(this, name: routerName);
    }
    final modelRoute = ModalRoute.of(context);
    if (modelRoute != null) {
      modelRoute.addScopedWillPopCallback(_willPopCallback = () async {
        return !await _navigator!.maybePop();
      });
    }
  }

  @optionalTypeArgs
  Future<T?>? push<T extends Object>(
    String routeName, {
    Object? arguments,
    Map<String, String>? queryParams,
  }) async {
    return _navigator!
        .pushNamed<T>(_buildPath(routeName, queryParams), arguments: arguments);
  }

  String _buildPath(String routeName, Map<String, String>? queryParams) {
    var uri = Uri.parse(routeName);
    var params = <String, String>{};
    if (queryParams != null) {
      params.addAll(queryParams);
    }
    params.addAll(uri.queryParameters);
    return uri.replace(queryParameters: params).toString();
  }

  @optionalTypeArgs
  Future<T?>? replace<T extends Object, TO extends Object>(
    String routeName, {
    TO? result,
    Object? arguments,
    Map<String, String>? queryParams,
  }) async {
    return _navigator!.pushReplacementNamed<T, TO>(
        _buildPath(routeName, queryParams),
        arguments: arguments,
        result: result);
  }

  @optionalTypeArgs
  Future<T?>? pushAndRemoveUntil<T extends Object>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
    Map<String, String>? queryParams,
  }) async {
    return _navigator!.pushNamedAndRemoveUntil<T>(
      _buildPath(newRouteName, queryParams),
      predicate,
      arguments: arguments,
    );
  }

  @optionalTypeArgs
  Future<T?>? pushAndRemoveUntilPath<T extends Object>(
    String newRouteName,
    String anchorPath, {
    Object? arguments,
    Map<String, String>? queryParams,
  }) {
    return pushAndRemoveUntil(
      newRouteName,
      RouteDataV1.withPath(anchorPath),
      arguments: arguments,
      queryParams: queryParams,
    );
  }

  @optionalTypeArgs
  Future<T?>? popAndPush<T extends Object, TO extends Object>(
    String routeName, {
    TO? result,
    Object? arguments,
    Map<String, String>? queryParams,
  }) {
    pop<TO>(result);
    return push<T>(
      routeName,
      arguments: arguments,
      queryParams: queryParams,
    );
  }

  void popUntilPath(String path) {
    popUntil(RouteDataV1.withPath(path));
  }

  void popUntil(RoutePredicate predicate) {
    _navigator!.popUntil(predicate);
  }

  void popUntilRoot() {
    popUntil((route) => route.isFirst);
  }

  @optionalTypeArgs
  void pop<T extends Object>([T? result]) {
    _navigator!.pop<T>(result);
  }

  Future<bool> maybePop<T extends Object>([T? result]) async {
    return _navigator!.maybePop(result);
  }

  bool canPop() {
    return _navigator!.canPop();
  }

  @override
  void deactivate() {
    if (_willPopCallback != null) {
      ModalRoute.of(context)!.removeScopedWillPopCallback(_willPopCallback!);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (_parent != null) {
      _parent!.children.remove(this);
    }
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);

    if (routerName != null) {
      _NavigatorsContainer._instance.remove(routerName);
    }
    super.dispose();
  }

  String? get routerName {
    if (widget.name != null) {
      return widget.name;
    } else {
      var router = widget.router ?? ParentRouteData.of(context)?.router;
      if (router != null) {
        return router.runtimeType.toString();
      }
    }
    return null;
  }
}

class _NavigatorsContainer {
  // ensure we only have one instance of the container
  static final _NavigatorsContainer _instance = _NavigatorsContainer._();
  final Map<String?, ExtendedNavigatorState> _routers = {};

  _NavigatorsContainer._();

  void register(ExtendedNavigatorState router, {String? name}) {
    _routers[name] = router;
  }

  ExtendedNavigatorState? getRootRouter() {
    if (_routers.isNotEmpty) {
      return _routers.values.first.root;
    }
    return null;
  }

  ExtendedNavigatorState? remove(String? name) {
    return _routers.remove(name);
  }

  ExtendedNavigatorState? get<T extends RouterBase>([String? name]) {
    return _routers[name ?? T.toString()];
  }
}
