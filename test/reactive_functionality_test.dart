import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/src/mixins/listenable_service_mixin.dart';

class CounterService with ListenableServiceMixin {
  int _counter = 0;
  int get counter => _counter;

  List<int> _counters = <int>[];
  List<int> get counters => _counters;

  void updateCounter() {
    _counter++;
    notifyListeners();
  }

  void addCounterToList() {
    _counters.add(_counter);
    notifyListeners();
  }
}

class ListCounterService with ListenableServiceMixin {
  List<int> _counters = <int>[];
  List get counters => _counters;
  int _counter = 0;

  void addCounterToList() {
    _counters.add(_counter++);
    notifyListeners();
  }
}

class SetCounterService with ListenableServiceMixin {
  List<int> _counters = <int>[];
  List get counters => _counters;
  int _counter = 0;

  void addCounterToSet() {
    _counters.add(_counter++);
    notifyListeners();
  }
}

void main() {
  group('Reactive Functionality', () {
    test('When RxValue updates on reactive service, should call listeners',
        () async {
      var called = false;
      var reactiveService = CounterService();

      reactiveService.addListener(() {
        called = true;
      });

      reactiveService.updateCounter();

      // Have to wait for the listener to be called above. In real life the results is not
      // expected to happen in the same CPU cycle so this is perfect for a unit test.
      await Future.delayed(Duration(milliseconds: 10));

      expect(called, true);
    });

    test('When RxList updates on reactive service, should call listeners',
        () async {
      var called = false;
      var reactiveService = ListCounterService();

      reactiveService.addListener(() {
        called = true;
      });

      reactiveService.addCounterToList();

      // Have to wait for the listener to be called above. In real life the results is not
      // expected to happen in the same CPU cycle so this is perfect for a unit test.
      await Future.delayed(Duration(milliseconds: 10));

      expect(called, true);
    });

    test('When RxSet updates on reactive service, should call listeners',
        () async {
      var called = false;
      var reactiveService = SetCounterService();

      reactiveService.addListener(() {
        called = true;
      });

      reactiveService.addCounterToSet();

      // Have to wait for the listener to be called above. In real life the results is not
      // expected to happen in the same CPU cycle so this is perfect for a unit test.
      await Future.delayed(Duration(milliseconds: 10));

      expect(called, true);
    });

    test('When notifyListeners is called on a service would fire the listener',
        () async {
      var called = false;
      var reactiveService = ListCounterService();

      reactiveService.addListener(() {
        called = true;
      });

      reactiveService.notifyListeners();

      // Have to wait for the listener to be called above. In real life the results is not
      // expected to happen in the same CPU cycle so this is perfect for a unit test.
      await Future.delayed(Duration(milliseconds: 10));

      expect(called, true);
    });
  });
}
