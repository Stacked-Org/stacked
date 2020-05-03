import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  String title = 'default';

  void updateTile(String value) {
    title = value;
    notifyListeners();
  }
}
