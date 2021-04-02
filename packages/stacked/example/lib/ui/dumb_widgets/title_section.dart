import 'package:flutter/material.dart';
import 'package:new_architecture/ui/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TitleSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Row(
      children: <Widget>[
        Text(
          'Title',
          style: TextStyle(fontSize: 20),
        ),
        Container(
          child: Text(viewModel.title),
        ),
      ],
    );
  }
}
