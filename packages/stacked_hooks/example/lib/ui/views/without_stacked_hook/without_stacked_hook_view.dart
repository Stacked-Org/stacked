import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'without_stacked_hook_viewmodel.dart';

class WithoutStackedHookView extends StackedView<WithoutStackedHookViewModel> {
  const WithoutStackedHookView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WithoutStackedHookViewModel model,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example without Stacked Hook')),
      body: Container(padding: const EdgeInsets.all(20.0)),
    );
  }

  @override
  WithoutStackedHookViewModel viewModelBuilder(BuildContext context) {
    return WithoutStackedHookViewModel();
  }
}
