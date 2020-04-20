import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'widget_one_viewmodel.dart';

class WidgetOne extends StatelessWidget {
  const WidgetOne({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WidgetOneViewModel>.reactive(
      viewModelBuilder: () => WidgetOneViewModel(),
      builder: (context, model, child) => GestureDetector(
        onTap: () => model.updatePostCount(),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
          alignment: Alignment.center,
          child: !model.busy(model)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Tap to increment',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      model.postCount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
