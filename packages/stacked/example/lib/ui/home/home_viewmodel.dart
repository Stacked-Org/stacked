import 'package:example/app/app.locator.dart';
import 'package:example/app/app.logger.dart';
import 'package:example/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum HomeType { caravan, appartment }

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final NavigationService _navigationService =
      exampleLocator<NavigationService>();

  String title = 'default';
  int counter = 0;

  void navigate() {
    _navigationService.navigateToNonReactiveView();
  }

  void initialise() {
    log.i('initialise');
    title = 'Initialised';
    notifyListeners();
  }

  void updateTitle() {
    counter++;
    title = '$counter';
    notifyListeners();
  }

  void updateData() {
    notifyListeners();
  }

  void updateTile(String value) {
    title = value;
    notifyListeners();
  }
}
