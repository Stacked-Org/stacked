import 'package:flutter/material.dart';
import 'package:new_architecture/ui/home/home_viewmodel.dart';
import 'package:new_architecture/ui/startup/startup_view.dart';
import 'package:new_architecture/ui/smart_widgets/widget_one/widget_one.dart';
import 'package:new_architecture/ui/smart_widgets/widget_two/widget_two.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(model.title),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  WidgetOne(),
                  SizedBox(
                    width: 50,
                  ),
                  WidgetTwo(id: 2),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StartupView(),
            ));
          },
        ),
      ),
    );
  }
}
