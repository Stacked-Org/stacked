import 'package:flutter/material.dart';
import 'package:new_architecture/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.router.dart';

Future main() async {
  setupLocator();
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
