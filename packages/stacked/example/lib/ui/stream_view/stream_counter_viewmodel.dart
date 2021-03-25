import 'package:new_architecture/app/app.locator.dart';
import 'package:new_architecture/services/epoch_service.dart';
import 'package:stacked/stacked.dart';

class StreamCounterViewModel extends StreamViewModel<int> {
  String get title => 'This is the time since epoch in seconds \n $data';

  late Stream<int> _currentSource;
  bool isSlowEpochNumbers = true;

  StreamCounterViewModel() {
    _setSource();
  }

  void _setSource() {
    _currentSource = isSlowEpochNumbers
        ? locator<EpochService>().epochUpdatesNumbers()
        : locator<EpochService>().epochUpdateNumbersQuickly();
  }

  @override
  Stream<int> get stream => _currentSource;

  @override
  void onData(int? data) {}

  @override
  void onCancel() {}

  @override
  void onSubscribed() {}

  @override
  void onError(error) {}

  void changeStreamSources() {
    isSlowEpochNumbers = !isSlowEpochNumbers;
    _setSource();
    notifySourceChanged();
  }
}
