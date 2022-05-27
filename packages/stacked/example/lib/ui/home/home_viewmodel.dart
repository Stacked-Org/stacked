import 'package:new_architecture/app/app.locator.dart';
import 'package:new_architecture/app/app.logger.dart';
import 'package:new_architecture/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  final NavigationService _navigationService =
      exampleLocator<NavigationService>();

  HomeViewModel() {
    log.d('created');
  }

  String title = 'default';

  void navigate() {
    _navigationService.navigateTo(
      Routes.nonReactiveView,
      // transition: TransitionsBuilders.fadeIn,
      // transition: ((context, animation, secondaryAnimation, child) =>
      //     SharedAxisTransition(
      //       animation: animation,
      //       secondaryAnimation: secondaryAnimation,
      //       transitionType: SharedAxisTransitionType.scaled,
      //       child: child,
      //     )),
    );
  }

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
