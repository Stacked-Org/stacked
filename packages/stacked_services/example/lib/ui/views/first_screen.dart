import 'package:example/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'second_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService _navigationService = locator<NavigationService>();

    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Using custom transitions and passing the \npage instead of Route name",
              softWrap: true,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            OutlineButton(
              child: Text("Use Fade Transition"),
              onPressed: () async {
                await _navigationService.toPageWithTransition(
                  SecondScreen(),
                  transition: "fade",
                );
              },
            ),
            OutlineButton(
              child: Text("Use Right to Left Transition"),
              onPressed: () async {
                await _navigationService.toPageWithTransition(
                  SecondScreen(),
                  transition: "rightToLeft",
                );
              },
            ),
            OutlineButton(
              child: Text("Use Left to Right Transition"),
              onPressed: () async {
                await _navigationService.toPageWithTransition(
                  SecondScreen(),
                  transition: "leftToRight",
                );
              },
            ),
            OutlineButton(
              child: Text("Use Cupertino Transition"),
              onPressed: () async {
                await _navigationService.toPageWithTransition(
                  SecondScreen(),
                  transition: "cupertino",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
