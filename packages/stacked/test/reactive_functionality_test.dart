import 'package:flutter_test/flutter_test.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/src/reactive_service_mixin.dart';

class CounterService with ReactiveServiceMixin {
  RxValue<int> _counter = RxValue<int>(initial: 0);
  int get counter => _counter.value;

  RxList<int> _counters = RxList<int>();
  RxList get counters => _counters;

  CounterService() {
    listenToReactiveValues([
      _counter,
    ]);
  }

  void updateCounter() {
    _counter.value++;
  }

  void addCounterToList() {
    _counters.add(_counter.value);
  }
}

class ListCounterService with ReactiveServiceMixin {
  RxList<int> _counters = RxList<int>();
  RxList get counters => _counters;
  int _counter = 0;

  ListCounterService() {
    listenToReactiveValues([
      _counters,
    ]);
  }

  void addCounterToList() {
    _counters.add(_counter++);
  }
}

class SetCounterService with ReactiveServiceMixin {
  RxSet<int> _counters = RxSet<int>();
  RxSet get counters => _counters;
  int _counter = 0;

  SetCounterService() {
    listenToReactiveValues([
      _counters,
    ]);
  }

  void addCounterToSet() {
    _counters.add(_counter++);
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
