import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:themes_example/ui/dark_light/dark_light_view.dart';
import 'package:themes_example/ui/multiple_themes/multiple_themes_view.dart';

Future main() async {
  await ThemeManager.initialise();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      // themes: [
      //   ThemeData(backgroundColor: Colors.blue, accentColor: Colors.yellow),
      //   ThemeData(backgroundColor: Colors.white, accentColor: Colors.green),
      //   ThemeData(backgroundColor: Colors.purple, accentColor: Colors.green),
      //   ThemeData(backgroundColor: Colors.black, accentColor: Colors.red),
      //   ThemeData(backgroundColor: Colors.red, accentColor: Colors.blue),
      // ],
      defaultThemeMode: ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.blue[700],
        accentColor: Colors.yellow[700],
      ),
      lightTheme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.blue[300],
        accentColor: Colors.yellow[300],
      ),
      statusBarColorBuilder: (theme) => theme.accentColor,
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        title: 'Flutter Demo',
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: DarkLightView(),
      ),
    );
  }
}
