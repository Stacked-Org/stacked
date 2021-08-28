import 'package:flutter/material.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:themes_example/app/locator.dart';
import 'package:themes_example/ui/dark_light/dark_light_view.dart';
import 'package:themes_example/ui/theme_setup.dart';

Future main() async {
  setupLocator();
  await ThemeManager.initialise();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
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
      statusBarColorBuilder: (theme) => theme?.accentColor,
      navigationBarColorBuilder: (theme) => theme?.accentColor,
      themes: getThemes(),
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
