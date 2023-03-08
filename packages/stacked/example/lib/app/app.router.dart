// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i16;
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i11;
import 'package:stacked_services/stacked_services.dart' as _i17;

import '../datamodels/clashable_one.dart' as _i14;
import '../datamodels/clashable_two.dart' as _i15;
import '../datamodels/home_type.dart' as _i1;
import '../ui/bottom_nav/bottom_nav_example.dart' as _i3;
import '../ui/bottom_nav/favorites/favorites_view.dart' as _i8;
import '../ui/bottom_nav/history/history_view.dart' as _i7;
import '../ui/bottom_nav/profile/profile_view.dart' as _i9;
import '../ui/form/example_form_view.dart' as _i5;
import '../ui/home/home_view.dart' as _i2;
import '../ui/multiple_futures_example/multiple_futures_example_view.dart'
    as _i10;
import '../ui/nonreactive/nonreactive_view.dart' as _i6;
import '../ui/stream_view/stream_counter_view.dart' as _i4;
import 'custom_route_transition.dart' as _i13;

class StackedRouterWeb extends _i11.RootStackRouter {
  StackedRouterWeb([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeViewArgs>(orElse: () => const HomeViewArgs());
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.HomeView(
          key: args.key,
          title: args.title,
          isLoggedIn: args.isLoggedIn,
          clashableGetter: args.clashableGetter,
          homeTypes: args.homeTypes,
        ),
        maintainState: false,
      );
    },
    BottomNavExampleRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.BottomNavExample(),
        maintainState: false,
      );
    },
    StreamCounterViewRoute.name: (routeData) {
      final args = routeData.argsAs<StreamCounterViewArgs>();
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.StreamCounterView(
          key: args.key,
          clashableTwo: args.clashableTwo,
        ),
        maintainState: false,
      );
    },
    ExampleFormViewRoute.name: (routeData) {
      final args = routeData.argsAs<ExampleFormViewArgs>();
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.ExampleFormView(
          key: args.key,
          clashableOne: args.clashableOne,
        ),
        maintainState: false,
      );
    },
    NonReactiveViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.NonReactiveView(),
        transitionsBuilder: _i13.CustomRouteTransition.sharedAxis,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HistoryViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.HistoryView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    FavoritesViewRoute.name: (routeData) {
      final args = routeData.argsAs<FavoritesViewArgs>(
          orElse: () => const FavoritesViewArgs());
      return _i11.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.FavoritesView(
          key: args.key,
          id: args.id,
        ),
        opaque: true,
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i11.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ProfileView(),
        maintainState: false,
      );
    },
    MultipleFuturesExampleViewRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.MultipleFuturesExampleView(),
        maintainState: false,
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          HomeViewRoute.name,
          path: '/',
        ),
        _i11.RouteConfig(
          BottomNavExampleRoute.name,
          path: '/bottom-nav-example',
          children: [
            _i11.RouteConfig(
              HistoryViewRoute.name,
              path: 'nullhistory-view',
              parent: BottomNavExampleRoute.name,
            ),
            _i11.RouteConfig(
              FavoritesViewRoute.name,
              path: 'nullfavorites-view',
              parent: BottomNavExampleRoute.name,
              children: [
                _i11.RouteConfig(
                  MultipleFuturesExampleViewRoute.name,
                  path: 'nullmultiple-futures-example-view',
                  parent: FavoritesViewRoute.name,
                ),
                _i11.RouteConfig(
                  HistoryViewRoute.name,
                  path: 'nullhistory-view',
                  parent: FavoritesViewRoute.name,
                ),
              ],
            ),
            _i11.RouteConfig(
              ProfileViewRoute.name,
              path: 'nullprofile-view',
              parent: BottomNavExampleRoute.name,
            ),
          ],
        ),
        _i11.RouteConfig(
          StreamCounterViewRoute.name,
          path: '/stream-counter-view',
        ),
        _i11.RouteConfig(
          ExampleFormViewRoute.name,
          path: '/example-form-view',
        ),
        _i11.RouteConfig(
          NonReactiveViewRoute.name,
          path: '/non-reactive-view',
        ),
      ];
}

