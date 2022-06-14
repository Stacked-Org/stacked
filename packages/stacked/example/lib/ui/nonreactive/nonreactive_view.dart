import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'nonreactive_viewmodel.dart';

class NonReactiveView extends StatelessWidget {
  const NonReactiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NonReactiveViewModel>.nonReactive(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Non Reactive View'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                viewModel.navigateBackHome();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.updateTitle,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: viewModel.navigateToNewView,
                child: const Text('Go to stream counter view'),
              ),
              const SizedBox(height: 10),
              Text(viewModel.title),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => NonReactiveViewModel(),
    );
  }
}
