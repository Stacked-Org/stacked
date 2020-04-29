import 'dart:math';
import 'package:stacked/stacked.dart';

const String _NumbersStreamKey = 'numbers-stream';
const String _StringStreamKey = 'string-stream';

class MultipleStreamsExampleViewModel extends MultipleStreamViewModel {
  int get number => dataMap[_NumbersStreamKey];
  bool get hasNumberData => dataReady(_NumbersStreamKey);

  String get randomString => dataMap[_StringStreamKey];
  bool get hasRandomString => dataReady(_StringStreamKey);

  Stream<int> numbersStream() async* {
    var random = Random();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      yield random.nextInt(999);
    }
  }

  Stream<String> stringStream() async* {
    var random = Random();
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      var randomLength = random.nextInt(50);
      var randomString = '';
      for (var i = 0; i < randomLength; i++) {
        randomString += String.fromCharCode(random.nextInt(50));
      }
      yield randomString;
    }
  }

  @override
  // TODO: implement streamsMap
  Map<String, StreamData> get streamsMap => {
        _NumbersStreamKey: StreamData<int>(numbersStream()),
        _StringStreamKey: StreamData<String>(stringStream()),
      };
}
