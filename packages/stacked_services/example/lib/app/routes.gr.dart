// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:example/ui/views/home_screen.dart';
import 'package:example/ui/views/first_screen.dart';
import 'package:example/ui/views/second_screen.dart';
import 'package:example/ui/views/tts_screen.dart';

abstract class Routes {
  static const homeScreenRoute = '/';
  static const firstScreenRoute = '/first-screen-route';
  static const secondScreenRoute = '/second-screen-route';
  static const ttsScreenRoute = '/tts-screen-route';
  static const all = {
    homeScreenRoute,
    firstScreenRoute,
    secondScreenRoute,
    ttsScreenRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homeScreenRoute:
        if (hasInvalidArgs<HomeScreenArguments>(args)) {
          return misTypedArgsRoute<HomeScreenArguments>(args);
        }
        final typedArgs = args as HomeScreenArguments ?? HomeScreenArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              HomeScreen(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
          transitionDuration: const Duration(milliseconds: 400),
        );
      case Routes.firstScreenRoute:
        if (hasInvalidArgs<FirstScreenArguments>(args)) {
          return misTypedArgsRoute<FirstScreenArguments>(args);
        }
        final typedArgs =
            args as FirstScreenArguments ?? FirstScreenArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              FirstScreen(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
          transitionDuration: const Duration(milliseconds: 400),
        );
      case Routes.secondScreenRoute:
        if (hasInvalidArgs<SecondScreenArguments>(args)) {
          return misTypedArgsRoute<SecondScreenArguments>(args);
        }
        final typedArgs =
            args as SecondScreenArguments ?? SecondScreenArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SecondScreen(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
          transitionDuration: const Duration(milliseconds: 400),
        );
      case Routes.ttsScreenRoute:
        if (hasInvalidArgs<TtsScreenArguments>(args)) {
          return misTypedArgsRoute<TtsScreenArguments>(args);
        }
        final typedArgs = args as TtsScreenArguments ?? TtsScreenArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              TtsScreen(key: typedArgs.key),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
          transitionDuration: const Duration(milliseconds: 400),
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//HomeScreen arguments holder class
class HomeScreenArguments {
  final Key key;
  HomeScreenArguments({this.key});
}

//FirstScreen arguments holder class
class FirstScreenArguments {
  final Key key;
  FirstScreenArguments({this.key});
}

//SecondScreen arguments holder class
class SecondScreenArguments {
  final Key key;
  SecondScreenArguments({this.key});
}

//TtsScreen arguments holder class
class TtsScreenArguments {
  final Key key;
  TtsScreenArguments({this.key});
}
