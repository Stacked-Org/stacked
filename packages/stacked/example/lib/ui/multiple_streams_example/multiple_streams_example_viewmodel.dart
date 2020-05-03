import 'dart:math';
import 'package:stacked/stacked.dart';

const String _NumbersStreamKey = 'numbers-stream';
const String _StringStreamKey = 'string-stream';

class MultipleStreamsExampleViewModel extends MultipleStreamViewModel {
  int get number => dataMap[_NumbersStreamKey];
  bool get hasNumberData => dataReady(_NumbersStreamKey);

  String get randomString => dataMap[_StringStreamKey];
  bool get hasRandomString => dataReady(_StringStreamKey);

  Stream<int> numbersStream([int delay = 500]) async* {
    var random = Random();
    while (true) {
      await Future.delayed(Duration(milliseconds: delay));
      yield random.nextInt(999);
    }
  }

  Stream<String> stringStream([int delay = 2000]) async* {
    var random = Random();
    while (true) {
      await Future.delayed(Duration(milliseconds: delay));
      var randomLength = random.nextInt(50);
      var randomString = '';
      for (var i = 0; i < randomLength; i++) {
        randomString += String.fromCharCode(random.nextInt(50));
      }
      yield randomString;
    }
  }

  int numbersStreamDelay = 500;
  int stringStreamDelay = 2000;

  @override
  Map<String, StreamData> get streamsMap => {
        _NumbersStreamKey: StreamData<int>(numbersStream(numbersStreamDelay)),
        _StringStreamKey: StreamData<String>(stringStream(stringStreamDelay)),
      };

  void swapStreams() {
    numbersStreamDelay -= 100;
    stringStreamDelay -= 500;
    notifySourceChanged();
  }
}
