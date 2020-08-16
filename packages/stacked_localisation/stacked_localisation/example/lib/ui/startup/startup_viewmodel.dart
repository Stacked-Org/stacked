import 'package:example/core/router.gr.dart';
import 'package:example/core/setup_locator.dart';
// import 'package:example/core/setup_locator.dart';
// import 'package:example/services/localisation_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_localisation/stacked_localisation.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _localisationService = locator<LocalisationService>();
  final _navigationService = locator<NavigationService>();

  Future initialise() async {
    await _localisationService.initialise();
    _navigationService.replaceWith(Routes.homeView);
  }
}
