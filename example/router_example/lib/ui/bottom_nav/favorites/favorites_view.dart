import 'package:example/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'favorites_viewmodel.dart';

class FavoritesView extends StatelessWidget {
  final String? id;
  const FavoritesView({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel.incrementCounter(),
          ),
          body: Center(
              child: Text(
            viewModel.counter.toString(),
            style: const TextStyle(fontSize: 30),
          ))),
      viewModelBuilder: () => exampleLocator<FavoritesViewModel>(),
      onViewModelReady: (viewModel) => viewModel.setCounterTo999(),
      disposeViewModel: false,
      fireOnViewModelReadyOnce: true,
    );
  }
}
