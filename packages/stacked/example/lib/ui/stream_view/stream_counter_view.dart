import 'package:flutter/material.dart';
import 'package:new_architecture/ui/stream_view/stream_counter_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StreamCounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StreamCounterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(model.title),
        ),
        floatingActionButton: MaterialButton(
          child: Text('Change Stream Srouces'),
          onPressed: model.changeStreamSources,
        ),
      ),
      viewModelBuilder: () => StreamCounterViewModel(),
    );
  }
}
