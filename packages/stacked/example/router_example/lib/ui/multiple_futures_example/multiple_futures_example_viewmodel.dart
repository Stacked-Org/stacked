import 'package:stacked/stacked.dart';

const String _numberDelayFuture = 'delayedNumber';
const String _stringDelayFuture = 'delayedString';

class MultipleFuturesExampleViewModel extends MultipleFutureViewModel {
  int get fetchedNumber => dataMap![_numberDelayFuture];
  String get fetchedString => dataMap![_stringDelayFuture];

  bool get fetchingNumber => busy(_numberDelayFuture);
  bool get fetchingString => busy(_stringDelayFuture);

  @override
  Map<String, Future Function()> get futuresMap => {
        _numberDelayFuture: getNumberAfterDelay,
        _stringDelayFuture: getStringAfterDelay,
      };

  Future<int> getNumberAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    return 3;
  }

  Future<String> getStringAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'String data';
  }
}
