// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i13;
import 'package:stacked/stacked.dart' as _i12;
import 'package:stacked_services/stacked_services.dart' as _i11;

import '../datamodels/clashable_one.dart' as _i15;
import '../datamodels/clashable_two.dart' as _i16;
import '../datamodels/home_type.dart' as _i1;
import '../ui/bottom_nav/bottom_nav_example.dart' as _i3;
import '../ui/bottom_nav/favorites/favorites_view.dart' as _i7;
import '../ui/bottom_nav/history/history_view.dart' as _i8;
import '../ui/bottom_nav/profile/profile_view.dart' as _i9;
import '../ui/form/example_form_view.dart' as _i5;
import '../ui/home/home_view.dart' as _i2;
import '../ui/multiple_futures_example/multiple_futures_example_view.dart'
    as _i10;
import '../ui/nonreactive/nonreactive_view.dart' as _i6;
import '../ui/stream_view/stream_counter_view.dart' as _i4;
import 'custom_route_transition.dart' as _i14;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i11.StackedService.navigatorKey);

class StackedRouterWeb extends _i12.RootStackRouter {
  StackedRouterWeb({_i13.GlobalKey<_i13.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeViewArgs>(orElse: () => const HomeViewArgs());
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.HomeView(
          key: args.key,
          title: args.title,
          isLoggedIn: args.isLoggedIn,
          clashableGetter: args.clashableGetter,
          homeTypes: args.homeTypes,
        ),
      );
    },
    BottomNavExampleRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.BottomNavExample(),
      );
    },
    StreamCounterViewRoute.name: (routeData) {
      final args = routeData.argsAs<StreamCounterViewArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.StreamCounterView(
          key: args.key,
          clashableTwo: args.clashableTwo,
        ),
      );
    },
    ExampleFormViewRoute.name: (routeData) {
      final args = routeData.argsAs<ExampleFormViewArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.ExampleFormView(
          key: args.key,
          clashableOne: args.clashableOne,
        ),
      );
    },
    NonReactiveViewRoute.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.NonReactiveView(),
        transitionsBuilder: _i14.CustomRouteTransition.sharedAxis,
        opaque: true,
        barrierDismissible: false,
      );
    },
    FavoritesViewRoute.name: (routeData) {
      final args = routeData.argsAs<FavoritesViewArgs>(
          orElse: () => const FavoritesViewArgs());
      return _i12.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.FavoritesView(
          key: args.key,
          id: args.id,
        ),
        opaque: true,
      );
    },
    HistoryViewRoute.name: (routeData) {
      return _i12.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i8.HistoryView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileViewRoute.name: (routeData) {
      return _i12.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ProfileView(),
      );
    },
    MultipleFuturesExampleViewRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.MultipleFuturesExampleView(),
      );
    },
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(
          HomeViewRoute.name,
          path: '/',
        ),
        _i12.RouteConfig(
          BottomNavExampleRoute.name,
          path: '/bottom-nav-example',
          children: [
            _i12.RouteConfig(
              '#redirect',
              path: '',
              parent: BottomNavExampleRoute.name,
              redirectTo: 'favorites',
              fullMatch: true,
            ),
            _i12.RouteConfig(
              FavoritesViewRoute.name,
              path: 'favourites',
              parent: BottomNavExampleRoute.name,
              children: [
                _i12.RouteConfig(
                  MultipleFuturesExampleViewRoute.name,
                  path: 'multiple-futures-example-view',
                  parent: FavoritesViewRoute.name,
                ),
                _i12.RouteConfig(
                  HistoryViewRoute.name,
                  path: 'history-view',
                  parent: FavoritesViewRoute.name,
                ),
              ],
            ),
            _i12.RouteConfig(
              HistoryViewRoute.name,
              path: 'history-view',
              parent: BottomNavExampleRoute.name,
            ),
            _i12.RouteConfig(
              ProfileViewRoute.name,
              path: 'profile-view',
              parent: BottomNavExampleRoute.name,
            ),
          ],
        ),
        _i12.RouteConfig(
          StreamCounterViewRoute.name,
          path: '/stream-counter-view',
        ),
        _i12.RouteConfig(
          ExampleFormViewRoute.name,
          path: '/example-form-view',
        ),
        _i12.RouteConfig(
          NonReactiveViewRoute.name,
          path: '/non-reactive-view',
        ),
      ];
}

