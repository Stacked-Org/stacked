import 'package:flutter/material.dart';
import 'package:new_architecture/ui/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BuilderWidgetExampleView extends ViewModelBuilderWidget<HomeViewModel> {
  @override
  Widget builder(
    BuildContext context,
    HomeViewModel model,
    Widget child,
  ) {
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
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
