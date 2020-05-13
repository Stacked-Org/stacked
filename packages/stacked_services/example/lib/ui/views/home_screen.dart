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
  // IMPLEMENTATION NOTE: Services should never be used directly in a view refer to
  // https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/#how-does-stacked-work
  // for more details.
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Screen",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Press the button below to show a dialog',
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            OutlineButton(
              onPressed: () async {
                await _dialogService.showDialog(
                  title: 'Test Dialog Title',
                  description: 'Test Dialog Description',
                );
              },
              child: Text(
                'Show Dialog',
              ),
            ),
            Text(
              "Using Route name to Navigate to next page",
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
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