/// generated route for
/// [_i2.HomeView]
class HomeViewRoute extends _i11.PageRouteInfo<HomeViewArgs> {
  HomeViewRoute({
    _i12.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i14.Clashable Function(String)? clashableGetter,
    List<_i1.HomeType> homeTypes = const [
      _i1.HomeType.apartment,
      _i1.HomeType.house
    ],
  }) : super(
          HomeViewRoute.name,
          path: '/',
          args: HomeViewArgs(
            key: key,
            title: title,
            isLoggedIn: isLoggedIn,
            clashableGetter: clashableGetter,
            homeTypes: homeTypes,
          ),
        );

  static const String name = 'HomeView';
}

class HomeViewArgs {
  const HomeViewArgs({
    this.key,
    this.title = 'hello',
    this.isLoggedIn = false,
    this.clashableGetter,
    this.homeTypes = const [_i1.HomeType.apartment, _i1.HomeType.house],
  });

  final _i12.Key? key;

  final String? title;

  final bool? isLoggedIn;

  final _i14.Clashable Function(String)? clashableGetter;

  final List<_i1.HomeType> homeTypes;

  @override
  String toString() {
    return 'HomeViewArgs{key: $key, title: $title, isLoggedIn: $isLoggedIn, clashableGetter: $clashableGetter, homeTypes: $homeTypes}';
  }
}

/// generated route for
/// [_i3.BottomNavExample]
class BottomNavExampleRoute extends _i11.PageRouteInfo<void> {
  const BottomNavExampleRoute({List<_i11.PageRouteInfo>? children})
      : super(
          BottomNavExampleRoute.name,
          path: '/bottom-nav-example',
          initialChildren: children,
        );

  static const String name = 'BottomNavExample';
}

/// generated route for
/// [_i4.StreamCounterView]
class StreamCounterViewRoute extends _i11.PageRouteInfo<StreamCounterViewArgs> {
  StreamCounterViewRoute({
    _i12.Key? key,
    required List<_i15.Clashable> clashableTwo,
  }) : super(
          StreamCounterViewRoute.name,
          path: '/stream-counter-view',
          args: StreamCounterViewArgs(
            key: key,
            clashableTwo: clashableTwo,
          ),
        );

  static const String name = 'StreamCounterView';
}

class StreamCounterViewArgs {
  const StreamCounterViewArgs({
    this.key,
    required this.clashableTwo,
  });

  final _i12.Key? key;

  final List<_i15.Clashable> clashableTwo;

  @override
  String toString() {
    return 'StreamCounterViewArgs{key: $key, clashableTwo: $clashableTwo}';
  }
}

/// generated route for
/// [_i5.ExampleFormView]
class ExampleFormViewRoute extends _i11.PageRouteInfo<ExampleFormViewArgs> {
  ExampleFormViewRoute({
    _i12.Key? key,
    required _i14.Clashable clashableOne,
  }) : super(
          ExampleFormViewRoute.name,
          path: '/example-form-view',
          args: ExampleFormViewArgs(
            key: key,
            clashableOne: clashableOne,
          ),
        );

  static const String name = 'ExampleFormView';
}

class ExampleFormViewArgs {
  const ExampleFormViewArgs({
    this.key,
    required this.clashableOne,
  });

  final _i12.Key? key;

  final _i14.Clashable clashableOne;

  @override
  String toString() {
    return 'ExampleFormViewArgs{key: $key, clashableOne: $clashableOne}';
  }
}

/// generated route for
/// [_i6.NonReactiveView]
class NonReactiveViewRoute extends _i11.PageRouteInfo<void> {
  const NonReactiveViewRoute()
      : super(
          NonReactiveViewRoute.name,
          path: '/non-reactive-view',
        );

  static const String name = 'NonReactiveView';
}

/// generated route for
/// [_i7.HistoryView]
class HistoryViewRoute extends _i11.PageRouteInfo<void> {
  const HistoryViewRoute()
      : super(
          HistoryViewRoute.name,
          path: 'nullhistory-view',
        );

  static const String name = 'HistoryView';
}

