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
import 'package:flutter/material.dart' as _i11;
import 'package:stacked/stacked.dart' as _i10;

import '../datamodels/clashable_one.dart' as _i13;
import '../datamodels/clashable_two.dart' as _i15;
import '../datamodels/home_type.dart' as _i14;
import '../datamodels/home_type.dart';
import '../ui/bottom_nav/bottom_nav_example.dart' as _i2;
import '../ui/bottom_nav/favorites/favorites_view.dart' as _i6;
import '../ui/bottom_nav/history/history_view.dart' as _i7;
import '../ui/bottom_nav/profile/profile_view.dart' as _i8;
import '../ui/form/example_form_view.dart' as _i4;
import '../ui/home/home_view.dart' as _i1;
import '../ui/multiple_futures_example/multiple_futures_example_view.dart'
    as _i9;
import '../ui/nonreactive/nonreactive_view.dart' as _i5;
import '../ui/stream_view/stream_counter_view.dart' as _i3;
import 'custom_route_transition.dart' as _i12;

class Navigator2Router extends _i10.RootStackRouter {
  Navigator2Router([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      final args = routeData.argsAs<HomeViewRouteArgs>(
          orElse: () => const HomeViewRouteArgs());
      return _i10.MaterialPageX<dynamic>(
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
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.BottomNavExample(),
        maintainState: false,
      );
    },
    StreamCounterViewRoute.name: (routeData) {
      final args = routeData.argsAs<StreamCounterViewRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.StreamCounterView(
          key: args.key,
          clashableTwo: args.clashableTwo,
        ),
        maintainState: false,
      );
    },
    ExampleFormViewRoute.name: (routeData) {
      final args = routeData.argsAs<ExampleFormViewRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.ExampleFormView(
          key: args.key,
          clashableOne: args.clashableOne,
        ),
        maintainState: false,
      );
    },
    NonReactiveViewRoute.name: (routeData) {
      return _i10.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.NonReactiveView(),
        transitionsBuilder: _i12.CustomRouteTransition.sharedAxis,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FavoritesViewRoute.name: (routeData) {
      final args = routeData.argsAs<FavoritesViewRouteArgs>(
          orElse: () => const FavoritesViewRouteArgs());
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.FavoritesView(
          key: args.key,
          id: args.id,
        ),
        opaque: true,
      );
    },
    HistoryViewRoute.name: (routeData) {
      return _i10.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i7.HistoryView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i10.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i8.ProfileView(),
        maintainState: false,
      );
    },
    MultipleFuturesExampleViewRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.MultipleFuturesExampleView(),
        maintainState: false,
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          HomeViewRoute.name,
          path: '/',
        ),
        _i10.RouteConfig(
          BottomNavExampleRoute.name,
          path: '/bottom-nav-example',
          children: [
            _i10.RouteConfig(
              FavoritesViewRoute.name,
              path: 'favorites-view',
              parent: BottomNavExampleRoute.name,
              children: [
                _i10.RouteConfig(
                  MultipleFuturesExampleViewRoute.name,
                  path: 'multiple-futures-example-view',
                  parent: FavoritesViewRoute.name,
                ),
                _i10.RouteConfig(
                  HistoryViewRoute.name,
                  path: 'history-view',
                  parent: FavoritesViewRoute.name,
                ),
              ],
            ),
            _i10.RouteConfig(
              HistoryViewRoute.name,
              path: 'history-view',
              parent: BottomNavExampleRoute.name,
            ),
            _i10.RouteConfig(
              ProfileViewRoute.name,
              path: 'profile-view',
              parent: BottomNavExampleRoute.name,
            ),
          ],
        ),
        _i10.RouteConfig(
          StreamCounterViewRoute.name,
          path: '/stream-counter-view',
        ),
        _i10.RouteConfig(
          ExampleFormViewRoute.name,
          path: '/example-form-view',
        ),
        _i10.RouteConfig(
          NonReactiveViewRoute.name,
          path: '/non-reactive-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i10.PageRouteInfo<HomeViewRouteArgs> {
  HomeViewRoute({
    _i11.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i13.Clashable Function(String)? clashableGetter,
    List<_i14.HomeType> homeTypes = const [HomeType.apartment, HomeType.house],
  }) : super(
          HomeViewRoute.name,
          path: '/',
          args: HomeViewRouteArgs(
            key: key,
            title: title,
            isLoggedIn: isLoggedIn,
            clashableGetter: clashableGetter,
            homeTypes: homeTypes,
          ),
        );

  static const String name = 'HomeViewRoute';
}

