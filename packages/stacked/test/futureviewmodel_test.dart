import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/src/view_models/data_models/multiple_data_models.dart';
import 'package:stacked/src/view_models/data_models/single_data_models.dart';

const _SingleFutureExceptionFailMessage = 'Future to Run failed';

class TestFutureViewModel extends FutureViewModel<int?> {
  final bool fail;
  final bool shouldRethrow;
  TestFutureViewModel({
    this.fail = false,
    this.shouldRethrow = false,
  });

  int numberToReturn = 5;
  bool dataCalled = false;

  @override
  bool get rethrowException => shouldRethrow;

  @override
  Future<int?> futureToRun() async {
    await Future.delayed(Duration(milliseconds: 20));
    if (fail) throw Exception(_SingleFutureExceptionFailMessage);
    return numberToReturn;
  }

  void setErrorManually() {
    setError('my error');
  }

  @override
  void onData(int? data) {
    dataCalled = true;
  }
}

const String NumberDelayFuture = 'delayedNumber';
const String StringDelayFuture = 'delayedString';
const String _NumberDelayExceptionMessage = 'getNumberAfterDelay failed';

class TestMultipleFutureViewModel extends MultipleFutureViewModel {
  final bool failOne;
  final int futureOneDuration;
  final int futureTwoDuration;
  TestMultipleFutureViewModel(
      {this.failOne = false,
      this.futureOneDuration = 300,
      this.futureTwoDuration = 400});

  int numberToReturn = 5;

  @override
  Map<String, Future Function()> get futuresMap => {
        NumberDelayFuture: getNumberAfterDelay,
        StringDelayFuture: getStringAfterDelay,
      };

  Future<int> getNumberAfterDelay() async {
    if (failOne) {
      throw Exception(_NumberDelayExceptionMessage);
    }
    await Future.delayed(Duration(milliseconds: futureOneDuration));
    return numberToReturn;
  }

  Future<String> getStringAfterDelay() async {
    await Future.delayed(Duration(milliseconds: futureTwoDuration));
    return 'String data';
  }
}

