
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_services_example/app/app.locator.dart';
import 'package:stacked_services_example/app/app.router.dart';
import 'package:stacked_services_example/ui/setup_bottom_sheet_ui.dart';
import 'package:stacked_services_example/ui/setup_dialog_ui.dart';
import 'package:stacked_services_example/ui/setup_snackbar_ui.dart';

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
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}

class _LoggingObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    print(
        'route.name: ${route.settings.name}, previousRoute.name: ${previousRoute?.settings.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    print(
        'route.name: ${route.settings.name}, previousRoute.name: ${previousRoute?.settings.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print(
        'route.name: ${route.settings.name}, previousRoute.name: ${previousRoute?.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print(
        'newRoute.name: ${newRoute?.settings.name}, oldRoute.name: ${oldRoute?.settings.name}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
