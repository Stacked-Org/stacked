import 'package:example/ui/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked_app/stacked_app_annotations.dart';

import 'main.router.dart';

void main() {
  runApp(MyApp());
}

@StackedApp(
  routes: [MaterialRoute(page: HomeView)],
)
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: StackedRouter.onGenerateRoute,
    );
  }
}
