import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'nonreactive_viewmodel.dart';

class NonReactiveView extends StatelessWidget {
  const NonReactiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NonReactiveViewModel>.nonReactive(
      builder: (context, viewModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.updateTitle();
          },
        ),
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: viewModel.navigateToNewView, child: Text('go to ')),
            Text(viewModel.title),
          ],
        ),
      ),
      viewModelBuilder: () => NonReactiveViewModel(),
    );
  }
}
