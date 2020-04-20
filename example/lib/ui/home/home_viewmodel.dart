import 'package:stacked/_base_viewmodels.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel() {
    print('HomeViewModel created');
  }

  void updateData() {
    notifyListeners();
  }

  void initialise() {
    print('HomeViewModel initialise');
  }
}
