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
      navigatorObservers: [
        StackedService.routeObserver,
        _LoggingObserver(),
      ],
      navigatorKey: StackedService.navigatorKey,
      initialRoute: auto_router.Routes.homeScreenRoute,
      onGenerateRoute: auto_router.Router().onGenerateRoute,
    );
  }
}

class _LoggingObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route previousRoute) {
    print(
        'route.name: ${route?.settings?.name}, previousRoute.name: ${previousRoute?.settings?.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    print(
        'route.name: ${route?.settings?.name}, previousRoute.name: ${previousRoute?.settings?.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didPush(Route route, Route previousRoute) {
    print(
        'route.name: ${route?.settings?.name}, previousRoute.name: ${previousRoute?.settings?.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    print(
        'newRoute.name: ${newRoute?.settings?.name}, oldRoute.name: ${oldRoute?.settings?.name}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
