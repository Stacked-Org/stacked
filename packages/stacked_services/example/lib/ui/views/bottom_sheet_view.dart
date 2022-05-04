import '../../app/app.locator.dart';
import 'package:example/enums/bottomsheet_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../setup_bottom_sheet_ui.dart';

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
          OutlinedButton(
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
          OutlinedButton(
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
                  'confirmationResponse confirmed: ${confirmationResponse?.confirmed}');
            },
            child: Text(
              'Show Confirmation Bottom Sheet',
            ),
          ),
          Text(
            'Press the button below to show one of the custom sheets',
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              var confirmationResponse =
                  await _bottomSheetService.showCustomSheet(
                variant: BottomSheetType.FloatingBox,
                title: 'This is a floating bottom sheet',
                description:
                    'This sheet is a custom built bottom sheet UI that allows you to show it from any service or viewmodel.',
                mainButtonTitle: 'Awesome!',
                secondaryButtonTitle: 'This is cool',
              );

              print(
                  'confirmationResponse confirmed: ${confirmationResponse?.confirmed}');
            },
            child: Text(
              'Show Custom Bottom Sheet',
            ),
          ),
          Text(
            'Press the button below to show one of the generic custom sheets',
            softWrap: true,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              final response = await _bottomSheetService.showCustomSheet<
                  GenericBottomSheetResponse, GenericBottomSheetRequest>(
                variant: BottomSheetType.Generic,
                title: 'This is a generic bottom sheet',
                description:
                    'This sheet is a custom built bottom sheet UI that allows you to show it from any service or viewmodel.',
                mainButtonTitle: 'Awesome!',
                secondaryButtonTitle: 'This is cool',
              );

              print('confirmationResponse confirmed: ${response?.confirmed}');

              print('response ${response.data.message}');
            },
            child: Text(
              'Show Generic Custom Bottom Sheet',
            ),
          ),
        ],
      ),
    );
  }
}