/// generated route for
/// [_i8.FavoritesView]
class FavoritesViewRoute extends _i11.PageRouteInfo<FavoritesViewArgs> {
  FavoritesViewRoute({
    _i12.Key? key,
    String? id,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          FavoritesViewRoute.name,
          path: 'nullfavorites-view',
          args: FavoritesViewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'FavoritesView';
}

class FavoritesViewArgs {
  const FavoritesViewArgs({
    this.key,
    this.id,
  });

  final _i12.Key? key;

  final String? id;

  @override
  String toString() {
    return 'FavoritesViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i9.ProfileView]
class ProfileViewRoute extends _i11.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: 'nullprofile-view',
        );

  static const String name = 'ProfileView';
}

/// generated route for
/// [_i10.MultipleFuturesExampleView]
class MultipleFuturesExampleViewRoute extends _i11.PageRouteInfo<void> {
  const MultipleFuturesExampleViewRoute()
      : super(
          MultipleFuturesExampleViewRoute.name,
          path: 'nullmultiple-futures-example-view',
        );

  static const String name = 'MultipleFuturesExampleView';
}

class Routes {
  static const homeView = '/';

  static const bottomNavExample = '/bottom-nav-example';

  static const streamCounterView = '/stream-counter-view';

  static const exampleFormView = '/example-form-view';

  static const nonReactiveView = '/non-reactive-view';

  static const all = <String>{
    homeView,
    bottomNavExample,
    streamCounterView,
    exampleFormView,
    nonReactiveView,
  };
}

class StackedRouter extends _i11.RouterBase {
  final _routes = <_i11.RouteDef>[
    _i11.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i11.RouteDef(
      Routes.bottomNavExample,
      page: _i3.BottomNavExample,
    ),
    _i11.RouteDef(
      Routes.streamCounterView,
      page: _i4.StreamCounterView,
    ),
    _i11.RouteDef(
      Routes.exampleFormView,
      page: _i5.ExampleFormView,
    ),
    _i11.RouteDef(
      Routes.nonReactiveView,
      page: _i6.NonReactiveView,
    ),
  ];

  final _pagesMap = <Type, _i11.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.HomeView(
            key: args.key,
            title: args.title,
            isLoggedIn: args.isLoggedIn,
            clashableGetter: args.clashableGetter,
            homeTypes: args.homeTypes),
        settings: data,
        maintainState: false,
      );
    },
    _i3.BottomNavExample: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.BottomNavExample(),
        settings: data,
        maintainState: false,
      );
    },
    _i4.StreamCounterView: (data) {
      final args = data.getArgs<StreamCounterViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.StreamCounterView(
            key: args.key, clashableTwo: args.clashableTwo),
        settings: data,
        maintainState: false,
      );
    },
    _i5.ExampleFormView: (data) {
      final args = data.getArgs<ExampleFormViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.ExampleFormView(key: args.key, clashableOne: args.clashableOne),
        settings: data,
        maintainState: false,
      );
    },
    _i6.NonReactiveView: (data) {
      return _i12.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i6.NonReactiveView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i13.CustomRouteTransition.sharedAxis,
      );
    },
  };

  @override
  List<_i11.RouteDef> get routes => _routes;
  @override
  Map<Type, _i11.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({
    this.key,
    this.title = 'hello',
    this.isLoggedIn = false,
    this.clashableGetter,
    this.homeTypes = const [_i1.HomeType.apartment, _i1.HomeType.house],
  });

  final _i12.Key? key;

  final String? title;

  final bool? isLoggedIn;

  final _i14.Clashable Function(String)? clashableGetter;

  final List<_i1.HomeType> homeTypes;

  @override
  String toString() {
    return '{"key": "$key", "title": "$title", "isLoggedIn": "$isLoggedIn", "clashableGetter": "$clashableGetter", "homeTypes": "$homeTypes"}';
  }
}

class StreamCounterViewArguments {
  const StreamCounterViewArguments({
    this.key,
    required this.clashableTwo,
  });

  final _i12.Key? key;

  final List<_i15.Clashable> clashableTwo;

  @override
  String toString() {
    return '{"key": "$key", "clashableTwo": "$clashableTwo"}';
  }
}

class ExampleFormViewArguments {
  const ExampleFormViewArguments({
    this.key,
    required this.clashableOne,
  });

  final _i12.Key? key;

  final _i14.Clashable clashableOne;

  @override
  String toString() {
    return '{"key": "$key", "clashableOne": "$clashableOne"}';
  }
}

class BottomNavExampleRoutes {
  static const historyView = 'nullhistory-view';

  static const favoritesView = 'nullfavorites-view';

  static const profileView = 'nullprofile-view';

  static const all = <String>{
    historyView,
    favoritesView,
    profileView,
  };
}

