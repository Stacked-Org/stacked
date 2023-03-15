import 'package:flutter/material.dart';
import 'package:example/ui/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupVieWModel>.reactive(
      viewModelBuilder: () => StartupVieWModel(),
      builder: (context, viewModel, child) => const Scaffold(
        body: Center(
          child: Text('Startup View'),
        ),
      ),
    );
  }
}
