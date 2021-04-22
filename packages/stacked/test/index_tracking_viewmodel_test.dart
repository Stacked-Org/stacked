import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/src/state_management/index_tracking_viewmodel.dart';

void main() {
  group('IndexTrackingViewmodelTest -', () {
    group('setIndex -', () {
      test('When called with 1, should set currentIndex to 1', () {
        var viewModel = IndexTrackingViewModel();
        viewModel.setIndex(1);
        expect(viewModel.currentIndex, 1);
      });

      test('When called with 1, should notifyListeners about update', () {
        var viewModel = IndexTrackingViewModel();
        var called = false;
        viewModel.addListener(() {
          called = true;
        });
        viewModel.setIndex(1);
        expect(called, true);
      });

      test(
          'When called with 1 and currentIndex was 0, reverse should return false',
          () {
        var viewModel = IndexTrackingViewModel();
        viewModel.setIndex(1);
        expect(viewModel.reverse, false);
      });

      test(
          'When called with 0 and currentIndex was 1, reverse should return true',
          () {
        var viewModel = IndexTrackingViewModel();
        viewModel.setIndex(1);

        viewModel.setIndex(0);
        expect(viewModel.reverse, true);
      });

      test('When called with 1 isIndexSelected should return false for 0', () {
        var model = IndexTrackingViewModel();
        model.setIndex(1);
        expect(model.isIndexSelected(0), false);
      });

      test('When called with 1 isIndexSelected should return true for 1', () {
        var viewModel = IndexTrackingViewModel();
        viewModel.setIndex(1);
        expect(viewModel.isIndexSelected(1), true);
      });
    });
  });
}
