import 'package:stacked/stacked.dart';

abstract class BaseFormViewModel extends BaseViewModel {
  bool _showValidation = false;
  bool get showValidation => _showValidation;

  String _validationMessage;
  String get validationMessage => _validationMessage;

  /// Stores the mapping of the form key to the value entered by the user
  Map<String, dynamic> formValueMap = Map<String, dynamic>();

  void setValidationMessage(String value) {
    _validationMessage = value;
    _showValidation = _validationMessage?.isNotEmpty ?? false;
  }

  void setData(Map<String, String> data) {
    // Save the data from the controllers
    formValueMap = data;

    // Reset the form status
    setValidationMessage(null);

    // Set the new form status
    setFormStatus();

    // Rebuild the UI
    notifyListeners();
  }

  /// Called after the [formValueMap] has been updated and allows you to set
  /// values relating to the forms status.
  void setFormStatus();
}
