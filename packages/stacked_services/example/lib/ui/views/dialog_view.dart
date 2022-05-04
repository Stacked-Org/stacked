import '../../app/app.locator.dart';
import 'package:example/ui/setup_dialog_ui.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../enums/dialog_type.dart';

class DialogView extends StatelessWidget {
  DialogView({Key key}) : super(key: key);

  final DialogService _dialogService = locator<DialogService>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Press the button below to show a regular Material dialog',
                softWrap: true,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              OutlinedButton(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Press the button below to show a regular Material dialog without description',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await _dialogService.showDialog(
                    title: 'Test Dialog Title',
                    // description: 'Test Dialog Description',
                  );
                },
                child: Text(
                  'Show Material Dialog',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Press the button below to show a regular Material dialog without title',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await _dialogService.showDialog(
                    // title: 'Test Dialog Title',
                    description: 'Test Dialog Description',
                  );
                },
                child: Text(
                  'Show Material Dialog',
                ),
              ),
              Text(
                'Press the button below to show a custom dialog',
                softWrap: true,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await _dialogService.showCustomDialog(
                      variant: DialogType.Basic,
                      title: 'This is a custom UI with Text as main button',
                      description:
                          'Sheck out the builder in the dialog_ui_register.dart file',
                      mainButtonTitle: 'Ok',
                      showIconInMainButton: false,
                      barrierDismissible: true);
                },
                child: Text(
                  'Show Custom Text Dialog',
                ),
              ),
              Text(
                'Press the button below to show a Custom Generic dialog',
                softWrap: true,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  final response = await _dialogService.showCustomDialog<
                      GenericDialogResponse, GenericDialogRequest>(
                    variant: DialogType.Generic,
                    title:
                        'This is a custom Generic UI with Text as main button',
                    description:
                        'Sheck out the builder in the dialog_ui_register.dart file',
                    mainButtonTitle: 'Ok',
                    showIconInMainButton: false,
                    barrierDismissible: true,
                    data: GenericDialogRequest(),
                  );

                  print(response.data.message);
                },
                child: Text(
                  'Show Generic Dialog',
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await _dialogService.showCustomDialog(
                    variant: DialogType.Basic,
                    title: 'This is a custom UI with icon',
                    description:
                        'Sheck out the builder in the dialog_ui_register.dart file',
                    showIconInMainButton: true,
                  );
                },
                child: Text(
                  'Show Custom Icon Dialog',
                ),
              ),
              Text(
                'Press the button below to show a Material confirmation dialog',
                softWrap: true,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await _dialogService.showConfirmationDialog(
                    title: 'Test Confirmation Dialog Title',
                    description: 'Test Confirmation Dialog Description',
                    barrierDismissible: true,
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
              OutlinedButton(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Press the button below to show a Cupertino confirmation dialog',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await _dialogService.showConfirmationDialog(
                    dialogPlatform: DialogPlatform.Cupertino,
                    title: 'Test Confirmation Dialog Title',
                    description: 'Test Confirmation Dialog Description',
                    barrierDismissible: true,
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
          )
        ],
      ),
    );
  }
}
