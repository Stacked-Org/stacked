// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/app/custom_route_transition.dart' as _i9;
import 'package:example/datamodels/clashable_one.dart' as _i10;
import 'package:example/datamodels/clashable_two.dart' as _i11;
import 'package:example/datamodels/home_type.dart' as _i1;
import 'package:example/ui/bottom_nav/bottom_nav_example.dart' as _i4;
import 'package:example/ui/bottom_nav/favorites/favorites_view.dart' as _i13;
import 'package:example/ui/bottom_nav/history/history_view.dart' as _i12;
import 'package:example/ui/bottom_nav/profile/profile_view.dart' as _i14;
import 'package:example/ui/form/example_form_view.dart' as _i6;
import 'package:example/ui/home/home_view.dart' as _i3;
import 'package:example/ui/multiple_futures_example/multiple_futures_example_view.dart'
    as _i16;
import 'package:example/ui/nonreactive/nonreactive_view.dart' as _i7;
import 'package:example/ui/stream_view/stream_counter_view.dart' as _i5;
import 'package:flutter/cupertino.dart' as _i15;
import 'package:flutter/material.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i17;

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

class StackedRouter extends _i2.RouterBase {
  final _routes = <_i2.RouteDef>[
    _i2.RouteDef(Routes.homeView, page: _i3.HomeView),
    _i2.RouteDef(Routes.bottomNavExample, page: _i4.BottomNavExample),
    _i2.RouteDef(Routes.streamCounterView, page: _i5.StreamCounterView),
    _i2.RouteDef(Routes.exampleFormView, page: _i6.ExampleFormView),
    _i2.RouteDef(Routes.nonReactiveView, page: _i7.NonReactiveView),
  ];

  final _pagesMap = <Type, _i2.StackedRouteFactory>{
    _i3.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.HomeView(
          key: args.key,
          title: args.title,
          isLoggedIn: args.isLoggedIn,
          clashableGetter: args.clashableGetter,
          homeTypes: args.homeTypes,
        ),
        settings: data,
      );
    },
    _i4.BottomNavExample: (data) {
      final args = data.getArgs<BottomNavExampleArguments>(
        orElse: () => const BottomNavExampleArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.BottomNavExample(key: args.key),
        settings: data,
      );
    },
    _i5.StreamCounterView: (data) {
      final args = data.getArgs<StreamCounterViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.StreamCounterView(
          key: args.key,
          clashableTwo: args.clashableTwo,
        ),
        settings: data,
      );
    },
    _i6.ExampleFormView: (data) {
      final args = data.getArgs<ExampleFormViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.ExampleFormView(key: args.key, clashableOne: args.clashableOne),
        settings: data,
      );
    },
    _i7.NonReactiveView: (data) {
      final args = data.getArgs<NonReactiveViewArguments>(
        orElse: () => const NonReactiveViewArguments(),
      );
      return _i8.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i7.NonReactiveView(key: args.key),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i9.CustomRouteTransition.sharedAxis,
      );
    },
  };

  @override
  List<_i2.RouteDef> get routes => _routes;

  @override
  Map<Type, _i2.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({
    this.key,
    this.title = 'hello',
    this.isLoggedIn = false,
    this.clashableGetter,
    this.homeTypes = const [_i1.HomeType.apartment, _i1.HomeType.house],
  });

  final _i8.Key? key;

  final String? title;

  final bool? isLoggedIn;

  final _i10.Clashable Function(String)? clashableGetter;

  final List<_i1.HomeType> homeTypes;

  @override
  String toString() {
    return '{"key": "$key", "title": "$title", "isLoggedIn": "$isLoggedIn", "clashableGetter": "$clashableGetter", "homeTypes": "$homeTypes"}';
  }

  @override
  bool operator ==(covariant HomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.title == title &&
        other.isLoggedIn == isLoggedIn &&
        other.clashableGetter == clashableGetter &&
        other.homeTypes == homeTypes;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        title.hashCode ^
        isLoggedIn.hashCode ^
        clashableGetter.hashCode ^
        homeTypes.hashCode;
  }
}

