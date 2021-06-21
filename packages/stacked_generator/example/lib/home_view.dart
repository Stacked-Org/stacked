import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final String title;
  const HomeView({Key? key, this.title = 'Default Value  '}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