class HomeViewRouteArgs {
  const HomeViewRouteArgs({
    this.key,
    this.title = 'hello',
    this.isLoggedIn = false,
    this.clashableGetter,
    this.homeTypes = const [HomeType.apartment, HomeType.house],
  });

  final _i11.Key? key;

  final String? title;

  final bool? isLoggedIn;

  final _i13.Clashable Function(String)? clashableGetter;

  final List<_i14.HomeType> homeTypes;

  @override
  String toString() {
    return 'HomeViewRouteArgs{key: $key, title: $title, isLoggedIn: $isLoggedIn, clashableGetter: $clashableGetter, homeTypes: $homeTypes}';
  }
}

/// generated route for
/// [_i2.BottomNavExample]
class BottomNavExampleRoute extends _i10.PageRouteInfo<void> {
  const BottomNavExampleRoute({List<_i10.PageRouteInfo>? children})
      : super(
          BottomNavExampleRoute.name,
          path: '/bottom-nav-example',
          initialChildren: children,
        );

  static const String name = 'BottomNavExampleRoute';
}

/// generated route for
/// [_i3.StreamCounterView]
class StreamCounterViewRoute
    extends _i10.PageRouteInfo<StreamCounterViewRouteArgs> {
  StreamCounterViewRoute({
    _i11.Key? key,
    required List<_i15.Clashable> clashableTwo,
  }) : super(
          StreamCounterViewRoute.name,
          path: '/stream-counter-view',
          args: StreamCounterViewRouteArgs(
            key: key,
            clashableTwo: clashableTwo,
          ),
        );

  static const String name = 'StreamCounterViewRoute';
}

class StreamCounterViewRouteArgs {
  const StreamCounterViewRouteArgs({
    this.key,
    required this.clashableTwo,
  });

  final _i11.Key? key;

  final List<_i15.Clashable> clashableTwo;

  @override
  String toString() {
    return 'StreamCounterViewRouteArgs{key: $key, clashableTwo: $clashableTwo}';
  }
}

/// generated route for
/// [_i4.ExampleFormView]
class ExampleFormViewRoute
    extends _i10.PageRouteInfo<ExampleFormViewRouteArgs> {
  ExampleFormViewRoute({
    _i11.Key? key,
    required _i13.Clashable clashableOne,
  }) : super(
          ExampleFormViewRoute.name,
          path: '/example-form-view',
          args: ExampleFormViewRouteArgs(
            key: key,
            clashableOne: clashableOne,
          ),
        );

  static const String name = 'ExampleFormViewRoute';
}

class ExampleFormViewRouteArgs {
  const ExampleFormViewRouteArgs({
    this.key,
    required this.clashableOne,
  });

  final _i11.Key? key;

  final _i13.Clashable clashableOne;

  @override
  String toString() {
    return 'ExampleFormViewRouteArgs{key: $key, clashableOne: $clashableOne}';
  }
}

/// generated route for
/// [_i5.NonReactiveView]
class NonReactiveViewRoute extends _i10.PageRouteInfo<void> {
  const NonReactiveViewRoute()
      : super(
          NonReactiveViewRoute.name,
          path: '/non-reactive-view',
        );

  static const String name = 'NonReactiveViewRoute';
}

/// generated route for
/// [_i6.FavoritesView]
class FavoritesViewRoute extends _i10.PageRouteInfo<FavoritesViewRouteArgs> {
  FavoritesViewRoute({
    _i11.Key? key,
    String? id,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          FavoritesViewRoute.name,
          path: 'favorites-view',
          args: FavoritesViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'FavoritesViewRoute';
}

class FavoritesViewRouteArgs {
  const FavoritesViewRouteArgs({
    this.key,
    this.id,
  });

  final _i11.Key? key;

  final String? id;

  @override
  String toString() {
    return 'FavoritesViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i7.HistoryView]
class HistoryViewRoute extends _i10.PageRouteInfo<void> {
  const HistoryViewRoute()
      : super(
          HistoryViewRoute.name,
          path: 'history-view',
        );

  static const String name = 'HistoryViewRoute';
}

/// generated route for
/// [_i8.ProfileView]
class ProfileViewRoute extends _i10.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: 'profile-view',
        );

  static const String name = 'ProfileViewRoute';
}

/// generated route for
/// [_i9.MultipleFuturesExampleView]
class MultipleFuturesExampleViewRoute extends _i10.PageRouteInfo<void> {
  const MultipleFuturesExampleViewRoute()
      : super(
          MultipleFuturesExampleViewRoute.name,
          path: 'multiple-futures-example-view',
        );

  static const String name = 'MultipleFuturesExampleViewRoute';
}
