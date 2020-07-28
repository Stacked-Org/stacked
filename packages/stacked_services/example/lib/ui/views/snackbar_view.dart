import 'package:example/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class SnackbarView extends StatelessWidget {
  SnackbarView({Key key}) : super(key: key);

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
          OutlineButton(
            onPressed: () async {
              _snackbarService.showSnackbar(
                message: 'This is a snack bar',
                title: 'The title',
                duration: Duration(seconds: 2),
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
        ],
      ),
    );
  }
}
