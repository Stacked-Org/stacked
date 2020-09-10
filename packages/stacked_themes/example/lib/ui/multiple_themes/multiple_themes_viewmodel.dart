import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:themes_example/app/locator.dart';

class ThemeModel {
  final int index;
  final String title;

  ThemeModel({this.index, this.title});
}

class MultipleThemesViewModel extends BaseViewModel {
  final ThemeService _themeService = locator<ThemeService>();

  List<ThemeModel> get themes => List<ThemeModel>.generate(
      5,
      (index) => ThemeModel(
            index: index,
            title: _getTitleForIndex(index),
          ));

  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Blue and Yellow';
      case 1:
        return 'Green and White';
      case 2:
        return 'Purple and Green';
      case 3:
        return 'Black and Red';
      case 4:
        return 'Red and Blue';
    }

    return 'No theme for index';
  }

  void setTheme(ThemeModel themeData) =>
      _themeService.selectThemeAtIndex(themeData.index);
}
