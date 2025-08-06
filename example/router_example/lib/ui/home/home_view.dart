import 'package:example/datamodels/clashable_one.dart';
import 'package:example/datamodels/home_type.dart';
import 'package:example/ui/smart_widgets/widget_one/widget_one.dart';
import 'package:example/ui/smart_widgets/widget_two/widget_two.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  final String? title;
  final bool? isLoggedIn;
  final List<HomeType> homeTypes;
  final Clashable Function(String name)? clashableGetter;

  const HomeView({
    super.key,
    this.title = 'hello',
    this.isLoggedIn = false,
    this.clashableGetter,
    this.homeTypes = const [HomeType.apartment, HomeType.house],
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Expanded(child: SizedBox.shrink()),
                Text(viewModel.title),
                if (viewModel.hasMessage) Text(viewModel.modelMessage!),
                const SizedBox(height: 20),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    WidgetOne(),
                    SizedBox(width: 50),
                    WidgetTwo(id: 2),
                  ],
                ),
                const SizedBox(height: 20),
                if (title != null) Text(title!),
                const SizedBox(height: 20),
                MaterialButton(
                  onPressed: viewModel.isUserLoggedIn
                      ? viewModel.signOutUser
                      : viewModel.signInUser,
                  color: Colors.blue.shade400,
                  height: 60,
                  minWidth: 150,
                  child: viewModel.isBusy
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          viewModel.isUserLoggedIn ? 'Sign Out' : 'Sign In',
                          style: const TextStyle(color: Colors.white),
                        ),
                ),
                const Expanded(child: SizedBox.shrink()),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Operative System: ${viewModel.operativeSystem}'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Device ID: ${viewModel.deviceId}'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.navigate,
        ),
      ),
    );
  }
}
