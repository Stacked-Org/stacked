import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeViewTraditional extends StatelessWidget {
  const HomeViewTraditional({super.key});

  @override
  Widget build(BuildContext context) {
    // Using the withConsumer constructor gives you the traditional viewmodel
    // binding which will rebuild when notifyListeners is called. This is used
    // when the model does not have to be consumed by multiple different UI's.
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) => Scaffold(
        floatingActionButton: const UpdateTitleButton(),
        body: Center(
          child: Text(viewModel.title),
        ),
      ),
    );
  }
}

class UpdateTitleButton extends ViewModelWidget<HomeViewModel> {
  const UpdateTitleButton({
    Key? key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, viewModel) {
    return FloatingActionButton(
      onPressed: () {
        viewModel.updateTitle();
      },
    );
  }
}
