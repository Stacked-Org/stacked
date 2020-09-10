import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'dark_light_viewmodel.dart';

class DarkLightView extends StatelessWidget {
  const DarkLightView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DarkLightViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              'This adjusts Dark/Light depending on the System brightness setting and if you set themeMode to system in the main file.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => DarkLightViewModel(),
    );
  }
}
