import 'package:stacked/stacked.dart';

class WithStackedHookViewModel extends BaseViewModel {
  String title = 'Initial Value';

  void updateTitle(String value) {
    title = value;
    notifyListeners();
  }
}