void main() {
  group('FutureViewModel', () {
    test('When error is manually set, hasError should be true', () async {
      var futureViewModel = TestFutureViewModel();
      futureViewModel.setErrorManually();

      expect(futureViewModel.hasError, isTrue);
    });
    test('When future is complete data should be set and ready', () async {
      var futureViewModel = TestFutureViewModel();
      await futureViewModel.initialise();
      expect(futureViewModel.data, 5);
      expect(futureViewModel.dataReady, true);
    });

    test('When a future fails it should indicate there\'s an error and no data',
        () async {
      var futureViewModel = TestFutureViewModel(fail: true);
      await futureViewModel.initialise();
      expect(futureViewModel.hasError, true);
      expect(futureViewModel.data, null,
          reason: 'No data should be set when there\'s a failure.');
      expect(futureViewModel.dataReady, false);
    });

    test('When a future runs it should indicate busy', () async {
      var futureViewModel = TestFutureViewModel();
      futureViewModel.initialise();
      expect(futureViewModel.isBusy, true);
    });

    test('When a future fails it should indicate NOT busy', () async {
      var futureViewModel = TestFutureViewModel(fail: true);
      await futureViewModel.initialise();
      expect(futureViewModel.isBusy, false);
    });

    test(
        'When a future fails and rethrowException is true, should throw exception',
        () async {
      var futureViewModel =
          TestFutureViewModel(fail: true, shouldRethrow: true);
      expect(() async => await futureViewModel.initialise(), throwsException);
    });

    test('When a future fails it should set error to exception', () async {
      var futureViewModel = TestFutureViewModel(fail: true);
      await futureViewModel.initialise();
      expect(futureViewModel.modelError.message,
          _SingleFutureExceptionFailMessage);
    });

    test('When a future fails onData should not be called', () async {
      var futureViewModel = TestFutureViewModel(fail: true);
      await futureViewModel.initialise();
      expect(futureViewModel.dataCalled, false);
    });

    test('When a future passes onData should not called', () async {
      var futureViewModel = TestFutureViewModel();
      await futureViewModel.initialise();
      expect(futureViewModel.dataCalled, true);
    });

    group('Dynamic Source Tests', () {
      test('notifySourceChanged - When called should re-run Future', () async {
        var futureViewModel = TestFutureViewModel();
        await futureViewModel.initialise();
        expect(futureViewModel.data, 5);
        futureViewModel.numberToReturn = 10;
        futureViewModel.notifySourceChanged();
        await futureViewModel.initialise();
        expect(futureViewModel.data, 10);
      });
    });
  });

  group('MultipleFutureViewModel -', () {
    test(
        'When running multiple futures the associated key should hold the value when complete',
        () async {
      var futureViewModel = TestMultipleFutureViewModel();
      await futureViewModel.initialise();

      expect(futureViewModel.dataMap![NumberDelayFuture], 5);
      expect(futureViewModel.dataMap![StringDelayFuture], 'String data');
    });

    test(
        'When one of multiple futures fail only the failing one should have an error',
        () async {
      var futureViewModel = TestMultipleFutureViewModel(failOne: true);
      await futureViewModel.initialise();

      expect(futureViewModel.hasErrorForKey(NumberDelayFuture), true);
      expect(futureViewModel.hasErrorForKey(StringDelayFuture), false);
    });

    test(
        'When one of multiple futures fail the passed one should have data and failing one not',
        () async {
      var futureViewModel = TestMultipleFutureViewModel(failOne: true);
      await futureViewModel.initialise();

      expect(futureViewModel.dataMap![NumberDelayFuture], null);
      expect(futureViewModel.dataMap![StringDelayFuture], 'String data');
    });

    test('When multiple futures run the key should be set to indicate busy',
        () async {
      var futureViewModel = TestMultipleFutureViewModel();
      futureViewModel.initialise();

      expect(futureViewModel.busy(NumberDelayFuture), true);
      expect(futureViewModel.busy(StringDelayFuture), true);
    });

    test(
        'When multiple futures are complete the key should be set to indicate NOT busy',
        () async {
      var futureViewModel = TestMultipleFutureViewModel();
      await futureViewModel.initialise();

      expect(futureViewModel.busy(NumberDelayFuture), false);
      expect(futureViewModel.busy(StringDelayFuture), false);
    });

    test('When a future fails busy should be set to false', () async {
      var futureViewModel = TestMultipleFutureViewModel(failOne: true);
      await futureViewModel.initialise();

      expect(futureViewModel.busy(NumberDelayFuture), false);
      expect(futureViewModel.busy(StringDelayFuture), false);
    });

    test('When a future fails should set error for future key', () async {
      var futureViewModel = TestMultipleFutureViewModel(failOne: true);
      await futureViewModel.initialise();

      expect(futureViewModel.error(NumberDelayFuture).message,
          _NumberDelayExceptionMessage);

      expect(futureViewModel.error(StringDelayFuture), null);
    });

    test(
        'When 1 future is still running out of two anyObjectsBusy should return true',
        () async {
      var futureViewModel = TestMultipleFutureViewModel(
          futureOneDuration: 10, futureTwoDuration: 60);
      futureViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 30));

      expect(futureViewModel.busy(NumberDelayFuture), false,
          reason: 'String future should be done at this point');
      expect(futureViewModel.anyObjectsBusy, true,
          reason: 'Should be true because second future is still running');
    });

    group('Dynamic Source Tests', () {
      test('notifySourceChanged - When called should re-run Future', () async {
        var futureViewModel = TestMultipleFutureViewModel();
        await futureViewModel.initialise();
        expect(futureViewModel.dataMap![NumberDelayFuture], 5);
        futureViewModel.numberToReturn = 10;
        futureViewModel.notifySourceChanged();
        await futureViewModel.initialise();
        expect(futureViewModel.dataMap![NumberDelayFuture], 10);
      });
    });
  });
}
