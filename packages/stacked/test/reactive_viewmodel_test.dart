import 'package:flutter_test/flutter_test.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/src/state_management/base_view_models.dart';
import 'package:stacked/src/state_management/reactive_service_mixin.dart';

class TestReactiveService with ReactiveServiceMixin {
  RxValue<int> _counter = RxValue(initial: 0);
  int get counter => _counter.value;

  TestReactiveService() {
    listenToReactiveValues([_counter]);
  }

  void updateCounter() {
    _counter.value++;
  }
}

class TestReactiveViewModel extends ReactiveViewModel {
  final _testService = TestReactiveService();
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_testService];

  void updateCounter() {
    _testService.updateCounter();
  }
}

class TestFutureReactiveViewModel extends FutureViewModel<int> {
  final _testService = TestReactiveService();
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_testService];

  @override
  Future<int> futureToRun() async {
    await Future.delayed(Duration(milliseconds: 5));
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
      var model = TestReactiveViewModel();
      var called = false;
      model.addListener(() {
        called = true;
      });
      model.updateCounter();
      await Future.delayed(Duration(milliseconds: 5));
      expect(called, true);
    });
    test(
        'Given a reactive service on FutureViewmodel should notifyListeners when an RX value in it changes',
        () async {
      var model = TestFutureReactiveViewModel();
      var called = false;
      model.addListener(() {
        called = true;
      });
      model.updateCounter();
      await Future.delayed(Duration(milliseconds: 5));
      expect(called, true);
    });
    test('Given a reactive service should not notifyListeners after disposed',
        () async {
      var model = TestReactiveViewModel();
      var called = false;
      model.addListener(() {
        called = true;
      });
      model.dispose();
      model.updateCounter();
      await Future.delayed(Duration(milliseconds: 5));
      expect(called, false);
    });
  });
}
