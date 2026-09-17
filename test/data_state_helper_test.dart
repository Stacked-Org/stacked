import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/src/view_models/helpers/busy_error_state_helper.dart';
import 'package:stacked/src/view_models/helpers/data_state_helper.dart';

/// Minimal harness that mixes in [DataStateHelper] directly so its
/// [DataStateHelper.safeData] getter can be tested in isolation, without
/// going through a full [FutureViewModel]/[StreamViewModel].
class TestDataStateHolder<T> extends ChangeNotifier
    with BusyAndErrorStateHelper, DataStateHelper<T> {
  void setData(T? value) {
    data = value;
  }

  void markBusy(bool value) {
    setBusy(value);
  }

  void markError(dynamic value) {
    setError(value);
  }
}

void main() {
  group('DataStateHelper.safeData -', () {
    test('When dataReady is true, safeData returns the data', () {
      var holder = TestDataStateHolder<int>();
      holder.setData(42);

      expect(holder.dataReady, isTrue);
      expect(holder.safeData, 42);
    });

    test('When data has never been set, safeData throws a StateError', () {
      var holder = TestDataStateHolder<int>();

      expect(holder.dataReady, isFalse);
      expect(() => holder.safeData, throwsStateError);
    });

    test('When the ViewModel is busy, safeData throws a StateError', () {
      var holder = TestDataStateHolder<int>();
      holder.setData(42);
      holder.markBusy(true);

      expect(holder.dataReady, isFalse);
      expect(() => holder.safeData, throwsStateError);
    });

    test('When the ViewModel has an error, safeData throws a StateError', () {
      var holder = TestDataStateHolder<int>();
      holder.setData(42);
      holder.markError('Something went wrong');

      expect(holder.dataReady, isFalse);
      expect(() => holder.safeData, throwsStateError);
    });

    test('The StateError message should point the caller at dataReady', () {
      var holder = TestDataStateHolder<int>();

      expect(
        () => holder.safeData,
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            allOf(contains('dataReady'), contains('safeData')),
          ),
        ),
      );
    });

    test(
        'When T is nullable and the real value is legitimately null, '
        'dataReady stays false (existing dataReady semantics) so safeData '
        'still throws rather than returning null', () {
      var holder = TestDataStateHolder<String?>();
      holder.setData(null);

      // dataReady is defined as `_data != null && !hasError && !isBusy`, so
      // a legitimately-null value for a nullable T can never be "ready".
      // safeData intentionally does not change this - it only adds a
      // non-null accessor on top of the existing dataReady contract.
      expect(holder.dataReady, isFalse);
      expect(() => holder.safeData, throwsStateError);
    });

    test(
        'When T is nullable and a non-null value is set, safeData returns it',
        () {
      var holder = TestDataStateHolder<String?>();
      holder.setData('hello');

      expect(holder.dataReady, isTrue);
      expect(holder.safeData, 'hello');
    });

    test(
        'After data is cleared and an error is set, safeData throws instead '
        'of returning stale data', () {
      var holder = TestDataStateHolder<int>();
      holder.setData(42);
      holder.setData(null);
      holder.markError('failed');

      expect(holder.dataReady, isFalse);
      expect(() => holder.safeData, throwsStateError);
    });
  });
}
