import 'package:example/app/app.locator.dart';
import 'package:example/app/app.logger.dart';
import 'package:example/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel with MessageStateHelper {
  final log = getLogger('HomeViewModel');
  final RouterService _routerService = exampleLocator<RouterService>();

  String title = 'default';
  int counter = 0;

  void navigate() {
    _routerService.navigateTo(
      const NonReactiveViewRoute(),
    );
  }

  void initialise() {
    setMessage('initialise');
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
