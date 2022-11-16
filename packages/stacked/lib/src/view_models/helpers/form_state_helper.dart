import 'package:flutter/material.dart';

/// Provides functionality to reduce the code required in order to move user input
/// into the [ViewModel]
mixin FormStateHelper on ChangeNotifier {
  bool _showValidationMessage = false;
  bool get showValidationMessage => _showValidationMessage;

  String? _validationMessage;
  String? get validationMessage => _validationMessage;

  /// Stores the mapping of the form key to the value entered by the user
  Map<String, dynamic> formValueMap = Map<String, dynamic>();
  Map<String, String?> fieldsValidationMessages = Map<String, String?>();

  void setValidationMessage(String? value) {
    _validationMessage = value;
    _showValidationMessage = _validationMessage?.isNotEmpty ?? false;
  }

  void setData(Map<String, dynamic> data) {
    // Save the data from the controllers
    formValueMap = data;

    // Reset the form status
    setValidationMessage(null);

    // Reset each field status
    for (var fieldName in data.keys) {
      fieldsValidationMessages.remove(fieldName);
    }

    // Set the new form status
    setFormStatus();

    // Rebuild the UI
    notifyListeners();
  }

  void setValidationMessages(Map<String, String?> validationMessages) {
    fieldsValidationMessages = validationMessages;
    fieldsValidationMessages.removeWhere((key, value) => value == null);
    setFormStatus();
    notifyListeners();
  }

  /// Called after the [formValueMap] has been updated and allows you to set
  /// values relating to the forms status.
  void setFormStatus();
}
