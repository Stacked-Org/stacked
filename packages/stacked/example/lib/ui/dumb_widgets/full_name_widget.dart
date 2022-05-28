import 'package:flutter/material.dart';
import 'package:new_architecture/datamodels/human.dart';
import 'package:stacked/stacked.dart';

class FullNameWidget extends ViewModelWidget<Human> {
  const FullNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, Human model) {
    return Row(
      children: <Widget>[
        Text(
          model.name!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(
          width: 50,
        ),
        Text(
          model.surname!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ],
    );
  }
}
