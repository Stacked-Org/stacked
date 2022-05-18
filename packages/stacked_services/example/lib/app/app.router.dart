// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/views/first_screen.dart';
import '../ui/views/home_screen.dart';
import '../ui/views/second_screen.dart';

class Routes {
  static const String homeScreenRoute = '/';
  static const String firstScreenRoute = '/first-screen';
  static const String secondScreenRoute = '/second-screen';
  static const all = <String>{
    homeScreenRoute,
    firstScreenRoute,
    secondScreenRoute,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeScreenRoute, page: HomeScreen),
    RouteDef(Routes.firstScreenRoute, page: FirstScreen),
    RouteDef(Routes.secondScreenRoute, page: SecondScreen),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeScreen: (data) {
      var args = data.getArgs<HomeScreenArguments>(
        orElse: () => HomeScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(key: args.key),
        settings: data,
      );
    },
    FirstScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const FirstScreen(),
        settings: data,
      );
    },
    SecondScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SecondScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// HomeScreen arguments holder class
class HomeScreenArguments {
  final Key key;
  HomeScreenArguments({this.key});
}
