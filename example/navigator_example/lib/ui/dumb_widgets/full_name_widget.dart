import 'package:example/datamodels/human.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FullNameWidget extends ViewModelWidget<Human> {
  const FullNameWidget({super.key});

  @override
  Widget build(BuildContext context, Human viewModel) {
    return Row(
      children: <Widget>[
        Text(
          viewModel.name!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(
          width: 50,
        ),
        Text(
          viewModel.surname!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ],
    );
  }
}
