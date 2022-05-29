import 'package:new_architecture/app/app.locator.dart';
import 'package:new_architecture/app/app.router.dart';
import 'package:new_architecture/services/epoch_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StreamCounterViewModel extends StreamViewModel<int> {
  final _navigationService = exampleLocator<NavigationService>();

  String get title => 'This is the time since epoch in seconds \n $data';

  late Stream<int> _currentSource;
  bool isSlowEpochNumbers = true;

  String get streamSource => isSlowEpochNumbers ? 'Slow' : 'Fast';

  StreamCounterViewModel() {
    _setSource();
  }

  void _setSource() {
    _currentSource = isSlowEpochNumbers
        ? exampleLocator<EpochService>().epochUpdatesNumbers()
        : exampleLocator<EpochService>().epochUpdateNumbersQuickly();
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

  void navigateToNewView() {
    _navigationService.navigateTo(Routes.exampleFormView);
  }
}
