import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'future_example_viewmodel.dart';

class FutureExampleView extends StatelessWidget {
  const FutureExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FutureExampleViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: viewModel.hasError
            ? Container(
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text(
                  'An error has occered while running the future',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Center(
                child: viewModel.isBusy
                    ? const CircularProgressIndicator()
                    : Text(viewModel.data!),
              ),
      ),
      viewModelBuilder: () => FutureExampleViewModel(),
    );
  }
}
