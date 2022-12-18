import 'package:stacked/stacked.dart';
import 'package:stacked_hooks_example/app/app.locator.dart';
import 'package:stacked_hooks_example/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToWithStackedHook() {
    _navigationService.navigateToWithStackedHookView();
  }

  void goToWithoutStackedHook() {
    _navigationService.navigateToWithoutStackedHookView();
  }
}
