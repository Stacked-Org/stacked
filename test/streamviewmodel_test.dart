import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/_base_viewmodels.dart';

Stream<int> numberStream(int dataBack, {bool fail, int delay}) async* {
  if (fail) throw Exception('numberStream failed');
  if (delay != null) await Future.delayed(Duration(milliseconds: delay));
  yield dataBack;
}

Stream<String> textStream(String dataBack, {bool fail, int delay}) async* {
  if (fail) throw Exception('textStream failed');
  if (delay != null) await Future.delayed(Duration(milliseconds: delay));
  yield dataBack;
}

class TestStreamViewModel extends StreamViewModel<int> {
  final bool fail;
  final int delay;
  TestStreamViewModel({this.fail = false, this.delay = 0});

  @override
  get stream => numberStream(1, fail: fail, delay: delay);
}

const String _NumberStream = 'numberStream';
const String _StringStream = 'stringStream';

class TestMultipleStreamViewModel extends MultipleStreamViewModel {
  final bool failOne;
  final int delay;
  TestMultipleStreamViewModel({this.failOne = false, this.delay = 0});

  @override
  Map<String, Stream> get streamsMap => {
        _NumberStream: numberStream(5, fail: failOne, delay: delay),
        _StringStream: textStream("five", fail: false, delay: delay),
      };
}

void main() async {
  group('StreamViewModel', () {
    test('When stream data is fetched data should be set and ready', () async {
      var streamViewModel = TestStreamViewModel();
      streamViewModel.initialise();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.data, 1);
      expect(streamViewModel.dataReady, true);
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
  });

  group('MultipleStreamViewModel', () {
    test(
        'When running multiple streams the associated key should hold the value when data is fetched',
        () async {
      //TODO: implement this on 'dataMap' property (getter)

      var streamViewModel = TestMultipleStreamViewModel();
      streamViewModel.runStreams();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.dataMap[_NumberStream], 5);
      expect(streamViewModel.dataMap[_StringStream], 'five');
    });

    test(
        'When one of multiple streams fail only the failing one should have an error',
        () async {
      var streamViewModel = TestMultipleStreamViewModel(failOne: true);
      streamViewModel.runStreams();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.errorMap[_NumberStream], true);
      expect(streamViewModel.errorMap[_StringStream], false);
    });

    test(
        'When one of multiple streams fail the passed one should have data and failing one not',
        () async {
      var streamViewModel = TestMultipleStreamViewModel(failOne: true);
      streamViewModel.runStreams();
      await Future.delayed(Duration(milliseconds: 1));
      expect(streamViewModel.streamDataMap[_NumberStream].dataReady, false);
      expect(streamViewModel.streamDataMap[_StringStream].dataReady, true);
    });
  });
}
