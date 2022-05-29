import 'package:flutter/material.dart';
import 'package:new_architecture/ui/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DescriptionSection extends ViewModelWidget<HomeViewModel> {
  const DescriptionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Row(
      children: <Widget>[
        const Text(
          'Description',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        Text(viewModel.title),
      ],
    );
  }
}
