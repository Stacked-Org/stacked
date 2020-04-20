import 'package:flutter/material.dart';
import 'package:new_architecture/app/locator.dart';
import 'package:new_architecture/ui/home/home_view.dart';

void main() {
  configure();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
