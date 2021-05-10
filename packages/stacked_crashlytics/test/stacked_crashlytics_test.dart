import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stacked_crashlytics/stacked_crashlytics.dart';

void main() {
  group('crashApp -', () {
    test('when called, it should crash the app', () async {
      var service = await CrashlyticsService.getInstance();
      service.crashApp();
    });
  });
}
