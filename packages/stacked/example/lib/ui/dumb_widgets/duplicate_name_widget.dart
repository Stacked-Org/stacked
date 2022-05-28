import 'package:flutter/material.dart';
import 'package:new_architecture/datamodels/human.dart';
import 'package:stacked/stacked.dart';

class DuplicateNameWidget extends ViewModelWidget<Human> {
  const DuplicateNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, Human model) {
    return Row(
      children: <Widget>[
        Text(model.name!),
        const SizedBox(
          width: 50,
        ),
        Text(model.name!),
      ],
    );
  }
}
