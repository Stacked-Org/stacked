import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'multiple_streams_example_viewmodel.dart';

class MultipleStreamsExampleView extends StatelessWidget {
  const MultipleStreamsExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultipleStreamsExampleViewModel>.reactive(
        builder: (context, viewModel, child) => Scaffold(
              body: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      color: Colors.yellow,
                      child: !viewModel.hasNumberData
                          ? CircularProgressIndicator()
                          : Column(
                              children: <Widget>[
                                Text(viewModel.stringStreamDelay.toString() + 'ms'),
                                Text(viewModel.number.toString()),
                              ],
                            ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 90,
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: !viewModel.hasRandomString
                          ? CircularProgressIndicator()
                          : Column(
                              children: <Widget>[
                                Text(
                                    viewModel.numbersStreamDelay.toString() + 'ms'),
                                Text(viewModel.randomString),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: MaterialButton(
                child: Text('Change Stream Source Faster'),
                onPressed: viewModel.swapStreams,
              ),
            ),
        viewModelBuilder: () => MultipleStreamsExampleViewModel());
  }
}
