import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'nonreactive_viewmodel.dart';

class NonReactiveView extends StatelessWidget {
  const NonReactiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NonReactiveViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateTitle();
          },
        ),
        body: Center(
          child: Text(model.title),
        ),
      ),
      viewModelBuilder: () => NonReactiveViewModel(),
    );
  }
}
