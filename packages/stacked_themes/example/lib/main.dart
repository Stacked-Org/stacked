import 'package:flutter/material.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:themes_example/ui/multiple_themes/multiple_themes_view.dart';

Future main() async {
  await ThemeManager.initialise();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      themes: [
        ThemeData(backgroundColor: Colors.blue, accentColor: Colors.yellow),
        ThemeData(backgroundColor: Colors.white, accentColor: Colors.green),
        ThemeData(backgroundColor: Colors.purple, accentColor: Colors.green),
        ThemeData(backgroundColor: Colors.black, accentColor: Colors.red),
        ThemeData(backgroundColor: Colors.red, accentColor: Colors.blue),
      ],
      startInDarkMode: Theme.of(context).brightness == Brightness.dark,
      statusBarColorBuilder: (theme) => theme.accentColor,
      builder: (context, regularTheme, darkTheme) => MaterialApp(
        title: 'Flutter Demo',
        theme: regularTheme,
        darkTheme: darkTheme,
        home: MultipleThemesView(),
      ),
    );
  }
}
