import 'package:flutter/material.dart';
import 'package:new_architecture/ui/home/home_viewmodel.dart';
import 'package:stacked/_viewmodel_widget.dart';

class DescriptionSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Row(
      children: <Widget>[
        Text(
          'Description',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        Container(
          child: Text(model.title),
        ),
      ],
    );
  }
}
