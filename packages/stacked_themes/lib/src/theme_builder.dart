import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_themes/src/theme_manager.dart';

/// A widget that rebuilds itself with a new theme
class ThemeBuilder extends StatefulWidget {
  final Widget Function(BuildContext, ThemeData, ThemeData, ThemeMode) builder;
  final List<ThemeData> themes;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final Color Function(ThemeData) statusBarColorBuilder;
  final ThemeMode defaultThemeMode;

  ThemeBuilder({
    Key key,
    @required this.builder,
    this.themes,
    this.lightTheme,
    this.darkTheme,
    this.statusBarColorBuilder,
    this.defaultThemeMode = ThemeMode.system,
  }) : super(key: key);

  @override
  _ThemeBuilderState createState() => _ThemeBuilderState(
        ThemeManager(
          themes: themes,
          statusBarColorBuilder: statusBarColorBuilder,
          darkTheme: darkTheme,
          lightTheme: lightTheme,
        ),
      );
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  final ThemeManager themeManager;

  _ThemeBuilderState(this.themeManager);

  @override
  Widget build(BuildContext context) {
    return Provider<ThemeManager>.value(
      value: themeManager,
      builder: (context, child) => StreamProvider<ThemeModel>(
        lazy: false,
        create: (context) => themeManager.themesStream,
        builder: (context, child) => Consumer<ThemeModel>(
          child: child,
          builder: (context, themeModel, child) => widget.builder(
            context,
            themeModel?.selectedTheme,
            themeModel?.darkTheme,
            themeModel?.themeMode,
          ),
        ),
      ),
    );
  }
}
