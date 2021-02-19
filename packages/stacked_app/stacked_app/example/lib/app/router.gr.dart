// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

import 'package:stacked_app/stacked_app.dart' as _i1;
import '../main.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

class StackedRouter extends _i1.StackedRouterConfig {
  StackedRouter();

  @override
  final Map<Type, _i1.PageFactory> pagesMap = {
    _i2.MyHomePage: (data) {
      var args = data.getArgs<MyHomePageArgs>(orElse: () => MyHomePageArgs());
      return _i1.MaterialPageX(
          data: data, child: _i2.MyHomePage(key: args.key, title: args.title));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MyHomePageRoute.pageKey,
            path: 'my-home-page', page: _i2.MyHomePage)
      ];
}

class MyHomePageRoute extends _i1.PageRouteInfo {
  MyHomePageRoute({_i3.Key key, String title})
      : super(pageKey,
            path: 'my-home-page', args: MyHomePageArgs(key: key, title: title));

  static const String pageKey = 'MyHomePageRoute';
}

class MyHomePageArgs extends _i1.RouteArgs {
  MyHomePageArgs({this.key, this.title}) : super([key, title]);

  final _i3.Key key;

  final String title;
}
