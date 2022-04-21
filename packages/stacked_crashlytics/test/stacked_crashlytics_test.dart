import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_crashlytics/stacked_crashlytics.dart';

import 'firebase_mock.dart';

void main() {
  group('crashApp -', () {
    setUp(() {
      setupFirebaseAuthMocks();
      Firebase.initializeApp();
    });
    test('when called, it should crash the app', () async {
      var service = await CrashlyticsService.getInstance();
      service.crashApp();
    });
  });
}
