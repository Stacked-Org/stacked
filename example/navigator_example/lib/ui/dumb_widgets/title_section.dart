import 'package:flutter/material.dart';
import 'package:example/ui/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TitleSection extends ViewModelWidget<HomeViewModel> {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Row(
      children: <Widget>[
        const Text(
          'Title',
          style: TextStyle(fontSize: 20),
        ),
        Text(viewModel.title),
      ],
    );
  }
}
