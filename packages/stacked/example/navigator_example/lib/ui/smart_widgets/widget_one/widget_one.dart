import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'widget_one_viewmodel.dart';

class WidgetOne extends StatelessWidget {
  const WidgetOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WidgetOneViewModel>.reactive(
      viewModelBuilder: () => WidgetOneViewModel(),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => viewModel.updatePostCount(),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
          alignment: Alignment.center,
          child: !viewModel.busy(viewModel)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Tap to increment',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      viewModel.postCount.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
