import 'package:new_architecture/app/app.logger.dart';
import 'package:new_architecture/ui/form/base_form_viewmodel.dart';
import 'package:new_architecture/ui/form/form_view.dart';
import 'package:stacked/stacked.dart';

class FormViewModel extends BaseFormViewModel {
  final log = getLogger('FormViewModel');

  // REFACTOR: I don't want to have to write this every single time. Especially
  // since it's the same for every key. And you'll need one if you want to check for the keys.
  String get _password => formValueMap[PasswordValueKey];

  @override
  void setFormStatus() {
    log.i('Set form Status with data: $formValueMap');
    if (_password?.isEmpty ?? true) {
      setValidationMessage('You need to give a password');
    }
  }

  // If the dev doesn't want realtime validation then they can
  // simply validate in the function that they'll use to submit the
  // data to the backend or db.

  Future saveData() {
    // here we can run custom functionality to save to our api
  }
}
