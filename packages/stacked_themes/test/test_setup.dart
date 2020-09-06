import 'package:mockito/mockito.dart';
import 'package:stacked_themes/src/locator_setup.dart';
import 'package:stacked_themes/src/services/shared_preferences_service.dart';
import 'package:stacked_themes/src/services/statusbar_service.dart';

class SharedPreferencesServiceMock extends Mock
    implements SharedPreferencesService {}

class StatusBarServiceMock extends Mock implements StatusBarService {}

SharedPreferencesService getAndRegisterSharedPreferencesServiceMock(
    {int themeIndex}) {
  _removeRegistrationIfExists<SharedPreferencesService>();
  var service = SharedPreferencesServiceMock();

  when(service.themeIndex).thenReturn(themeIndex);

  locator.registerSingleton<SharedPreferencesService>(service);
  return service;
}

StatusBarService getAndRegisterStatusBarServiceMock() {
  _removeRegistrationIfExists<StatusBarService>();
  var service = StatusBarServiceMock();
  locator.registerSingleton<StatusBarService>(service);
  return service;
}

// Call this before any service registration helper. This is to ensure that if there
// is a service registered we remove it first. We register all services to remove boiler plate from tests
void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerServices() {
  getAndRegisterSharedPreferencesServiceMock();
  getAndRegisterStatusBarServiceMock();
}

void unregisterServices() {
  locator.unregister<SharedPreferencesService>();
  locator.unregister<StatusBarService>();
}
