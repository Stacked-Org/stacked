import 'package:flutter/material.dart';
import 'package:new_architecture/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class DetailsView extends StatelessWidget {
  final String name;

  const DetailsView({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService _navigationService = NavigationService();
    _navigationService.navigateTo(
      Routes.detailsView,
      arguments: DetailsViewArguments(name: 'FilledStacks'),
    );
    return Container(
      child: Text(name),
    );
  }
}
