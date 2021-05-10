import 'package:new_architecture/app/app.logger.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  HomeViewModel() {
    log.d('created');
  }

  String title = 'default';

  void initialise() {
    log.i('initialise');
    title = 'initialised';
    notifyListeners();
  }

  int counter = 0;
  void updateTitle() {
    counter++;
    title = '$counter';
    notifyListeners();
  }

  void updateData() {
    notifyListeners();
  }

  void updateTile(String value) {
    title = value;
    notifyListeners();
  }
}
