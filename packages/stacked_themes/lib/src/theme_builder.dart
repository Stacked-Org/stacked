import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_themes/src/theme_manager.dart';

/// A widget that rebuilds itself with a new theme
class ThemeBuilder extends StatefulWidget {
  final Widget Function(BuildContext, ThemeData, ThemeData) builder;
  final List<ThemeData> themes;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final Color Function(ThemeData) statusBarColorBuilder;
  final bool useSystemTheme;
  final bool startInDarkMode;

  ThemeBuilder({
    Key key,
    @required this.builder,
    this.themes,
    this.lightTheme,
    this.darkTheme,
    this.statusBarColorBuilder,
    this.useSystemTheme = true,
    this.startInDarkMode = false,
  }) : super(key: key);

  @override
  _ThemeBuilderState createState() => _ThemeBuilderState(ThemeManager(
        themes: themes,
        statusBarColorBuilder: statusBarColorBuilder,
        useSystemTheme: useSystemTheme,
        startInDarkMode: startInDarkMode,
      ));
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  final ThemeManager themeManager;

  _ThemeBuilderState(this.themeManager);

  @override
  Widget build(BuildContext context) {
    return Provider<ThemeManager>.value(
      value: themeManager,
      builder: (context, child) => StreamProvider<Map<String, ThemeData>>(
        create: (context) => themeManager.themesStream,
        builder: (context, child) => Consumer<Map<String, ThemeData>>(
          child: child,
          builder: (context, value, child) => widget.builder(
            context,
            value[SelectedTheme],
            value[DarkTheme],
          ),
        ),
      ),
    );
  }
}
