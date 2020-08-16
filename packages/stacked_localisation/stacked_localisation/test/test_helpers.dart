import 'package:mockito/mockito.dart';
import 'package:stacked_localisation/src/setup_locator.dart';
import 'package:stacked_localisation/src/utils/locale_provider.dart';
import 'package:stacked_localisation/src/utils/string_reader.dart';

class LocaleProviderMock extends Mock implements LocaleProvider {}

class StringReaderMock extends Mock implements StringReader {}

LocaleProvider getAndRegisterLocaleProviderMock({String locale = 'en'}) {
  _removeRegistrationIfExists<LocaleProvider>();
  var mock = LocaleProviderMock();
  when(mock.getCurrentLocale())
      .thenAnswer((realInvocation) => Future.value(locale));
  locator.registerSingleton<LocaleProvider>(mock);
  return mock;
}

StringReader getAndRegisterStringReaderMock() {
  _removeRegistrationIfExists<StringReader>();
  var mock = StringReaderMock();
  locator.registerSingleton<StringReader>(mock);
  return mock;
}

// Call this before any service registration helper. This is to ensure that if there
// is a service registered we remove it first. We register all services to remove boiler plate from tests
void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerServices() {
  getAndRegisterLocaleProviderMock();
  getAndRegisterStringReaderMock();
}

void unregisterServices() {
  locator.unregister<LocaleProvider>();
  locator.unregister<StringReader>();
}
