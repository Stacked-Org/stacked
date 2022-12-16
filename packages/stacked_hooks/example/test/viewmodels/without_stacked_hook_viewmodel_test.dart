import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_hooks_example/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('WithoutStackedHookViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
