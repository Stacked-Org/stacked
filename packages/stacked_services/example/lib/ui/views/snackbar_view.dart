import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_services_example/enums/snackbar_type.dart';

import '../../app/app.locator.dart';

class SnackbarView extends StatelessWidget {
  SnackbarView({Key? key}) : super(key: key);

  final _snackbarService = locator<SnackbarService>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Press the button below to show a regular snackbar',
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              _snackbarService.showSnackbar(
                message: 'This is a snack bar',
                onTap: (_) {
                  print('snackbar tapped');
                },
                mainButtonTitle: 'Undo',
                onMainButtonTapped: () => print('Undo the action!'),
              );
            },
            child: Text(
              'Show Snackbar',
            ),
          ),
          Text(
            'Press the button below to show blueAndYellow snackbar',
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              _snackbarService.showCustomSnackBar(
                variant: SnackbarType.blueAndYellow,
                message: 'Blue and yellow',
                title: 'The message is the message',
                onTap: (_) {
                  print('snackbar tapped');
                },
                mainButtonTitle: 'Undo',
                onMainButtonTapped: () => print('Undo the action!'),
              );
            },
            child: Text(
              'Show Blue and Yellow Snackbar',
            ),
          ),
          Text(
            'Press the button below to show a regular snackbar',
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              _snackbarService.showCustomSnackBar(
                variant: SnackbarType.greenAndRed,
                message:
                    'The text is green and red and the background is white',
                duration: Duration(seconds: 5),
                onTap: (_) {
                  print('snackbar tapped');
                },
                mainButtonTitle: 'Undo',
                onMainButtonTapped: () => print('Undo the action!'),
              );
            },
            child: Text(
              'Show Green and Red Snackbar',
            ),
          ),
        ],
      ),
    );
  }
}
