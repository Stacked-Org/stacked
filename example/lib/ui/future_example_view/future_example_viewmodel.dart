import 'package:stacked/stacked.dart';

class FutureExampleViewModel extends FutureViewModel<String> {
  @override
  Future<String> get future => getDataFromServer();

  Future<String> getDataFromServer() async {
    await Future.delayed(const Duration(seconds: 3));
    // throw Exception('This is an error'); // Uncomment to trigger error UI
    return 'This is fetched from everywhere';
  }

  @override
  void onError(error) {}
}
