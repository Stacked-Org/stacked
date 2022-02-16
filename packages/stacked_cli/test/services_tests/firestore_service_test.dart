import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirestoreServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

