import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_localisation/src/localisation_service.dart';

import 'test_helpers.dart';

void main() {
  group('LocalisationServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());

    group('initialise -', () {
      test('When called should get the locale from the locale provider',
          () async {
        final localeProvider = getAndRegisterLocaleProviderMock();
        var service = LocalisationService();
        await service.initialise();
        verify(localeProvider.getCurrentLocale());
      });

      test(
          'When called should request the strings using that returned locale from the provider',
          () async {
        final stringReader = getAndRegisterStringReaderMock();
        var service = LocalisationService();
        await service.initialise();
        verify(stringReader.getStringsFromAssets('en'));
      });
    });
  });
}
