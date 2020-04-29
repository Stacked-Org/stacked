import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_architecture/app/locator.dart';
import 'package:new_architecture/ui/multiple_streams_example/multiple_streams_example_view.dart';

void main() {
  configure();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Get.key,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultipleStreamsExampleView(),
    );
  }
}
