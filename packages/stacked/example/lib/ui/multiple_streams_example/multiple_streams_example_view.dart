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
                          ? const CircularProgressIndicator()
                          : Column(
                              children: <Widget>[
                                Text('${viewModel.stringStreamDelay}ms'),
                                Text(viewModel.number.toString()),
                              ],
                            ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 90,
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: !viewModel.hasRandomString
                          ? const CircularProgressIndicator()
                          : Column(
                              children: <Widget>[
                                Text(
                                    '${viewModel.numbersStreamDelay}ms'),
                                Text(viewModel.randomString),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: MaterialButton(
                onPressed: viewModel.swapStreams,
                child: const Text('Change Stream Source Faster'),
              ),
            ),
        viewModelBuilder: () => MultipleStreamsExampleViewModel());
  }
}
