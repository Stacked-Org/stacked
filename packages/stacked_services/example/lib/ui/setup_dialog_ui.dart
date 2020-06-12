import 'package:example/app/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  dialogService.registerCustomDialogUi((context, dialogRequest) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                dialogRequest.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                dialogRequest.description,
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => dialogService.completeDialog(DialogResponse()),
                child: Container(
                  child: dialogRequest.showIconInMainButton
                      ? Icon(Icons.check_circle)
                      : Text(dialogRequest.mainButtonTitle),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
}