class BottomNavExampleArguments {
  const BottomNavExampleArguments({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant BottomNavExampleArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StreamCounterViewArguments {
  const StreamCounterViewArguments({this.key, required this.clashableTwo});

  final _i8.Key? key;

  final List<_i11.Clashable> clashableTwo;

  @override
  String toString() {
    return '{"key": "$key", "clashableTwo": "$clashableTwo"}';
  }

  @override
  bool operator ==(covariant StreamCounterViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.clashableTwo == clashableTwo;
  }

  @override
  int get hashCode {
    return key.hashCode ^ clashableTwo.hashCode;
  }
}

class ExampleFormViewArguments {
  const ExampleFormViewArguments({this.key, required this.clashableOne});

  final _i8.Key? key;

  final _i10.Clashable clashableOne;

  @override
  String toString() {
    return '{"key": "$key", "clashableOne": "$clashableOne"}';
  }

  @override
  bool operator ==(covariant ExampleFormViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.clashableOne == clashableOne;
  }

  @override
  int get hashCode {
    return key.hashCode ^ clashableOne.hashCode;
  }
}

class NonReactiveViewArguments {
  const NonReactiveViewArguments({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant NonReactiveViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class BottomNavExampleRoutes {
  static const historyView = 'history-view';

  static const favoritesView = 'favorites-view';

  static const profileView = 'profile-view';

  static const all = <String>{historyView, favoritesView, profileView};
}

class BottomNavExampleRouter extends _i2.RouterBase {
  final _routes = <_i2.RouteDef>[
    _i2.RouteDef(BottomNavExampleRoutes.historyView, page: _i12.HistoryView),
    _i2.RouteDef(
      BottomNavExampleRoutes.favoritesView,
      page: _i13.FavoritesView,
    ),
    _i2.RouteDef(BottomNavExampleRoutes.profileView, page: _i14.ProfileView),
  ];

  final _pagesMap = <Type, _i2.StackedRouteFactory>{
    _i12.HistoryView: (data) {
      final args = data.getArgs<NestedHistoryViewArguments>(
        orElse: () => const NestedHistoryViewArguments(),
      );
      return _i8.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i12.HistoryView(key: args.key),
        settings: data,
        transitionsBuilder: data.transition ?? _i2.TransitionsBuilders.fadeIn,
      );
    },
    _i13.FavoritesView: (data) {
      final args = data.getArgs<FavoritesViewArguments>(
        orElse: () => const FavoritesViewArguments(),
      );
      return _i2.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i13.FavoritesView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i14.ProfileView: (data) {
      final args = data.getArgs<NestedProfileViewArguments>(
        orElse: () => const NestedProfileViewArguments(),
      );
      return _i15.CupertinoPageRoute<dynamic>(
        builder: (context) => _i14.ProfileView(key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i2.RouteDef> get routes => _routes;

  @override
  Map<Type, _i2.StackedRouteFactory> get pagesMap => _pagesMap;
}

class NestedHistoryViewArguments {
  const NestedHistoryViewArguments({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant NestedHistoryViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class FavoritesViewArguments {
  const FavoritesViewArguments({this.key, this.id});

  final _i8.Key? key;

  final String? id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }

  @override
  bool operator ==(covariant FavoritesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

class NestedProfileViewArguments {
  const NestedProfileViewArguments({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant NestedProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class FavoritesViewRoutes {
  static const multipleFuturesExampleView = 'multiple-futures-example-view';

  static const historyView = 'history-view';

  static const all = <String>{multipleFuturesExampleView, historyView};
}

class FavoritesViewRouter extends _i2.RouterBase {
  final _routes = <_i2.RouteDef>[
    _i2.RouteDef(
      FavoritesViewRoutes.multipleFuturesExampleView,
      page: _i16.MultipleFuturesExampleView,
    ),
    _i2.RouteDef(FavoritesViewRoutes.historyView, page: _i12.HistoryView),
  ];

  final _pagesMap = <Type, _i2.StackedRouteFactory>{
    _i16.MultipleFuturesExampleView: (data) {
      final args = data.getArgs<NestedMultipleFuturesExampleViewArguments>(
        orElse: () => const NestedMultipleFuturesExampleViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.MultipleFuturesExampleView(key: args.key),
        settings: data,
      );
    },
    _i12.HistoryView: (data) {
      final args = data.getArgs<NestedHistoryViewArguments>(
        orElse: () => const NestedHistoryViewArguments(),
      );
      return _i8.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i12.HistoryView(key: args.key),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    },
  };

  @override
  List<_i2.RouteDef> get routes => _routes;

  @override
  Map<Type, _i2.StackedRouteFactory> get pagesMap => _pagesMap;
}

class NestedMultipleFuturesExampleViewArguments {
  const NestedMultipleFuturesExampleViewArguments({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant NestedMultipleFuturesExampleViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i17.NavigationService {
  Future<dynamic> navigateToHomeView({
    _i8.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i10.Clashable Function(String)? clashableGetter,
    List<_i1.HomeType> homeTypes = const [
      _i1.HomeType.apartment,
      _i1.HomeType.house,
    ],
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.homeView,
      arguments: HomeViewArguments(
        key: key,
        title: title,
        isLoggedIn: isLoggedIn,
        clashableGetter: clashableGetter,
        homeTypes: homeTypes,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBottomNavExample({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.bottomNavExample,
      arguments: BottomNavExampleArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStreamCounterView({
    _i8.Key? key,
    required List<_i11.Clashable> clashableTwo,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.streamCounterView,
      arguments: StreamCounterViewArguments(
        key: key,
        clashableTwo: clashableTwo,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToExampleFormView({
    _i8.Key? key,
    required _i10.Clashable clashableOne,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.exampleFormView,
      arguments: ExampleFormViewArguments(key: key, clashableOne: clashableOne),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNonReactiveView({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.nonReactiveView,
      arguments: NonReactiveViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedHistoryViewInBottomNavExampleRouter({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      BottomNavExampleRoutes.historyView,
      arguments: NestedHistoryViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToFavoritesView({
    _i8.Key? key,
    String? id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      BottomNavExampleRoutes.favoritesView,
      arguments: FavoritesViewArguments(key: key, id: id),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedProfileViewInBottomNavExampleRouter({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      BottomNavExampleRoutes.profileView,
      arguments: NestedProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic>
      navigateToNestedMultipleFuturesExampleViewInFavoritesViewRouter({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      FavoritesViewRoutes.multipleFuturesExampleView,
      arguments: NestedMultipleFuturesExampleViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedHistoryViewInFavoritesViewRouter({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      FavoritesViewRoutes.historyView,
      arguments: NestedHistoryViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithHomeView({
    _i8.Key? key,
    String? title = 'hello',
    bool? isLoggedIn = false,
    _i10.Clashable Function(String)? clashableGetter,
    List<_i1.HomeType> homeTypes = const [
      _i1.HomeType.apartment,
      _i1.HomeType.house,
    ],
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.homeView,
      arguments: HomeViewArguments(
        key: key,
        title: title,
        isLoggedIn: isLoggedIn,
        clashableGetter: clashableGetter,
        homeTypes: homeTypes,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBottomNavExample({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.bottomNavExample,
      arguments: BottomNavExampleArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStreamCounterView({
    _i8.Key? key,
    required List<_i11.Clashable> clashableTwo,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.streamCounterView,
      arguments: StreamCounterViewArguments(
        key: key,
        clashableTwo: clashableTwo,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithExampleFormView({
    _i8.Key? key,
    required _i10.Clashable clashableOne,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.exampleFormView,
      arguments: ExampleFormViewArguments(key: key, clashableOne: clashableOne),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithNonReactiveView({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.nonReactiveView,
      arguments: NonReactiveViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithNestedHistoryViewInBottomNavExampleRouter({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      BottomNavExampleRoutes.historyView,
      arguments: NestedHistoryViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithFavoritesView({
    _i8.Key? key,
    String? id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      BottomNavExampleRoutes.favoritesView,
      arguments: FavoritesViewArguments(key: key, id: id),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithNestedProfileViewInBottomNavExampleRouter({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      BottomNavExampleRoutes.profileView,
      arguments: NestedProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic>
      replaceWithNestedMultipleFuturesExampleViewInFavoritesViewRouter({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      FavoritesViewRoutes.multipleFuturesExampleView,
      arguments: NestedMultipleFuturesExampleViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithNestedHistoryViewInFavoritesViewRouter({
    _i8.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      FavoritesViewRoutes.historyView,
      arguments: NestedHistoryViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
