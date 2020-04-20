import 'package:new_architecture/app/locator.dart';
import 'package:new_architecture/services/information_service.dart';
import 'package:stacked/_base_viewmodels.dart';

class WidgetOneViewModel extends ReactiveViewModel {
  final InformationService _informationService = locator<InformationService>();
  int get postCount => _informationService.postCount;

  WidgetOneViewModel() {
    reactToServices([
      _informationService,
    ]);
  }

  void updatePostCount() {
    _informationService.updatePostCount();
  }

  Future longUpdateStuff() async {
    var result = await runBusyFuture(updateStuff());
  }

  Future updateStuff() {
    return Future.delayed(const Duration(seconds: 3));
  }
}
