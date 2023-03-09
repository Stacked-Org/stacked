import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../datamodels/clashable_two.dart';

class NonReactiveViewModel extends BaseViewModel {
  final _routerService = exampleLocator<RouterService>();
  String title = 'This should not change';

  void updateTitle() {
    title += '. This has changed';
    notifyListeners();
  }

  void navigateToNewView() {
    _routerService.navigateTo(
      StreamCounterViewRoute(clashableTwo: const [Clashable(22)]),
    );
  }

  void navigateBackHome() {
    _routerService.clearStackAndShow(HomeViewRoute(title: 'Home'));
  }
}
