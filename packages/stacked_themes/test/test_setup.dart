import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_themes/src/locator_setup.dart';
import 'package:stacked_themes/src/services/platform_service.dart';
import 'package:stacked_themes/src/services/shared_preferences_service.dart';
import 'package:stacked_themes/src/services/statusbar_service.dart';

import 'test_setup.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<SharedPreferencesService>(returnNullOnMissingStub: true),
  MockSpec<StatusBarService>(returnNullOnMissingStub: true),
  MockSpec<PlatformService>(returnNullOnMissingStub: true)
])
SharedPreferencesService getAndRegisterSharedPreferencesServiceMock(
    {int? themeIndex, ThemeMode? userThemeMode}) {
  _removeRegistrationIfExists<SharedPreferencesService>();
  var service = MockSharedPreferencesService();

  when(service.themeIndex).thenReturn(themeIndex);
  when(service.userThemeMode).thenReturn(userThemeMode);

  locator.registerSingleton<SharedPreferencesService>(service);
  return service;
}

StatusBarService getAndRegisterStatusBarServiceMock() {
  _removeRegistrationIfExists<StatusBarService>();
  var service = MockStatusBarService();
  locator.registerSingleton<StatusBarService>(service);
  return service;
}

PlatformService getAndRegisterPlatformService() {
  _removeRegistrationIfExists<PlatformService>();
  final service = MockPlatformService();

  when(service.isMobilePlatform).thenReturn(true);

  locator.registerSingleton<PlatformService>(service);
  return service;
}

// Call this before any service registration helper. This is to ensure that if there
// is a service registered we remove it first. We register all services to remove boiler plate from tests
void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerServices() {
  getAndRegisterSharedPreferencesServiceMock();
  getAndRegisterStatusBarServiceMock();
  getAndRegisterPlatformService();
}

void unregisterServices() {
  locator.unregister<SharedPreferencesService>();
  locator.unregister<StatusBarService>();
  locator.unregister<PlatformService>();
}
