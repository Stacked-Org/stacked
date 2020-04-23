import 'package:new_architecture/app/locator.dart';
import 'package:new_architecture/services/epoch_service.dart';
import 'package:stacked/stacked.dart';

class StreamCounterViewModel extends StreamViewModel<int> {
  String get title => 'This is the time since epoch in seconds \n $data';

  @override
  Stream<int> get stream => locator<EpochService>().epochUpdatesNumbers();

  @override
  void onData(int data) {}

  @override
  void onCancel() {}

  @override
  void onSubscribed() {}

  @override
  void onError(error) {}
}
