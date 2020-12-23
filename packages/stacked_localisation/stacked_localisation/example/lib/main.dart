import 'package:flutter/material.dart';
import 'package:stacked_localisation/stacked_localisation.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/router.gr.dart';
import 'core/setup_locator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // sets up the internal locator for the localisation service
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: Routes.homeView,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: Router().onGenerateRoute,
    );
  }
}
