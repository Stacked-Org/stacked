import 'package:stacked/stacked.dart';

class InformationService with ListenableServiceMixin {
  final _postCount = ReactiveValue<int>(0);
  int get postCount => _postCount.value;

  void updatePostCount() => _postCount.value++;

  void resetCount() => _postCount.value = 0;

  InformationService() {
    listenToReactiveValues([_postCount]);
  }
}