/// generated route for
/// [_i2.HomeView]
class HomeViewRoute extends _i12.PageRouteInfo<HomeViewArgs> {
  HomeViewRoute({
    _i13.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i15.Clashable Function(String)? clashableGetter,
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

  final _i13.Key? key;

  final String? title;

  final bool? isLoggedIn;

  final _i15.Clashable Function(String)? clashableGetter;

  final List<_i1.HomeType> homeTypes;

  @override
  String toString() {
    return 'HomeViewArgs{key: $key, title: $title, isLoggedIn: $isLoggedIn, clashableGetter: $clashableGetter, homeTypes: $homeTypes}';
  }
}

/// generated route for
/// [_i3.BottomNavExample]
class BottomNavExampleRoute extends _i12.PageRouteInfo<void> {
  const BottomNavExampleRoute({List<_i12.PageRouteInfo>? children})
      : super(
          BottomNavExampleRoute.name,
          path: '/bottom-nav-example',
          initialChildren: children,
        );

  static const String name = 'BottomNavExample';
}

/// generated route for
/// [_i4.StreamCounterView]
class StreamCounterViewRoute extends _i12.PageRouteInfo<StreamCounterViewArgs> {
  StreamCounterViewRoute({
    _i13.Key? key,
    required List<_i16.Clashable> clashableTwo,
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

  final _i13.Key? key;

  final List<_i16.Clashable> clashableTwo;

  @override
  String toString() {
    return 'StreamCounterViewArgs{key: $key, clashableTwo: $clashableTwo}';
  }
}

/// generated route for
/// [_i5.ExampleFormView]
class ExampleFormViewRoute extends _i12.PageRouteInfo<ExampleFormViewArgs> {
  ExampleFormViewRoute({
    _i13.Key? key,
    required _i15.Clashable clashableOne,
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

  final _i13.Key? key;

  final _i15.Clashable clashableOne;

  @override
  String toString() {
    return 'ExampleFormViewArgs{key: $key, clashableOne: $clashableOne}';
  }
}

/// generated route for
/// [_i6.NonReactiveView]
class NonReactiveViewRoute extends _i12.PageRouteInfo<void> {
  const NonReactiveViewRoute()
      : super(
          NonReactiveViewRoute.name,
          path: '/non-reactive-view',
        );

  static const String name = 'NonReactiveView';
}

/// generated route for
/// [_i7.FavoritesView]
class FavoritesViewRoute extends _i12.PageRouteInfo<FavoritesViewArgs> {
  FavoritesViewRoute({
    _i13.Key? key,
    String? id,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          FavoritesViewRoute.name,
          path: 'favourites',
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

  final _i13.Key? key;

  final String? id;

  @override
  String toString() {
    return 'FavoritesViewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i8.HistoryView]
class HistoryViewRoute extends _i12.PageRouteInfo<void> {
  const HistoryViewRoute()
      : super(
          HistoryViewRoute.name,
          path: 'history-view',
        );

  static const String name = 'HistoryView';
}

/// generated route for
/// [_i9.ProfileView]
class ProfileViewRoute extends _i12.PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: 'profile-view',
        );

  static const String name = 'ProfileView';
}

/// generated route for
/// [_i10.MultipleFuturesExampleView]
class MultipleFuturesExampleViewRoute extends _i12.PageRouteInfo<void> {
  const MultipleFuturesExampleViewRoute()
      : super(
          MultipleFuturesExampleViewRoute.name,
          path: 'multiple-futures-example-view',
        );

  static const String name = 'MultipleFuturesExampleView';
}

extension RouterStateExtension on _i11.RouterService {
  Future<dynamic> navigateToHomeView({
    _i13.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i15.Clashable Function(String)? clashableGetter,
    List<_i1.HomeType> homeTypes = const [
      _i1.HomeType.apartment,
      _i1.HomeType.house
    ],
    void Function(_i12.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      HomeViewRoute(
        key: key,
        title: title,
        isLoggedIn: isLoggedIn,
        clashableGetter: clashableGetter,
        homeTypes: homeTypes,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToBottomNavExample(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const BottomNavExampleRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToStreamCounterView({
    _i13.Key? key,
    required List<_i16.Clashable> clashableTwo,
    void Function(_i12.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      StreamCounterViewRoute(
        key: key,
        clashableTwo: clashableTwo,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToExampleFormView({
    _i13.Key? key,
    required _i15.Clashable clashableOne,
    void Function(_i12.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      ExampleFormViewRoute(
        key: key,
        clashableOne: clashableOne,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToNonReactiveView(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const NonReactiveViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToFavoritesView({
    _i13.Key? key,
    String? id,
    void Function(_i12.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      FavoritesViewRoute(
        key: key,
        id: id,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToHistoryView(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HistoryViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileView(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToMultipleFuturesExampleView(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const MultipleFuturesExampleViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView({
    _i13.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i15.Clashable Function(String)? clashableGetter,
    List<_i1.HomeType> homeTypes = const [
      _i1.HomeType.apartment,
      _i1.HomeType.house
    ],
    void Function(_i12.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      HomeViewRoute(
        key: key,
        title: title,
        isLoggedIn: isLoggedIn,
        clashableGetter: clashableGetter,
        homeTypes: homeTypes,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithBottomNavExample(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const BottomNavExampleRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStreamCounterView({
    _i13.Key? key,
    required List<_i16.Clashable> clashableTwo,
    void Function(_i12.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      StreamCounterViewRoute(
        key: key,
        clashableTwo: clashableTwo,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithExampleFormView({
    _i13.Key? key,
    required _i15.Clashable clashableOne,
    void Function(_i12.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      ExampleFormViewRoute(
        key: key,
        clashableOne: clashableOne,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithNonReactiveView(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const NonReactiveViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithFavoritesView({
    _i13.Key? key,
    String? id,
    void Function(_i12.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      FavoritesViewRoute(
        key: key,
        id: id,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHistoryView(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HistoryViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileView(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithMultipleFuturesExampleView(
      {void Function(_i12.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const MultipleFuturesExampleViewRoute(),
      onFailure: onFailure,
    );
  }
}
