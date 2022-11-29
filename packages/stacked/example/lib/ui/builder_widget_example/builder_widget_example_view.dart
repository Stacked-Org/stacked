import 'package:flutter/material.dart';
import 'package:example/ui/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BuilderWidgetExampleView extends StackedView<HomeViewModel> {
  const BuilderWidgetExampleView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel model, Widget? child) {
    return Scaffold(
      body: Center(
        child: Text(model.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.updateTitle(),
      ),
    );
  }

  @override
  HomeViewModel modelBuilder(BuildContext context) => HomeViewModel();
}
