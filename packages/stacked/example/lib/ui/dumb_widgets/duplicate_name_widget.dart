import 'package:flutter/material.dart';
import 'package:new_architecture/datamodels/human.dart';
import 'package:stacked/stacked.dart';

class DuplicateNameWidget extends ViewModelWidget<Human> {
  @override
  Widget build(BuildContext context, Human model) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(model.name!),
        ),
        SizedBox(
          width: 50,
        ),
        Container(
          child: Text(model.name!),
        ),
      ],
    );
  }
}
