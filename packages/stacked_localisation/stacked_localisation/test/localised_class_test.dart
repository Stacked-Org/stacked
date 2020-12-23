import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_localisation/src/localisation_service.dart';
import 'package:stacked_localisation/src/mixins/localised_class.dart';

import 'test_helpers.dart';

class LocalisationModel with LocalisedClass {}

void main() {
  group('LocalisedClassTest -', () {
    setUp(() => registerServices());
    tearDown(() => unregisterServices());

    group('translate -', () {
      test(
          'When called should return the value returned from the localisation service',
          () {
        var model = LocalisationModel();
        var translated = model.translate('key');
        expect(translated, 'hello, world');
      });

      test(
          'When called with a list of replacements should replace the value in order',
          () {
        getAndRegisterLocalistionService(
            localisationString: 'You have tapped {0} times');
        var model = LocalisationModel();
        var translated = model.translate('key', replacements: [9]);
        expect(translated, 'You have tapped 9 times');
      });

      test(
          'When called with multiple replacements for {0} should replace all of them',
          () {
        getAndRegisterLocalistionService(
            localisationString: 'The number {0} will be shown here {0} too.');
        var model = LocalisationModel();
        var translated = model.translate('key', replacements: [9]);
        expect(translated, 'The number 9 will be shown here 9 too.');
      });

      test(
          'When called with multiple replacements for different indices should replace all of them',
          () {
        getAndRegisterLocalistionService(localisationString: '{0} {1} {2} {3}');
        var model = LocalisationModel();
        var translated =
            model.translate('key', replacements: [9, 5, 'String', true]);
        expect(translated, '9 5 String true');
      });
    });
  });
}
