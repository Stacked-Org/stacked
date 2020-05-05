import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class TestViewModel extends BaseViewModel {}

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
    });
  });
}
