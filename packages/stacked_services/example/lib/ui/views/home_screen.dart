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
              'Press the button below to show a regular Material dialog',
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
                'Show Material Dialog',
              ),
            ),
            Text(
              'Press the button below to show a Material confirmation dialog',
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            OutlineButton(
              onPressed: () async {
                await _dialogService.showConfirmationDialog(
                  title: 'Test Confirmation Dialog Title',
                  description: 'Test Confirmation Dialog Description',
                );
              },
              child: Text(
                'Show Material Confirmation Dialog',
              ),
            ),
            Text(
              'Press the button below to show a Cupertino dialog',
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            OutlineButton(
              onPressed: () async {
                await _dialogService.showDialog(
                  dialogPlatform: DialogPlatform.Cupertino,
                  title: 'Test Confirmation Dialog Title',
                  description: 'Test Dialog Description',
                );
              },
              child: Text(
                'Show Cupertino Dialog',
              ),
            ),
            Text(
              'Press the button below to show a Cupertino confirmation dialog',
              softWrap: true,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            OutlineButton(
              onPressed: () async {
                await _dialogService.showConfirmationDialog(
                  dialogPlatform: DialogPlatform.Cupertino,
                  title: 'Test Confirmation Dialog Title',
                  description: 'Test Confirmation Dialog Description',
                );
              },
              child: Text(
                'Show Cupertino Confirmation Dialog',
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
