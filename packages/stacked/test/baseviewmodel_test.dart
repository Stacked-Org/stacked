import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class TestViewModel extends BaseViewModel {
  bool onErrorCalled = false;
  Future runFuture(
      {String? busyKey, bool fail = false, bool throwException = false}) {
    return runBusyFuture(
      _futureToRun(fail),
      busyObject: busyKey,
      throwException: throwException,
    );
  }

  Future runTestErrorFuture(
      {String? key, bool fail = false, bool throwException = false}) {
    return runErrorFuture(
      _futureToRun(fail),
      key: key,
      throwException: throwException,
    );
  }

  Future _futureToRun(bool fail) async {
    await Future.delayed(Duration(milliseconds: 50));
    if (fail) {
      throw Exception('Broken Future');
    }
  }

  @override
  void onFutureError(error, key) {
    onErrorCalled = true;
  }
}

void main() {
  group('BaseViewModel Tests -', () {
    group('Busy functionality -', () {
      test('When setBusy is called with true isBusy should be true', () {
        var viewModel = TestViewModel();
        viewModel.setBusy(true);
        expect(viewModel.isBusy, true);
      });

      test(
          'When setBusyForObject is called with parameter true busy for that object should be true',
          () {
        var property;
        var viewModel = TestViewModel();
        viewModel.setBusyForObject(property, true);
        expect(viewModel.busy(property), true);
      });

      test(
          'When setBusyForObject is called with true then false, should be false',
          () {
        var property;
        var viewModel = TestViewModel();
        viewModel.setBusyForObject(property, true);
        viewModel.setBusyForObject(property, false);
        expect(viewModel.busy(property), false);
      });

      test('When busyFuture is run should report busy for the model', () {
        var viewModel = TestViewModel();
        viewModel.runFuture();
        expect(viewModel.isBusy, true);
      });

      test(
          'When busyFuture is run with busyObject should report busy for the Object',
          () {
        var busyObjectKey = 'busyObjectKey';
        var viewModel = TestViewModel();
        viewModel.runFuture(busyKey: busyObjectKey);
        expect(viewModel.busy(busyObjectKey), true);
      });

      test(
          'When busyFuture is run with busyObject should report NOT busy when error is thrown',
          () async {
        var busyObjectKey = 'busyObjectKey';
        var viewModel = TestViewModel();
        await viewModel.runFuture(busyKey: busyObjectKey, fail: true);
        expect(viewModel.busy(busyObjectKey), false);
      });

      test(
          'When busyFuture is run with busyObject should throw exception if throwException is set to true',
          () async {
        var busyObjectKey = 'busyObjectKey';
        var viewModel = TestViewModel();

        expect(
            () async => await viewModel.runFuture(
                busyKey: busyObjectKey, fail: true, throwException: true),
            throwsException);
      });

      test(
          'When busy future is complete should have called notifyListeners three time, 1 for busy 1 for not busy 1 for restting errorMessage',
          () async {
        var called = 0;
        var viewModel = TestViewModel();
        viewModel.addListener(() {
          ++called;
        });
        await viewModel.runFuture();
        expect(called, 3);
      });

      test(
          'When busy future fails should have called notifyListeners three times, 1 for busy 1 for not busy and 1 for resetting error, 1 for setting error',
          () async {
        var called = 0;
        var viewModel = TestViewModel();
        viewModel.addListener(() {
          ++called;
        });
        await viewModel.runFuture(fail: true);
        expect(called, 4);
      });

      test(
          'When notifyListeners is called before dispose, should not throw exception',
          () async {
        var viewModel = TestViewModel();
        await viewModel.runFuture();
        viewModel.notifyListeners();
        viewModel.dispose();
        expect(() => viewModel.notifyListeners(), returnsNormally);
      });

      test(
          'When notifyListeners is called after dispose, should not throw exception',
          () async {
        var viewModel = TestViewModel();
        await viewModel.runFuture();
        viewModel.dispose();
        viewModel.notifyListeners();
        expect(() => viewModel.notifyListeners(), returnsNormally);
      });
    });

    group('runErrorFuture -', () {
      test('When called and error is thrown should set error', () async {
        var model = TestViewModel();
        await model.runTestErrorFuture(fail: true);
        expect(model.hasError, true);
      });
      test(
          'When called and error is thrown should call onErrorForFuture override',
          () async {
        var model = TestViewModel();
        await model.runTestErrorFuture(fail: true, throwException: false);
        expect(model.onErrorCalled, true);
      });
    });
  });
}
