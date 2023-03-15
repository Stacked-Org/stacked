import 'package:example/app/app.locator.dart';
import 'package:example/services/information_service.dart';
import 'package:stacked/stacked.dart';

class WidgetOneViewModel extends ReactiveViewModel {
  final InformationService _informationService =
      exampleLocator<InformationService>();
  int get postCount => _informationService.postCount;

  void updatePostCount() {
    _informationService.updatePostCount();
  }

  Future longUpdateStuff() async {
    await runBusyFuture(updateStuff());
  }

  Future updateStuff() {
    return Future.delayed(const Duration(seconds: 3));
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_informationService];
}
