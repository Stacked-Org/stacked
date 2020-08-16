import 'package:example/core/setup_locator.dart';
import 'package:example/localisation_string_keys.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_localisation/stacked_localisation.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel with LocalisedClass {
  final _dialogService = locator<DialogService>();

  Future handleDialog() async {
    await _dialogService.showDialog(
      title: translate(HomeViewStrings.dialogTitle),
      description: translate(HomeViewStrings.dialogDescription),
    );
  }
}
