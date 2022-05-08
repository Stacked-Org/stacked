import 'package:flutter_test/flutter_test.dart';
import 'package:playground/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('OrderDetailsViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
