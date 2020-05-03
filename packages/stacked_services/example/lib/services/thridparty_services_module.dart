import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@registerModule
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigateionService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackbarService;
}
