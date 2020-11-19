import 'package:example/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomSheetView extends StatelessWidget {
  BottomSheetView({Key key}) : super(key: key);

  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Press the button below to show a regular BottomSheet',
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          OutlineButton(
            onPressed: () async {
              await _bottomSheetService.showBottomSheet(
                title: 'This is my Sheets Title',
                description:
                    'This property will display under the title. We\'re not going to provide a lot of UI versions for the sheet because everyone will have a different style.\nInstead you can use the custom sheet builders as shown below.',
              );
            },
            child: Text(
              'Show Basic Bottom Sheet Alert',
            ),
          ),
          Text(
            'Press the button below to show a confirmation bottom sheet',
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          OutlineButton(
            onPressed: () async {
              var confirmationResponse =
                  await _bottomSheetService.showBottomSheet(
                title: 'Confirm this action with one of the options below',
                description:
                    'The result from this call will return a SheetResponse object with confirmed set to true. See the logs where we print out the confirmed value for you.',
                confirmButtonTitle: 'I confirm',
                cancelButtonTitle: 'I DONT confirm',
              );

              print(
                  'confirmationResponse confirmed: ${confirmationResponse.confirmed}');
            },
            child: Text(
              'Show Confirmation Bottom Sheet',
            ),
          ),
        ],
      ),
    );
  }
}
