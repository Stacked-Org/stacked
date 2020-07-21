import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'home_viewmodel.dart';

class HookViewModelWidgetExample extends StatelessWidget {
  const HookViewModelWidgetExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
          body: Center(
        child: _HookForm(),
      )),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class _HookForm extends HookViewModelWidget<HomeViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, HomeViewModel model) {
    var title = useTextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(model.title),
        TextField(
          controller: title,
          onChanged: model.updateTile,
        )
      ],
    );
  }
}
