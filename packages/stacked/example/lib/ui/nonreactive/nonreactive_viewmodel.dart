import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../datamodels/clashable_two.dart';

class NonReactiveViewModel extends BaseViewModel {
  final _navigationService = exampleLocator<NavigationService>();
  String title = 'This should not change';

  void updateTitle() {
    title += '. This has changed';
    notifyListeners();
  }

  void navigateToNewView() {
    _navigationService
        .navigateToStreamCounterView(clashableTwo: [const Clashable(22)]);
  }

  void navigateBackHome() {
    _navigationService.clearStackAndShow(
      Routes.homeView,
      arguments: const HomeViewArguments(title: 'Home'),
    );
  }
}
