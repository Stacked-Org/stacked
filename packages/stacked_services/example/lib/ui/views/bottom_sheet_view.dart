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
                title: 'Test Dialog Title',
                description: 'Test Dialog Description',
                cancelButtonTitle: 'Cancel'
              );
            },
            child: Text(
              'Show Material Dialog',
            ),
          ),
        ],
      ),
    );
  }
}
