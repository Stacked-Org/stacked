// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/app/custom_route_transition.dart' as _i9;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart' as _i10;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i17;

import '../datamodels/clashable_one.dart' as _i12;
import '../datamodels/clashable_two.dart' as _i11;
import '../ui/bottom_nav/bottom_nav_example.dart' as _i3;
import '../ui/bottom_nav/favorites/favorites_view.dart' as _i13;
import '../ui/bottom_nav/history/history_view.dart' as _i14;
import '../ui/bottom_nav/profile/profile_view.dart' as _i15;
import '../ui/details/details_view.dart' as _i5;
import '../ui/form/example_form_view.dart' as _i6;
import '../ui/home/home_view.dart' as _i2;
import '../ui/multiple_futures_example/multiple_futures_example_view.dart'
    as _i16;
import '../ui/nonreactive/nonreactive_view.dart' as _i7;
import '../ui/stream_view/stream_counter_view.dart' as _i4;

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
        builder: (context) => _i2.HomeView(key: args.key, title: args.title),
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
  const HomeViewArguments({this.key, this.title});

  final _i10.Key? key;

  final String? title;
}

class StreamCounterViewArguments {
  const StreamCounterViewArguments({this.key, required this.clashableTwo});

  final _i10.Key? key;

  final _i11.Clashable clashableTwo;
}

class DetailsViewArguments {
  const DetailsViewArguments({this.key, required this.name});

  final _i10.Key? key;

  final String name;
}

class ExampleFormViewArguments {
  const ExampleFormViewArguments({this.key, required this.clashableOne});

  final _i10.Key? key;

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
        page: _i13.FavoritesView),
    _i1.RouteDef(BottomNavExampleRoutes.historyView, page: _i14.HistoryView),
    _i1.RouteDef(BottomNavExampleRoutes.profileView, page: _i15.ProfileView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i13.FavoritesView: (data) {
      final args = data.getArgs<NestedFavoritesViewArguments>(
        orElse: () => NestedFavoritesViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i13.FavoritesView(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i14.HistoryView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i14.HistoryView(),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    },
    _i15.ProfileView: (data) {
      return _i8.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i15.ProfileView(),
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

  final _i10.Key? key;

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
        page: _i16.MultipleFuturesExampleView),
    _i1.RouteDef(FavoritesViewRoutes.historyView, page: _i14.HistoryView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i16.MultipleFuturesExampleView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.MultipleFuturesExampleView(),
        settings: data,
      );
    },
    _i14.HistoryView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i14.HistoryView(),
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

extension NavigatorStateExtension on _i17.NavigationService {
  Future<dynamic> navigateToHomeView(
      {_i10.Key? key,
      String? title,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    navigateTo(Routes.homeView,
        arguments: HomeViewArguments(key: key, title: title),
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
    navigateTo(Routes.bottomNavExample,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStreamCounterView(
      {_i10.Key? key,
      required _i11.Clashable clashableTwo,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    navigateTo(Routes.streamCounterView,
        arguments:
            StreamCounterViewArguments(key: key, clashableTwo: clashableTwo),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<Map<String, List<String>>?> navigateToDetailsView(
      {_i10.Key? key,
      required String name,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    navigateTo(Routes.detailsView,
        arguments: DetailsViewArguments(key: key, name: name),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExampleFormView(
      {_i10.Key? key,
      required _i12.Clashable clashableOne,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    navigateTo(Routes.exampleFormView,
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
    navigateTo(Routes.nonReactiveView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNestedFavoritesViewInBottomNavExample(
      {_i10.Key? key,
      String? id,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    navigateTo(BottomNavExampleRoutes.favoritesView,
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
    navigateTo(BottomNavExampleRoutes.historyView,
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
    navigateTo(BottomNavExampleRoutes.profileView,
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
    navigateTo(FavoritesViewRoutes.multipleFuturesExampleView,
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
    navigateTo(FavoritesViewRoutes.historyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
