import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/src/mixins/listenable_service_mixin.dart';
import 'package:stacked/src/view_models/base_view_models.dart';
import 'package:stacked/src/view_models/data_models/single_data_models.dart';

class TestReactiveService with ListenableServiceMixin {
  int _counter = 0;
  int get counter => _counter;

  void updateCounter() {
    _counter++;
    notifyListeners();
  }
}

class TestReactiveViewModel extends ReactiveViewModel {
  final _testService = TestReactiveService();
  @override
  List<ListenableServiceMixin> get listenableServices => [_testService];

  void updateCounter() {
    _testService.updateCounter();
  }
}

class TestFutureReactiveViewModel extends FutureViewModel<int> {
  final _testService = TestReactiveService();
  @override
  List<ListenableServiceMixin> get listenableServices => [_testService];

  @override
  Future<int> futureToRun() async {
    await Future.delayed(const Duration(milliseconds: 5));
    return 1;
  }

  void updateCounter() {
    _testService.updateCounter();
  }
}

void main() {
  group('ReactiveViewModel Tests -', () {
    test(
        'Given a reactive service should notifyListeners when an RX value in it changes',
        () async {
      var viewModel = TestReactiveViewModel();
      var called = false;
      viewModel.addListener(() {
        called = true;
      });
      viewModel.updateCounter();
      await Future.delayed(const Duration(milliseconds: 5));
      expect(called, true);
    });
    test(
        'Given a reactive service on FutureViewmodel should notifyListeners when an RX value in it changes',
        () async {
      var viewModel = TestFutureReactiveViewModel();
      var called = false;
      viewModel.addListener(() {
        called = true;
      });
      viewModel.updateCounter();
      await Future.delayed(const Duration(milliseconds: 5));
      expect(called, true);
    });
    test('Given a reactive service should not notifyListeners after disposed',
        () async {
      var viewModel = TestReactiveViewModel();
      var called = false;
      viewModel.addListener(() {
        called = true;
      });
      viewModel.dispose();
      viewModel.updateCounter();
      await Future.delayed(const Duration(milliseconds: 5));
      expect(called, false);
    });
  });
}
