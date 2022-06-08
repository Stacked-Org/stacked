// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:example/app/custom_route_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../ui/bottom_nav/bottom_nav_example.dart';
import '../ui/bottom_nav/favorites/favorites_view.dart';
import '../ui/bottom_nav/history/history_view.dart';
import '../ui/bottom_nav/profile/profile_view.dart';
import '../ui/details/details_view.dart';
import '../ui/form/example_form_view.dart';
import '../ui/home/home_view.dart';
import '../ui/nonreactive/nonreactive_view.dart';
import '../ui/stream_view/stream_counter_view.dart';

class Routes {
  static const String homeView = '/';
  static const String bottomNavExample = '/bottom-nav-example';
  static const String streamCounterView = '/stream-counter-view';
  static const String detailsView = '/details-view';
  static const String exampleFormView = '/example-form-view';
  static const String nonReactiveView = '/non-reactive-view';
  static const all = <String>{
    homeView,
    bottomNavExample,
    streamCounterView,
    detailsView,
    exampleFormView,
    nonReactiveView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(
      Routes.bottomNavExample,
      page: BottomNavExample,
      generator: BottomNavExampleRouter(),
    ),
    RouteDef(Routes.streamCounterView, page: StreamCounterView),
    RouteDef(Routes.detailsView, page: DetailsView),
    RouteDef(Routes.exampleFormView, page: ExampleFormView),
    RouteDef(Routes.nonReactiveView, page: NonReactiveView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      var args = data.getArgs<HomeViewArguments>(
        orElse: () => HomeViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(
          key: args.key,
          title: args.title,
        ),
        settings: data,
      );
    },
    BottomNavExample: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const BottomNavExample(),
        settings: data,
      );
    },
    StreamCounterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StreamCounterView(),
        settings: data,
      );
    },
    DetailsView: (data) {
      var args = data.getArgs<DetailsViewArguments>(nullOk: false);
      return CupertinoPageRoute<Map<String, List<String>>>(
        builder: (context) => DetailsView(
          key: args.key,
          name: args.name,
        ),
        settings: data,
      );
    },
    ExampleFormView: (data) {
      var args = data.getArgs<ExampleFormViewArguments>(
        orElse: () => ExampleFormViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ExampleFormView(key: args.key),
        settings: data,
      );
    },
    NonReactiveView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const NonReactiveView(),
        settings: data,
        transitionsBuilder: data.transition ?? CustomRouteTransition.sharedAxis,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// HomeView arguments holder class
class HomeViewArguments {
  final Key? key;
  final String? title;
  HomeViewArguments({this.key, this.title});
}

/// DetailsView arguments holder class
class DetailsViewArguments {
  final Key? key;
  final String name;
  DetailsViewArguments({this.key, required this.name});
}

/// ExampleFormView arguments holder class
class ExampleFormViewArguments {
  final Key? key;
  ExampleFormViewArguments({this.key});
}

class BottomNavExampleRoutes {
  static const String favoritesView = '/favorites-view';
  static const String historyView = '/history-view';
  static const String profileView = '/profile-view';
  static const all = <String>{
    favoritesView,
    historyView,
    profileView,
  };
}

class BottomNavExampleRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(BottomNavExampleRoutes.favoritesView, page: FavoritesView),
    RouteDef(BottomNavExampleRoutes.historyView, page: HistoryView),
    RouteDef(BottomNavExampleRoutes.profileView, page: ProfileView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    FavoritesView: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => const FavoritesView(),
        settings: data,
      );
    },
    HistoryView: (data) {
      return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HistoryView(),
          settings: data,
          transitionsBuilder: data.transition ??
              (context, animation, secondaryAnimation, child) {
                return child;
              });
    },
    ProfileView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const ProfileView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {
  Future<dynamic> navigateToHomeView({
    Key? key,
    String? title,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.homeView,
      arguments: HomeViewArguments(key: key, title: title),
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBottomNavExample({
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.bottomNavExample,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedFavoritesView({
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      BottomNavExampleRoutes.favoritesView,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedHistoryView({
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      BottomNavExampleRoutes.historyView,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNestedProfileView({
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      BottomNavExampleRoutes.profileView,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStreamCounterView({
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.streamCounterView,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<Map<String, List<String>>?> navigateToDetailsView({
    Key? key,
    required String name,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.detailsView,
      arguments: DetailsViewArguments(key: key, name: name),
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToExampleFormView({
    Key? key,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.exampleFormView,
      arguments: ExampleFormViewArguments(key: key),
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToNonReactiveView({
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.nonReactiveView,
      id: id,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
