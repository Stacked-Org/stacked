// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/views/order_details/order_details_view.dart';

class Routes {
  static const String orderDetailsView = '/order-details-view';
  static const String test2View = '/test2-view';
  static const all = <String>{
    orderDetailsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.orderDetailsView, page: OrderDetailsView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    OrderDetailsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OrderDetailsView(),
        settings: data,
      );
    },
  };
}
