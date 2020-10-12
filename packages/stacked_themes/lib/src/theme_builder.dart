import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_themes/src/theme_manager.dart';

import '../stacked_themes.dart';

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
          defaultTheme: defaultThemeMode,
        ),
      );
}

class _ThemeBuilderState extends State<ThemeBuilder>
    with WidgetsBindingObserver {
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

  // Get all services
  // final themeService = locator<ThemeService>();
  // @override
  // Widget build(BuildContext context) {
  //   return widget.child;
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        print('appLifeCycleState resumed');
        adjustSystemThemeIfNecessary();
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState suspending');
        break;
    }
  }

  //NOTE: re-apply the appropriate theme when the application gets back into the foreground
  void adjustSystemThemeIfNecessary() {
    switch (themeManager.selectedThemeMode) {
      //do nothing
      case ThemeMode.dark:
        break;
      //do nothing
      case ThemeMode.dark:
        break;
      //reapply theme
      case ThemeMode.system:
        print('reApplying system theme');
        themeManager.setThemeMode(ThemeMode.system);
        break;
      default:
    }
  }
}
