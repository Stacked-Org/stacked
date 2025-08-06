import 'package:example/app/app.locator.dart';
import 'package:example/app/app.logger.dart';
import 'package:example/app/app.router.dart';
import 'package:example/services/native_actions_service.dart';
import 'package:example/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel with MessageStateHelper {
  final log = getLogger('HomeViewModel');
  final _routerService = exampleLocator<RouterService>();
  final _preferences = exampleLocator<SharedPreferencesService>();
  final _nativeActionsService = exampleLocator<NativeActionsService>();

  String title = 'default';
  int counter = 0;

  String get deviceId => _nativeActionsService.deviceId;
  String get operativeSystem => _nativeActionsService.operativeSystem;

  bool get isUserLoggedIn => _preferences.isUserLoggedIn;

  void navigate() {
    _routerService.navigateTo(NonReactiveViewRoute());
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

  Future<void> signInUser() async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 500));
    _preferences.isUserLoggedIn = true;
    setBusy(false);
  }

  Future<void> signOutUser() async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 500));
    _preferences.isUserLoggedIn = false;
    setBusy(false);
  }
}
