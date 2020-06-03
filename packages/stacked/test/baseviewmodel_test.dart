import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class TestViewModel extends BaseViewModel {
  Future runFuture(
      {String busyKey, bool fail = false, bool throwException = false}) {
    return runBusyFuture(_futureToRun(fail),
        busyObject: busyKey, throwException: throwException);
  }

  Future _futureToRun(bool fail) async {
    await Future.delayed(Duration(milliseconds: 50));
    if (fail) {
      throw Exception('Broken Future');
    }
  }
}

void main() {
  group('BaseViewModel Tests', () {
    group('Busy functionality', () {
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
    });
  });
}
