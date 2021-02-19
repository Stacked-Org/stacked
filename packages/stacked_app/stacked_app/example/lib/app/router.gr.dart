// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked_app/stacked_app.dart';

import '../main.dart';

class Routes {
  static const String myHomePage = '/my-home-page';
  static const all = <String>{
    myHomePage,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.myHomePage, page: MyHomePage),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    MyHomePage: (data) {
      var args = data.getArgs<MyHomePageArguments>(
        orElse: () => MyHomePageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MyHomePage(
          key: args.key,
          title: args.title,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// MyHomePage arguments holder class
class MyHomePageArguments {
  final Key key;
  final String title;
  MyHomePageArguments({this.key, this.title});
}
