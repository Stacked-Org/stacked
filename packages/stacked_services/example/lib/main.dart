import 'package:example/ui/setup_bottom_sheet_ui.dart';
import 'package:example/ui/setup_dialog_ui.dart';
import 'package:example/ui/setup_snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'app/routes.gr.dart' as auto_router;

void main() {
  setupLocator();
  setupDialogUi();
  setupSnackbarUi();
  setupBottomSheetUi();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stacked Services Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [StackedService.routeObserver],
      navigatorKey: StackedService.navigatorKey,
      initialRoute: auto_router.Routes.homeScreenRoute,
      onGenerateRoute: auto_router.Router().onGenerateRoute,
    );
  }
}
