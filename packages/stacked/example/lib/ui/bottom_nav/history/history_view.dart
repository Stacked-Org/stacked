import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'history_viewmodel.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(child: Text('History'))
      ),
      viewModelBuilder: () => HistoryViewModel(),
    );
  }
}
