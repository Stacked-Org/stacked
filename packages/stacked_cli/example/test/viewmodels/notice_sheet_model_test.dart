import 'package:flutter_test/flutter_test.dart';
import 'package:example/app/app.locator.dart';
import 'package:example/ui/bottom_sheets/notice/notice_sheet_model.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