class BottomNavExampleRouter extends _i11.RouterBase {
  final _routes = <_i11.RouteDef>[
    _i11.RouteDef(
      BottomNavExampleRoutes.historyView,
      page: _i7.HistoryView,
    ),
    _i11.RouteDef(
      BottomNavExampleRoutes.favoritesView,
      page: _i8.FavoritesView,
    ),
    _i11.RouteDef(
      BottomNavExampleRoutes.profileView,
      page: _i9.ProfileView,
    ),
  ];

  final _pagesMap = <Type, _i11.StackedRouteFactory>{
    _i7.HistoryView: (data) {
      return _i12.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i7.HistoryView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i11.TransitionsBuilders.fadeIn,
      );
    },
    _i8.FavoritesView: (data) {
      final args = data.getArgs<FavoritesViewArguments>(
        orElse: () => const FavoritesViewArguments(),
      );
      return _i11.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i8.FavoritesView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i9.ProfileView: (data) {
      return _i16.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i9.ProfileView(),
        settings: data,
        maintainState: false,
      );
    },
  };

  @override
  List<_i11.RouteDef> get routes => _routes;
  @override
  Map<Type, _i11.StackedRouteFactory> get pagesMap => _pagesMap;
}

class FavoritesViewArguments {
  const FavoritesViewArguments({
    this.key,
    this.id,
  });

  final _i12.Key? key;

  final String? id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }
}

class FavoritesViewRoutes {
  static const multipleFuturesExampleView = 'nullmultiple-futures-example-view';

  static const historyView = 'nullhistory-view';

  static const all = <String>{
    multipleFuturesExampleView,
    historyView,
  };
}

class FavoritesViewRouter extends _i11.RouterBase {
  final _routes = <_i11.RouteDef>[
    _i11.RouteDef(
      FavoritesViewRoutes.multipleFuturesExampleView,
      page: _i10.MultipleFuturesExampleView,
    ),
    _i11.RouteDef(
      FavoritesViewRoutes.historyView,
      page: _i7.HistoryView,
    ),
  ];

  final _pagesMap = <Type, _i11.StackedRouteFactory>{
    _i10.MultipleFuturesExampleView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.MultipleFuturesExampleView(),
        settings: data,
        maintainState: false,
      );
    },
    _i7.HistoryView: (data) {
      return _i12.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i7.HistoryView(),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    },
  };

  @override
  List<_i11.RouteDef> get routes => _routes;
  @override
  Map<Type, _i11.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i17.NavigationService {
  Future<dynamic> navigateToHomeView({
    _i12.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i14.Clashable Function(String)? clashableGetter,
    List<_i1.HomeType> homeTypes = const [
      _i1.HomeType.apartment,
      _i1.HomeType.house
    ],
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(
            key: key,
            title: title,
            isLoggedIn: isLoggedIn,
            clashableGetter: clashableGetter,
            homeTypes: homeTypes),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBottomNavExample([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.bottomNavExample,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStreamCounterView({
    _i12.Key? key,
    required List<_i15.Clashable> clashableTwo,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.streamCounterView,
        arguments:
            StreamCounterViewArguments(key: key, clashableTwo: clashableTwo),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExampleFormView({
    _i12.Key? key,
    required _i14.Clashable clashableOne,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.exampleFormView,
        arguments:
            ExampleFormViewArguments(key: key, clashableOne: clashableOne),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNonReactiveView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.nonReactiveView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView({
    _i12.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i14.Clashable Function(String)? clashableGetter,
    List<_i1.HomeType> homeTypes = const [
      _i1.HomeType.apartment,
      _i1.HomeType.house
    ],
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(
            key: key,
            title: title,
            isLoggedIn: isLoggedIn,
            clashableGetter: clashableGetter,
            homeTypes: homeTypes),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBottomNavExample([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.bottomNavExample,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStreamCounterView({
    _i12.Key? key,
    required List<_i15.Clashable> clashableTwo,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.streamCounterView,
        arguments:
            StreamCounterViewArguments(key: key, clashableTwo: clashableTwo),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExampleFormView({
    _i12.Key? key,
    required _i14.Clashable clashableOne,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.exampleFormView,
        arguments:
            ExampleFormViewArguments(key: key, clashableOne: clashableOne),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNonReactiveView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.nonReactiveView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
