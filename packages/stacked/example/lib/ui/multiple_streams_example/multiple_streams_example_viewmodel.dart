import 'dart:math';

import 'package:stacked/stacked.dart';

const String _numbersStreamKey = 'numbers-stream';
const String _stringStreamKey = 'string-stream';

class MultipleStreamsExampleViewModel extends MultipleStreamViewModel {
  int get number => dataMap![_numbersStreamKey];
  bool get hasNumberData => dataReady(_numbersStreamKey);

  String get randomString => dataMap![_stringStreamKey];
  bool get hasRandomString => dataReady(_stringStreamKey);

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
        _numbersStreamKey: StreamData<int>(numbersStream(numbersStreamDelay)),
        _stringStreamKey: StreamData<String>(stringStream(stringStreamDelay)),
      };

  void swapStreams() {
    numbersStreamDelay -= 100;
    stringStreamDelay -= 500;
    notifySourceChanged();
  }
}
