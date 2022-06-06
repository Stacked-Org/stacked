import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class NonReactiveViewModel extends BaseViewModel {
  final _navigationService = exampleLocator<NavigationService>();
  String title = 'This should not change';

  void updateTitle() {
    title += '. This has changed';
    notifyListeners();
  }

  void navigateToNewView() {
    _navigationService.navigateTo(Routes.streamCounterView);
  }

  void navigateBackHome() {
    _navigationService.clearStackAndShow(
      Routes.homeView,
      arguments: HomeViewArguments(title: 'Home'),
    );
  }
}
