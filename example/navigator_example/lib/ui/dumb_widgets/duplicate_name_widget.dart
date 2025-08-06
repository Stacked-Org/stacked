import 'package:example/datamodels/human.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DuplicateNameWidget extends ViewModelWidget<Human> {
  const DuplicateNameWidget({super.key});

  @override
  Widget build(BuildContext context, Human viewModel) {
    return Row(
      children: <Widget>[
        Text(viewModel.name!),
        const SizedBox(
          width: 50,
        ),
        Text(viewModel.name!),
      ],
    );
  }
}
