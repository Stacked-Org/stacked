// @dart=2.9

import 'package:flutter/material.dart';
import 'package:new_architecture/ui/skeleton_loading/skeleton_loading_view.dart';
import 'package:stacked/stacked_annotations.dart';

import 'app/app.locator.dart';

void main() {
  setupExampleLocator(environment: Environment.dev);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SkeletonLoadingView(),
      // navigatorKey: StackedService.navigatorKey,
      // onGenerateRoute: StackedRouter().onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
