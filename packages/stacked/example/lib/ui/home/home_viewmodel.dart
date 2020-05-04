import 'file:///G:/os/FilledStacks/stacked/packages/stacked/lib/src/base_view_models.dart';

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

  void updateTile(String value) {
    title = value;
    notifyListeners();
  }
}
