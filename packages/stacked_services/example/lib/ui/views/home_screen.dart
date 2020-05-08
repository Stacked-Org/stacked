import 'package:example/app/locator.dart';
import 'package:example/app/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Using Route name to Navigate to next page",
          softWrap: true,
          style: TextStyle(fontSize: 14),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _navigationService.navigateTo(Routes.firstScreenRoute);
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
