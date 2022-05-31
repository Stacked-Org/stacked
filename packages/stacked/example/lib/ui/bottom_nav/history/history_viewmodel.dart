import 'package:stacked/stacked.dart';

class HistoryViewModel extends FutureViewModel<int> {
  @override
  Future<int> futureToRun() async {
    await Future.delayed(const Duration(seconds: 2));
    return 100;
  }
}
