import 'package:example/app/app.locator.dart';
import 'package:example/app/app.logger.dart';
import 'package:example/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';

class StartupVieWModel extends BaseViewModel {
  final _log = getLogger('StartupVieWModel');
  final _preferences = exampleLocator<SharedPreferencesService>();

  void initialise() {
    _log.d('isUserLoggedIn:${_preferences.isUserLoggedIn}');
  }
}
