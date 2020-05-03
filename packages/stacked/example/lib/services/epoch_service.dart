import 'package:injectable/injectable.dart';

@lazySingleton
class EpochService {
  Stream<int> epochUpdatesNumbers() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      yield DateTime.now().millisecondsSinceEpoch;
    }
  }

  Stream<int> epochUpdateNumbersQuickly() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 200));
      yield DateTime.now().millisecondsSinceEpoch;
    }
  }
}
