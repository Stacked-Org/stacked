import 'package:flutter/material.dart';
import 'package:new_architecture/ui/stream_view/stream_counter_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StreamCounterView extends StatelessWidget {
  const StreamCounterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StreamCounterViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Text(model.title),
              ),
            ),
        viewModelBuilder: () => StreamCounterViewModel());
  }
}
