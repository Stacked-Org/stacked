import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/src/state_management/multiple_data_models.dart';
import 'package:stacked/src/state_management/single_data_models.dart';
import 'package:stacked/stacked.dart';

Stream<int> numberStream(int dataBack,
    {required bool fail, int? delay}) async* {
  if (fail) throw Exception('numberStream failed');
  if (delay != null) await Future.delayed(Duration(milliseconds: delay));
  yield dataBack;
}

Stream<String> textStream(String dataBack,
    {required bool fail, int? delay}) async* {
  if (fail) throw Exception('textStream failed');
  if (delay != null) await Future.delayed(Duration(milliseconds: delay));
  yield dataBack;
}

class TestStreamViewModel extends StreamViewModel<int> {
  final bool fail;
  final int delay;
  TestStreamViewModel({this.fail = false, this.delay = 0});
  int? loadedData;
  void setErrorManually() {
    setError('my error');
  }

  @override
  get stream => numberStream(1, fail: fail, delay: delay);

  @override
  void onData(int? data) {
    if (data != null) loadedData = data;
  }
}

const String _NumberStream = 'numberStream';
const String _StringStream = 'stringStream';

class TestMultipleStreamViewModel extends MultipleStreamViewModel {
  final bool failOne;
  final int delay;
  TestMultipleStreamViewModel({this.failOne = false, this.delay = 0});
  int? loadedData;
  int cancelledCalls = 0;
  int getStreamsMapCalls = 0;
  @override
  Map<String, StreamData> get streamsMap {
    getStreamsMapCalls++;
    return {
      _NumberStream: StreamData(numberStream(
        5,
        fail: failOne,
        delay: delay,
      )),
      _StringStream: StreamData(textStream(
        "five",
        fail: false,
        delay: delay,
      )),
    };
  }

  @override
  void onCancel(String key) {
    cancelledCalls++;
  }
}

class TestMultipleStreamViewModelWithOverrides extends MultipleStreamViewModel {
  TestMultipleStreamViewModelWithOverrides();
  int? loadedData;
  @override
  Map<String, StreamData> get streamsMap => {
        _NumberStream: StreamData(
          numberStream(5, fail: false, delay: 0),
          onData: _loadData,
        )
      };

  void _loadData(data) {
    loadedData = data;
  }
}

