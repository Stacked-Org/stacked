import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_architecture/app/locator.dart';
import 'package:new_architecture/ui/bottom_nav/bottom_nav_example.dart';
import 'package:new_architecture/ui/home/home_view.dart';
import 'package:new_architecture/ui/stream_view/stream_counter_view.dart';
import 'package:stacked/stacked_annotations.dart';

import 'main.router.dart';

void main() {
  configure();
  runApp(MyApp());
}

@StackedApp(routes: [
  MaterialRoute(page: HomeView, initial: true),
  MaterialRoute(page: BottomNavExample),
  MaterialRoute(page: StreamCounterView)
])
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Get.key,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
