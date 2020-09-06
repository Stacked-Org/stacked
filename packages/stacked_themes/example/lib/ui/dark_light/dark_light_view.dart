import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'dark_light_viewmodel.dart';

class DarkLightView extends StatelessWidget {
  const DarkLightView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DarkLightViewModel>.reactive(
      builder: (context, model, child) => Scaffold(),
      viewModelBuilder: () => DarkLightViewModel(),
    );
  }
}
