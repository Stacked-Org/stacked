import 'package:stacked/_base_viewmodels.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel() {
    print('HomeViewModel created');
  }

  String title = 'default';

  void initialise() {
    print('HomeViewModel initialise');
    title = 'initialised';
    notifyListeners();
  }

  int counter = 0;
  void updateTitle() {
    counter++;
    title = '$counter';
    notifyListeners();
  }

  void updateData() {
    notifyListeners();
  }
}
