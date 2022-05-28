import 'package:flutter/material.dart';
import 'package:new_architecture/ui/multiple_futures_example/multiple_futures_example_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MultipleFuturesExampleView extends StatelessWidget {
  const MultipleFuturesExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultipleFuturesExampleViewModel>.reactive(
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
                      child: viewModel.fetchingNumber
                          ? const CircularProgressIndicator()
                          : Text(viewModel.fetchedNumber.toString()),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: viewModel.fetchingString
                          ? const CircularProgressIndicator()
                          : Text(viewModel.fetchedString),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => MultipleFuturesExampleViewModel());
  }
}
