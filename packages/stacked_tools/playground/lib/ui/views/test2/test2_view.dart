import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'test2_viewmodel.dart';

class Test2View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Test2ViewModel>.reactive(
      viewModelBuilder: () => Test2ViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          padding: EdgeInsets.only(left: 25.0, right: 25.0),
        ),
      ),
    );
  }
}
