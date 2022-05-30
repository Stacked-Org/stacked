import 'package:flutter/material.dart';
import 'package:new_architecture/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import 'history_viewmodel.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      builder: (context, viewModel, child) => Scaffold(
          body: Center(
              child: viewModel.isBusy
                  ? const CircularProgressIndicator()
                  : Text(viewModel.data.toString()))),
      viewModelBuilder: () => exampleLocator<HistoryViewModel>(),
    );
  }
}
