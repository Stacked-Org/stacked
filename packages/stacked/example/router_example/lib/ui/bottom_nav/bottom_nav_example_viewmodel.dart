import 'package:example/app/app.locator.dart';
import 'package:example/app/app.logger.dart';
import 'package:example/app/app.router.dart';
import 'package:example/ui/bottom_nav/favorites/favorites_view.dart';
import 'package:example/ui/bottom_nav/history/history_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavExampleViewModel extends IndexTrackingViewModel {
  final log = getLogger('BottomNavExampleViewModel');
  final _routerService = exampleLocator<RouterService>();

  void handleNavigation(int index) {
    log.i('handleNavigation: $index');
    setIndex(index);
    switch (index) {
      case 0:
        _routerService.navigateWithTransition(
          const FavoritesView(),
          transitionBuilder: reverse
              ? TransitionsBuilders.slideLeft
              : TransitionsBuilders.slideRight,
        );
        break;
      case 1:
        _routerService.clearStackAndShowView(
          const HistoryView(),
        );
        break;
      case 2:
        _routerService.clearStackAndShow(
          const ProfileViewRoute(),
        );
        break;
      default:
    }
  }
}
