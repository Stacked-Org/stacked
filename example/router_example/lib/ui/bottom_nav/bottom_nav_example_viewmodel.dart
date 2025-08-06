import 'package:example/app/app.locator.dart';
import 'package:example/app/app.logger.dart';
import 'package:example/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavExampleViewModel extends IndexTrackingViewModel {
  final log = getLogger('BottomNavExampleViewModel');
  final _routerService = exampleLocator<RouterService>();

  BottomNavExampleViewModel() {
    setCurrentWebPageIndex(_routerService);
  }

  void handleNavigation(int index) {
    log.i('handleNavigation: $index');
    setIndex(index);
    switch (index) {
      case 0:
        _routerService.navigateTo(FavoritesViewRoute());
        break;
      case 1:
        _routerService.navigateTo(HistoryViewRoute());
        break;
      case 2:
        _routerService.navigateTo(ProfileViewRoute());
        break;
      default:
    }
  }
}
