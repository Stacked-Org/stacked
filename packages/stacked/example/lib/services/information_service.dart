import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class InformationService with ReactiveServiceMixin {
  InformationService() {
    listenToReactiveValues([_postCount]);
  }

  RxValue<int> _postCount = RxValue<int>(initial: 0);
  int get postCount => _postCount.value;

  void updatePostCount() {
    _postCount.value++;
  }

  void resetCount() {
    _postCount.value = 0;
  }
}
