import 'package:example/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked_shared/stacked_shared.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/app.locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await setupExampleLocator(
    environment: Environment.dev,
    stackedRouter: stackedRouter,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
