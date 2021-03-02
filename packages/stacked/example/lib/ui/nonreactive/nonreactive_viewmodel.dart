import 'package:stacked/stacked.dart';

class NonReactiveViewModel extends BaseViewModel {
  String title = 'This should not change';

  void updateTitle() {
    title += '. This has changed';
    notifyListeners();
  }
}
