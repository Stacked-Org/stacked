import 'package:example/datamodels/clashable_one.dart';
import 'package:example/datamodels/home_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../smart_widgets/widget_one/widget_one.dart';
import '../smart_widgets/widget_two/widget_two.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  final String? title;
  final bool? isLoggedIn;
  final List<HomeType> homeTypes;
  final Clashable Function(String name)? clashableGetter;

  const HomeView({
    Key? key,
    this.title = 'hello',
    this.isLoggedIn = false,
    this.clashableGetter,
    this.homeTypes = const [
      HomeType.apartment,
      HomeType.house,
    ],
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
              if (viewModel.hasMessage) Text(viewModel.modelMessage!),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  WidgetOne(),
                  SizedBox(width: 50),
                  WidgetTwo(id: 2),
                ],
              ),
              const SizedBox(height: 20),
              if (title != null) Text(title!),
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
