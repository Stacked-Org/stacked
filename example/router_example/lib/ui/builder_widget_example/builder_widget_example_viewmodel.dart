import 'package:stacked/stacked.dart';

class BuilderWidgetExampleViewModel extends BaseViewModel {
  String title = 'default';

  int counter = 0;
  void updateTitle() {
    counter++;
    title = '$counter';
    notifyListeners();
  }
}
