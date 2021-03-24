import 'package:flutter/material.dart';
import 'package:new_architecture/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import 'favorites_viewmodel.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.incrementCounter(),
          ),
          body: Center(
              child: Text(
            model.counter.toString(),
            style: TextStyle(fontSize: 30),
          ))),
      viewModelBuilder: () => locator<FavoritesViewModel>(),
      onModelReady: (model) => model.setCounterTo999(),
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
    );
  }
}
