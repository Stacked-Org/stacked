import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/_base_viewmodels.dart';

Stream<int> numbersStream(int numberBack, {bool fail, int delay}) async* {
  if (fail) throw Exception('Stream failed');
  if (delay != null) await Future.delayed(Duration(milliseconds: delay));
  yield numberBack;
}

class TestStreamViewModel extends StreamViewModel<int> {
  final bool fail;
  final int delay;
  TestStreamViewModel({this.fail = false, this.delay = 0});

  @override
  get stream => numbersStream(1, fail: fail, delay: delay);
}

const String _SlowNumbers = 'slowNumbers';
const String _FastNumbers = 'fastNumbers';

class TestMultipleStreamViewModel extends MultipleStreamViewModel {
  final bool failOne;
  TestMultipleStreamViewModel({this.failOne = false});

  @override
  Map<String, Stream> get streamsMap => {
        _SlowNumbers: numbersStream(1000, fail: failOne),
        _FastNumbers: numbersStream(10),
      };
}

void main() async {
  group('StreamViewModel', () {
    test('When stream is complete data should be set and ready', () async {
      var streamViewModel = TestStreamViewModel();
      await streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.data, 1);
      expect(streamViewModel.dataReady, true);
    });
    test('When a stream fails it should indicate there\'s an error and no data',
        () async {
      var streamViewModel = TestStreamViewModel(fail: true);
      await streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.hasError, true);
      expect(streamViewModel.data, null,
          reason: 'No data should be set when there\'s a failure.');
      expect(streamViewModel.dataReady, false);
    });

    test('Before a stream returns it should indicate busy', () async {
      var streamViewModel = TestStreamViewModel(delay: 1000);
      await streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.isBusy, true);
    });
    test('When a stream fails it should indicate NOT busy', () async {
      var streamViewModel = TestStreamViewModel(delay: 1000, fail: true);
      await streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.isBusy, false);
    });
  });

  group('MultipleStreamViewModel', () {
    test(
        'When running multiple streams the associated key should hold the value when complete',
        () async {});

    test(
        'When one of multiple streams fail only the failing one should have an error',
        () async {});

    test(
        'When one of multiple streams fail the passed one should have data and failing one not',
        () async {});

    test('When multiple streams run the key should be set to indicate busy',
        () async {});

    test(
        'When multiple streams are complete the key should be set to indicate NOT busy',
        () async {});

    test('When a stream fails busy should be set to false', () async {});
  });
}
