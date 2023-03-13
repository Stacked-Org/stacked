import 'package:stacked/stacked.dart';

class InformationService with ListenableServiceMixin {
  int _postCount = 0;
  int get postCount => _postCount;

  void updatePostCount() {
    _postCount++;
    notifyListeners();
  }

  void resetCount() {
    _postCount = 0;
    notifyListeners();
  }
}
