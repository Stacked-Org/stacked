import 'package:example/app/app.locator.dart';
import 'package:example/app/app.logger.dart';
import 'package:example/app/app.router.dart';
import 'package:example/ui/bottom_nav/favorites/favorites_view.dart';
import 'package:example/ui/bottom_nav/history/history_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavExampleViewModel extends IndexTrackingViewModel {
  final log = getLogger('BottomNavExampleViewModel');
  final _navigationService = exampleLocator<NavigationService>();

  void handleNavigation(int index) {
    log.i('handleNavigation: $index');
    setIndex(index);
    switch (index) {
      case 0:
        _navigationService.replaceWithTransition(
          const FavoritesView(),
          transitionStyle:
              reverse ? Transition.rightToLeft : Transition.leftToRight,
          id: 1,
        );
        break;
      case 1:
        _navigationService.clearStackAndShowView(
          const HistoryView(),
          id: 1,
        );
        break;
      case 2:
        _navigationService.pushNamedAndRemoveUntil(
          BottomNavExampleRoutes.profileView,
          predicate: (route) => route.isFirst,
          id: 1,
        );
        break;
      default:
    }
  }
}
