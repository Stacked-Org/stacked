import 'package:flutter/material.dart';
import 'package:example/ui/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StackedView<StartupVieWModel> {
  const StartupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartupVieWModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(body: Center(child: Text('Startup View')));
  }

  @override
  StartupVieWModel viewModelBuilder(BuildContext context) {
    return StartupVieWModel();
  }

  @override
  void onViewModelReady(StartupVieWModel viewModel) {
    viewModel.initialise();
    super.onViewModelReady(viewModel);
  }
}
