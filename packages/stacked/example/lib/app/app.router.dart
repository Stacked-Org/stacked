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
import 'package:flutter/material.dart' as _i12;
import 'package:stacked/stacked.dart' as _i11;

import '../datamodels/clashable_one.dart' as _i14;
import '../datamodels/clashable_two.dart' as _i15;
import '../datamodels/home_type.dart' as _i2;
import '../ui/bottom_nav/bottom_nav_example.dart' as _i3;
import '../ui/bottom_nav/favorites/favorites_view.dart' as _i7;
import '../ui/bottom_nav/history/history_view.dart' as _i8;
import '../ui/bottom_nav/profile/profile_view.dart' as _i9;
import '../ui/form/example_form_view.dart' as _i5;
import '../ui/home/home_view.dart' as _i1;
import '../ui/multiple_futures_example/multiple_futures_example_view.dart'
    as _i10;
import '../ui/nonreactive/nonreactive_view.dart' as _i6;
import '../ui/stream_view/stream_counter_view.dart' as _i4;
import 'custom_route_transition.dart' as _i13;

class Navigator2Router extends _i11.RootStackRouter {
  Navigator2Router([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeViewArgs>(orElse: () => const HomeViewArgs());
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.HomeView(
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
    FavoritesViewRoute.name: (routeData) {
      final args = routeData.argsAs<FavoritesViewArgs>(
          orElse: () => const FavoritesViewArgs());
      return _i11.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.FavoritesView(
          key: args.key,
          id: args.id,
        ),
        opaque: true,
      );
    },
    HistoryViewRoute.name: (routeData) {
      return _i11.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i8.HistoryView(),
        opaque: true,
        barrierDismissible: false,
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
              HistoryViewRoute.name,
              path: 'nullhistory-view',
              parent: BottomNavExampleRoute.name,
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
/// [_i1.HomeView]
class HomeViewRoute extends _i11.PageRouteInfo<HomeViewArgs> {
  HomeViewRoute({
    _i12.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i14.Clashable Function(String)? clashableGetter,
    List<_i2.HomeType> homeTypes = const [
      _i2.HomeType.apartment,
      _i2.HomeType.house
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
    this.homeTypes = const [_i2.HomeType.apartment, _i2.HomeType.house],
  });

  final _i12.Key? key;

  final String? title;

  final bool? isLoggedIn;

  final _i14.Clashable Function(String)? clashableGetter;

  final List<_i2.HomeType> homeTypes;

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
/// [_i7.FavoritesView]
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
/// [_i8.HistoryView]
class HistoryViewRoute extends _i11.PageRouteInfo<void> {
  const HistoryViewRoute()
      : super(
          HistoryViewRoute.name,
          path: 'nullhistory-view',
        );

  static const String name = 'HistoryView';
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

class BottomNavExampleRoutes {
  static const favoritesView = 'nullfavorites-view';

  static const historyView = 'nullhistory-view';

  static const profileView = 'nullprofile-view';

  static const all = <String>{
    favoritesView,
    historyView,
    profileView,
  };
}

class FavoritesViewRoutes {
  static const multipleFuturesExampleView = 'nullmultiple-futures-example-view';

  static const historyView = 'nullhistory-view';

  static const all = <String>{
    multipleFuturesExampleView,
    historyView,
  };
}
