import 'package:stacked/stacked.dart';

class FavoritesViewModel extends BaseViewModel {
  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void setCounterTo999() {
    _counter = 999;
    notifyListeners();
  }
}
