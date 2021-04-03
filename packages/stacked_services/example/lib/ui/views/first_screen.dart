import 'package:example/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'second_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // IMPLEMENTATION NOTE: Services should never be used directly in a view refer to
    // https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/#how-does-stacked-work
    // for more details.
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
            OutlinedButton(
              child: Text("Use Fade Transition"),
              onPressed: () async {
                await _navigationService.navigateWithTransition(
                  SecondScreen(),
                  transition: "fade",
                );
              },
            ),
            OutlinedButton(
              child: Text("Use Right to Left Transition"),
              onPressed: () async {
                await _navigationService.navigateWithTransition(
                  SecondScreen(),
                  transition: "rightToLeft",
                );
              },
            ),
            OutlinedButton(
              child: Text("Use Left to Right Transition"),
              onPressed: () async {
                await _navigationService.navigateWithTransition(
                  SecondScreen(),
                  transition: "leftToRight",
                );
              },
            ),
            OutlinedButton(
              child: Text("Use Cupertino Transition"),
              onPressed: () async {
                await _navigationService.navigateWithTransition(
                  SecondScreen(),
                  transition: "cupertino",
                );
              },
            ),
            OutlinedButton(
              child: Text("Clear Till First and Show"),
              onPressed: () async {
                await _navigationService.clearTillFirstAndShowView(
                  SecondScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
