import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'multiple_streams_example_viewmodel.dart';

class MultipleStreamsExampleView extends StatelessWidget {
  const MultipleStreamsExampleView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultipleStreamsExampleViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      color: Colors.yellow,
                      child: !model.hasNumberData
                          ? CircularProgressIndicator()
                          : Column(
                              children: <Widget>[
                                Text(model.stringStreamDelay.toString() + 'ms'),
                                Text(model.number.toString()),
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
                      child: !model.hasRandomString
                          ? CircularProgressIndicator()
                          : Column(
                              children: <Widget>[
                                Text(
                                    model.numbersStreamDelay.toString() + 'ms'),
                                Text(model.randomString),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: MaterialButton(
                child: Text('Change Stream Source Faster'),
                onPressed: model.swapStreams,
              ),
            ),
        viewModelBuilder: () => MultipleStreamsExampleViewModel());
  }
}
