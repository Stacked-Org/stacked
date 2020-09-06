import 'package:stacked/stacked.dart';

class ThemeModel {
  final int index;
  final String title;

  ThemeModel({this.index, this.title});
}

class MultipleThemesViewModel extends BaseViewModel {
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
}
