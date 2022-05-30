import 'package:flutter/material.dart';
import 'package:example/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class DetailsView extends StatelessWidget {
  final String name;

  const DetailsView({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = NavigationService();
    navigationService.navigateTo(
      Routes.detailsView,
      arguments: DetailsViewArguments(name: 'FilledStacks'),
    );
    return Container(
      child: Text(name),
    );
  }
}
