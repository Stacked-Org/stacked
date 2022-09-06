// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/app/custom_route_transition.dart' as _i9;
import 'package:example/datamodels/clashable_one.dart' as _i12;
import 'package:example/datamodels/clashable_two.dart' as _i13;
import 'package:example/datamodels/home_type.dart' as _i10;
import 'package:example/ui/bottom_nav/bottom_nav_example.dart' as _i3;
import 'package:example/ui/bottom_nav/favorites/favorites_view.dart' as _i14;
import 'package:example/ui/bottom_nav/history/history_view.dart' as _i15;
import 'package:example/ui/bottom_nav/profile/profile_view.dart' as _i16;
import 'package:example/ui/details/details_view.dart' as _i5;
import 'package:example/ui/form/example_form_view.dart' as _i6;
import 'package:example/ui/home/home_view.dart' as _i2;
import 'package:example/ui/multiple_futures_example/multiple_futures_example_view.dart'
    as _i18;
import 'package:example/ui/nonreactive/nonreactive_view.dart' as _i7;
import 'package:example/ui/stream_view/stream_counter_view.dart' as _i4;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart' as _i11;
import 'package:flutter/material.dart';
import 'package:stacked/src/code_generation/router_annotation/transitions_builders.dart'
    as _i17;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i19;

class Routes {
  static const homeView = '/';

  static const bottomNavExample = '/bottom-nav-example';

  static const streamCounterView = '/stream-counter-view';

  static const detailsView = '/details-view';

  static const exampleFormView = '/example-form-view';

  static const nonReactiveView = '/non-reactive-view';

  static const all = <String>{
    homeView,
    bottomNavExample,
    streamCounterView,
    detailsView,
    exampleFormView,
    nonReactiveView
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.homeView, page: _i2.HomeView),
    _i1.RouteDef(Routes.bottomNavExample, page: _i3.BottomNavExample),
    _i1.RouteDef(Routes.streamCounterView, page: _i4.StreamCounterView),
    _i1.RouteDef(Routes.detailsView, page: _i5.DetailsView),
    _i1.RouteDef(Routes.exampleFormView, page: _i6.ExampleFormView),
    _i1.RouteDef(Routes.nonReactiveView, page: _i7.NonReactiveView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => HomeViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i2.HomeView(
            key: args.key,
            title: args.title,
            isLoggedIn: args.isLoggedIn,
            clashableGetter: args.clashableGetter,
            homeType: args.homeType),
        settings: data,
      );
    },
    _i3.BottomNavExample: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.BottomNavExample(),
        settings: data,
      );
    },
    _i4.StreamCounterView: (data) {
      final args = data.getArgs<StreamCounterViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i4.StreamCounterView(
            key: args.key, clashableTwo: args.clashableTwo),
        settings: data,
      );
    },
    _i5.DetailsView: (data) {
      final args = data.getArgs<DetailsViewArguments>(nullOk: false);
      return _i8.CupertinoPageRoute<Map<String, List<String>>>(
        builder: (context) => _i5.DetailsView(key: args.key, name: args.name),
        settings: data,
      );
    },
    _i6.ExampleFormView: (data) {
      final args = data.getArgs<ExampleFormViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.ExampleFormView(key: args.key, clashableOne: args.clashableOne),
        settings: data,
      );
    },
    _i7.NonReactiveView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i7.NonReactiveView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i9.CustomRouteTransition.sharedAxis,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments(
      {this.key,
      this.title = 'hello',
      this.isLoggedIn = false,
      this.clashableGetter,
      this.homeType = _i10.HomeType.apartment});

  final _i11.Key? key;

  final String? title;

  final bool? isLoggedIn;

  final _i12.Clashable Function(String)? clashableGetter;

  final _i10.HomeType homeType;
}

class StreamCounterViewArguments {
  const StreamCounterViewArguments({this.key, required this.clashableTwo});

  final _i11.Key? key;

  final List<_i13.Clashable> clashableTwo;
}

class DetailsViewArguments {
  const DetailsViewArguments({this.key, required this.name});

  final _i11.Key? key;

  final String name;
}

class ExampleFormViewArguments {
  const ExampleFormViewArguments({this.key, required this.clashableOne});

  final _i11.Key? key;

  final _i12.Clashable clashableOne;
}

class BottomNavExampleRoutes {
  static const favoritesView = '/favorites-view';

  static const historyView = '/history-view';

  static const profileView = '/profile-view';

  static const all = <String>{favoritesView, historyView, profileView};
}

class BottomNavExampleRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(BottomNavExampleRoutes.favoritesView,
        page: _i14.FavoritesView),
    _i1.RouteDef(BottomNavExampleRoutes.historyView, page: _i15.HistoryView),
    _i1.RouteDef(BottomNavExampleRoutes.profileView, page: _i16.ProfileView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i14.FavoritesView: (data) {
      final args = data.getArgs<NestedFavoritesViewArguments>(
        orElse: () => NestedFavoritesViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i14.FavoritesView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i15.HistoryView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i15.HistoryView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i17.TransitionsBuilders.fadeIn,
      );
    },
    _i16.ProfileView: (data) {
      return _i8.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i16.ProfileView(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class NestedFavoritesViewArguments {
  const NestedFavoritesViewArguments({this.key, this.id});

  final _i11.Key? key;

  final String? id;
}

class FavoritesViewRoutes {
  static const multipleFuturesExampleView = '/multiple-futures-example-view';

  static const historyView = '/history-view';

  static const all = <String>{multipleFuturesExampleView, historyView};
}

class FavoritesViewRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(FavoritesViewRoutes.multipleFuturesExampleView,
        page: _i18.MultipleFuturesExampleView),
    _i1.RouteDef(FavoritesViewRoutes.historyView, page: _i15.HistoryView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i18.MultipleFuturesExampleView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.MultipleFuturesExampleView(),
        settings: data,
      );
    },
    _i15.HistoryView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i15.HistoryView(),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on _i19.NavigationService {
  Future<dynamic> navigateToHomeView(
      {_i11.Key? key,
      String? title = 'hello',
      bool? isLoggedIn = false,
      _i12.Clashable Function(String)? clashableGetter,
      _i10.HomeType homeType = _i10.HomeType.apartment,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(
            key: key,
            title: title,
            isLoggedIn: isLoggedIn,
            clashableGetter: clashableGetter,
            homeType: homeType),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBottomNavExample(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.bottomNavExample,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStreamCounterView(
      {_i11.Key? key,
      required List<_i13.Clashable> clashableTwo,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(Routes.streamCounterView,
        arguments:
            StreamCounterViewArguments(key: key, clashableTwo: clashableTwo),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<Map<String, List<String>>?> navigateToDetailsView(
      {_i11.Key? key,
      required String name,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<Map<String, List<String>>?>(Routes.detailsView,
        arguments: DetailsViewArguments(key: key, name: name),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExampleFormView(
      {_i11.Key? key,
      required _i12.Clashable clashableOne,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(Routes.exampleFormView,
        arguments:
            ExampleFormViewArguments(key: key, clashableOne: clashableOne),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNonReactiveView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.nonReactiveView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedFavoritesViewInBottomNavExample(
      {_i11.Key? key,
      String? id,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(BottomNavExampleRoutes.favoritesView,
        arguments: NestedFavoritesViewArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedHistoryViewInBottomNavExample(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(BottomNavExampleRoutes.historyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedProfileViewInBottomNavExample(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(BottomNavExampleRoutes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedMultipleFuturesExampleViewInFavoritesView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(FavoritesViewRoutes.multipleFuturesExampleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedHistoryViewInFavoritesView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(FavoritesViewRoutes.historyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
