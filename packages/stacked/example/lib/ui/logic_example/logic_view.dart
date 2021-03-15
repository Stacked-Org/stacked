import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'logiv_viewmodel.dart';

class LogicView extends StatelessWidget {
  const LogicView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LogicViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            MaterialButton(
                child: model.isBusy
                    ? CircularProgressIndicator()
                    : Text('Get Humans'),
                onPressed: model.getInfo)
          ],
        ),
      ),
      viewModelBuilder: () => LogicViewModel(),
    );
  }
}
