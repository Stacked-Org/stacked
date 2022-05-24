import 'package:new_architecture/app/app.locator.dart';
import 'package:new_architecture/app/app.logger.dart';
import 'package:new_architecture/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import 'example_form_view.form.dart';

// #5: extend from FormViewModel
class ExampleFormViewModel extends FormViewModel {
  final log = getLogger('FormViewModel');
  final _navigationService = exampleLocator<NavigationService>();

  @override
  void setFormStatus() {
    log.i('Set form Status with data: $formValueMap');

    // Set a validation message for the entire form
    if (hasPasswordValidationMessage) {
      setValidationMessage('Error in the form, please check again');
    }
  }

  // If the dev doesn't want realtime validation then they can
  // simply validate in the function that they'll use to submit the
  // data to the backend or db.

  Future? saveData() {
    return null;

    // here we can run custom functionality to save to our api
  }

  Future? navigateSomewhere() =>
      _navigationService.navigateTo(Routes.streamCounterView);
}
