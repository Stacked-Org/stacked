// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_architecture/app/app.locator.dart';
import 'package:new_architecture/services/cloud_logging_service.dart';
import 'package:new_architecture/ui/bottom_nav/bottom_nav_example.dart';
import 'package:new_architecture/ui/builder_widget_example/builder_widget_example_view.dart';
import 'package:new_architecture/ui/form/example_form_view.dart';
import 'package:new_architecture/ui/future_example_view/future_example_view.dart';
import 'package:new_architecture/ui/multiple_futures_example/multiple_futures_example_view.dart';
import 'package:new_architecture/ui/multiple_streams_example/multiple_streams_example_view.dart';
import 'package:new_architecture/ui/nonreactive/nonreactive_view.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.router.dart';

Future<void> main() async {
  setupLocator();
  await locator<CloudLoggingService>().initialise();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
