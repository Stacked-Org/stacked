import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../smart_widgets/widget_one/widget_one.dart';
import '../smart_widgets/widget_two/widget_two.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(viewModel.title),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  WidgetOne(),
                  SizedBox(width: 50),
                  WidgetTwo(id: 2),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.navigate,
        ),
      ),
    );
  }
}
