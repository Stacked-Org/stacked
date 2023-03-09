import 'package:example/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked_annotations.dart';

import 'app/app.locator.dart';

void main() {
  setupExampleLocator(
    environment: Environment.dev,
    stackedRouter: stackedRouter,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerDelegate: stackedRouter.delegate(),
      routeInformationParser: stackedRouter.defaultRouteParser(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
