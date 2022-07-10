import 'package:example/app/app.locator.dart';
import 'package:example/services/information_service.dart';
import 'package:stacked/stacked.dart';

class WidgetTwoViewModel extends ReactiveViewModel {
  final _informationService = exampleLocator<InformationService>();
  int get postCount => _informationService.postCount;

  final int id;
  WidgetTwoViewModel(this.id);

  void reset() {
    _informationService.resetCount();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_informationService];
}
