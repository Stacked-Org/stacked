import 'package:new_architecture/app/locator.dart';
import 'package:new_architecture/services/information_service.dart';
import 'package:stacked/stacked.dart';

class WidgetTwoViewModel extends ReactiveViewModel {
  final InformationService _informationService = locator<InformationService>();
  int get postCount => _informationService.postCount;

  final int id;
  WidgetTwoViewModel(this.id) {
    reactToServices([_informationService]);
  }

  void reset() {
    _informationService.resetCount();
  }
}