void main() async {
  group('StreamViewModel', () {
    test('When stream data is fetched data should be set and ready', () async {
      var streamViewModel = TestStreamViewModel();
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 5));
      expect(streamViewModel.data, 1);
      expect(streamViewModel.dataReady, true);
    });
    test('When stream lifecycle events are overriden they recieve correct data',
        () async {
      var streamViewModel = TestStreamViewModel();
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.loadedData, 1);
    });
    test('When error is manually set, hasError should be true', () async {
      var streamViewModel = TestStreamViewModel();
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      streamViewModel.setErrorManually();
      expect(streamViewModel.hasError, isTrue);
    });
    test('When a stream fails it should indicate there\'s an error and no data',
        () async {
      var streamViewModel = TestStreamViewModel(fail: true);
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.hasError, true);
      expect(streamViewModel.data, null,
          reason: 'No data should be set when there\'s a failure.');
      expect(streamViewModel.dataReady, false);
    });

    test('Before a stream returns it should indicate not ready', () async {
      var streamViewModel = TestStreamViewModel(delay: 1000);
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.dataReady, false);
    });

    test('When a stream returns it should notifyListeners', () async {
      var streamViewModel = TestStreamViewModel(delay: 50);
      var listenersCalled = false;
      streamViewModel.addListener(() {
        listenersCalled = true;
      });
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 100));
      expect(listenersCalled, true);
    });

    group('Data Source Change', () {
      test(
          'notifySourceChanged - When called should unsubscribe from original source',
          () {
        var streamViewModel = TestStreamViewModel(delay: 1000);
        streamViewModel.initialise();
        streamViewModel.notifySourceChanged();

        expect(streamViewModel.streamSubscription, null);
      });

      test(
        'notifySourceChanged - When called and clearOldData is false should leave old data',
        () async {
          var streamViewModel = TestStreamViewModel(delay: 10);
          streamViewModel.initialise();

          await Future.delayed(const Duration(milliseconds: 30));
          streamViewModel.notifySourceChanged();

          expect(streamViewModel.data, 1);
        },
      );

      test(
          'notifySourceChanged - When called and clearOldData is true should remove old data',
          () async {
        var streamViewModel = TestStreamViewModel(delay: 10);
        streamViewModel.initialise();

        await Future.delayed(const Duration(milliseconds: 20));
        streamViewModel.notifySourceChanged(clearOldData: true);

        expect(streamViewModel.data, null);
      });
    });
  });

  group('MultipleStreamViewModel', () {
    test(
        'When running multiple streams the associated key should hold the value when data is fetched',
        () async {
      var streamViewModel = TestMultipleStreamViewModel();
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 4));
      expect(streamViewModel.dataMap![_NumberStream], 5);
      expect(streamViewModel.dataMap![_StringStream], 'five');
    });

    test(
        'When one of multiple streams fail only the failing one should have an error',
        () async {
      var streamViewModel = TestMultipleStreamViewModel(failOne: true);
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.hasErrorForKey(_NumberStream), true);
      // Make sure we only have 1 error
      // expect(streamViewModel.errorMap.values.where((v) => v == true).length, 1);
    });

    test(
        'When one of multiple streams fail the passed one should have data and failing one not',
        () async {
      var streamViewModel = TestMultipleStreamViewModel(failOne: true);
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.dataReady(_NumberStream), false);
      // Delay the first lifecycle can complete
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.dataReady(_StringStream), true);
    });

    test('When one onData is augmented the data will change', () async {
      var streamViewModel = TestMultipleStreamViewModelWithOverrides();
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.loadedData, 5);
    });

    test('When a stream returns it should notifyListeners', () async {
      var streamViewModel = TestMultipleStreamViewModel(delay: 50);
      var listenersCalled = false;
      streamViewModel.addListener(() {
        listenersCalled = true;
      });
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 100));
      expect(listenersCalled, true);
    });

    test(
        'When a stream is initialised, should only call streamsMap property once',
        () async {
      var streamViewModel = TestMultipleStreamViewModel(delay: 50);
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 300));
      expect(streamViewModel.getStreamsMapCalls, 1);
    });

    test(
        'When a stream is initialised should have a subscription for the given key',
        () async {
      var streamViewModel = TestMultipleStreamViewModel();

      streamViewModel.initialise();
      expect(
          streamViewModel.getSubscriptionForKey(_NumberStream) != null, true);
    });

    test('When disposed, should call onCancel for both streams', () async {
      var streamViewModel = TestMultipleStreamViewModel();

      streamViewModel.initialise();
      streamViewModel.dispose();
      expect(streamViewModel.cancelledCalls, 2);
    });
  });

  group('Data Source Change', () {
    test(
        'notifySourceChanged - When called should unsubscribe from original sources',
        () {
      var streamViewModel = TestMultipleStreamViewModel(delay: 50);
      streamViewModel.initialise();
      streamViewModel.notifySourceChanged();

      expect(streamViewModel.streamsSubscriptions!.length, 0);
    });

    test(
        'notifySourceChanged - When called and clearOldData is false should leave old data',
        () async {
      var streamViewModel = TestMultipleStreamViewModel(delay: 10);
      streamViewModel.initialise();

      await Future.delayed(const Duration(milliseconds: 20));
      streamViewModel.notifySourceChanged();

      expect(streamViewModel.dataMap![_NumberStream], 5);
    });

    test(
        'notifySourceChanged - When called and clearOldData is true should remove old data',
        () async {
      var streamViewModel = TestMultipleStreamViewModel(delay: 10);
      streamViewModel.initialise();

      await Future.delayed(const Duration(milliseconds: 20));
      streamViewModel.notifySourceChanged(clearOldData: true);

      expect(streamViewModel.dataMap![_NumberStream], null);
    });
  });
}
