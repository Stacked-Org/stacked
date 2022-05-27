import 'package:flutter/material.dart';

class WidgetWrapper extends StatelessWidget {
  final Widget view;
  const WidgetWrapper({Key? key, required this.view}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: view);
  }
}
