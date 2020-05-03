import 'package:flutter/material.dart';

import 'ui/views/hook_viewmodel_widget/hook_viewmodel_widget_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HookViewModelWidgetExample(),
    );
  }
}
