const ksFormImports = '''

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';


''';

String ksFormKeys(String name, String date, String dropDown) => '''

const String ${name[0].toUpperCase()}${name.substring(1)}ValueKey = '$name';
const String ${date[0].toUpperCase()}${date.substring(1)}ValueKey = '$date';
const String ${dropDown[0].toUpperCase()}${dropDown.substring(1)}ValueKey = '$dropDown';

''';

String ksDropdownItemsMap = '''

final Map<String, String> DropDownValueToTitleMap = {
'1': 'one',
'2': 'two',
};

''';

String ksTextEditingControllerItemsMap = '''

final Map<String, TextEditingController> _TestTextEditingControllers = {};

''';

String ksTextEditingControllerGettersForTextFields = '''
TextEditingController get firstNameController => _getFormTextEditingController(FirstNameValueKey);
TextEditingController get lastNameController => _getFormTextEditingController(LastNameValueKey);
''';
const kExample1DisposeTextControllers = '''

      /// Calls dispose on all the generated controllers and focus nodes
      void disposeForm() {
        // The dispose function for a TextEditingController sets all listeners to null
          
      for (var controller in _TestViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _TestViewFocusNodes.values) {
      focusNode.dispose();
    }
    
_TestViewTextEditingControllers.clear();
_TestViewFocusNodes.clear();
}
''';
const kExample1DropDownItemsMap = '''

final Map<String, String> DropDownValueToTitleMap = {
'value1': 'title1',
'value2': 'title2',
};

''';
const kExample1FocusNodesMap = '''

final Map<String, FocusNode> _TestViewFocusNodes = {};

''';
const kExample1UpdateFormData = '''
        /// Updates the formData on the FormViewModel
        void _updateFormData(FormViewModel model, {bool forceValidate = false}) { model.setData(
              model.formValueMap
                ..addAll({
            
NameValueKey: nameController.text,
EmailValueKey: emailController.text,
              }),
          );
    if (_autoTextFieldValidation || forceValidate) {
          _updateValidationData(model);}}
              
''';
const kExample1ViewModelExtensionForGetters = '''

extension ValueProperties on FormViewModel {
bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
String? get nameValue => this.formValueMap[NameValueKey] as String?;
String? get emailValue => this.formValueMap[EmailValueKey] as String?;
DateTime? get dateValue => this.formValueMap[DateValueKey] as DateTime?;
String? get dropDownValue => this.formValueMap[DropDownValueKey] as String?;

bool get hasName => this.formValueMap.containsKey(NameValueKey) && (nameValue?.isNotEmpty ?? false);
bool get hasEmail => this.formValueMap.containsKey(EmailValueKey) && (emailValue?.isNotEmpty ?? false);
bool get hasDate => this.formValueMap.containsKey(DateValueKey);
bool get hasDropDown => this.formValueMap.containsKey(DropDownValueKey);

bool get hasNameValidationMessage => this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
bool get hasEmailValidationMessage => this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
bool get hasDateValidationMessage => this.fieldsValidationMessages[DateValueKey]?.isNotEmpty ?? false;
bool get hasDropDownValidationMessage => this.fieldsValidationMessages[DropDownValueKey]?.isNotEmpty ?? false;

String? get nameValidationMessage => this.fieldsValidationMessages[NameValueKey];
String? get emailValidationMessage => this.fieldsValidationMessages[EmailValueKey];
String? get dateValidationMessage => this.fieldsValidationMessages[DateValueKey];
String? get dropDownValidationMessage => this.fieldsValidationMessages[DropDownValueKey];
}
''';
const kExample1ViewModelExtensionForMethods = '''

extension Methods on FormViewModel {
          Future<void> selectDate(
              {required BuildContext context,
              required DateTime initialDate,
              required DateTime firstDate,
              required DateTime lastDate}) async {
            final selectedDate = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: firstDate,
                lastDate: lastDate);
            if (selectedDate != null) {
              this.setData(
                  this.formValueMap..addAll({DateValueKey: selectedDate}));
            }
          }
    

          void setDropDown(String dropDown) {
            this.setData(this.formValueMap..addAll({DropDownValueKey: dropDown}));
          }
    


setNameValidationMessage(String? validationMessage) => this.fieldsValidationMessages[NameValueKey] = validationMessage;
setEmailValidationMessage(String? validationMessage) => this.fieldsValidationMessages[EmailValueKey] = validationMessage;
setDateValidationMessage(String? validationMessage) => this.fieldsValidationMessages[DateValueKey] = validationMessage;
setDropDownValidationMessage(String? validationMessage) => this.fieldsValidationMessages[DropDownValueKey] = validationMessage;
}
''';
const kExample1AddRegisterationCustomTextEditingController = '''

      null _getCustomFormTextEditingController(String key,) {
          if (_TestViewTextEditingControllers.containsKey(key)) {
        return _TestViewTextEditingControllers[key]! as null;
      }
      _TestViewTextEditingControllers[key] =
         emailController();
      return _TestViewTextEditingControllers[key]! 
      as null; }
    

''';
const kExample1AddRegisterationForFocusNodes = '''
      FocusNode _getFormFocusNode(String key) {
        if (_TestViewFocusNodes.containsKey(key)) {
        return _TestViewFocusNodes[key]!;}
        _TestViewFocusNodes[key] = FocusNode();
      return _TestViewFocusNodes[key]!;
      }
    

''';
const kExample1AddRegisterationextEditingController = '''

      TextEditingController _getFormTextEditingController(String key,
        {String? initialValue}) {
          if (_TestViewTextEditingControllers.containsKey(key)) {
        return _TestViewTextEditingControllers[key]!;
      }
      _TestViewTextEditingControllers[key] =
          TextEditingController(text: initialValue);
      return _TestViewTextEditingControllers[key]!; }
    

''';
const kExample1AddValidationMessageForTextEditingController = '''
        /// Returns the validation message for the given key
        String? _getValidationMessage(String key) {
      final validatorForKey = _TestViewTextValidations[key];
      if (validatorForKey == null) return null;
      String? validationMessageForKey =
            validatorForKey(_TestViewTextEditingControllers[key]!.text);
      return validationMessageForKey;
      }
    
''';
const kExample1AddHeaderComment = '''
// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this
''';
const kExample1AddImports = '''

import 'controllers/path';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'validators/path';


''';
const kExample1AddListenerRegistrationsForTextFields =
    '''              /// Registers a listener on every generated controller that calls [model.setData()]
              /// with the latest textController values
              void listenToFormUpdated(FormViewModel model) {
            
nameController.addListener(() => _updateFormData(model));
emailController.addListener(() => _updateFormData(model));
}

''';
const kExample1AddValidationDataUpdateFunctionTorTextControllers = '''
        /// Updates the fieldsValidationMessages on the FormViewModel
        void _updateValidationData(FormViewModel model) => model.setValidationMessages(
              {
            
NameValueKey: _getValidationMessage(NameValueKey),
EmailValueKey: _getValidationMessage(EmailValueKey),
              }
          );
              
''';
const kExample1AddMixinSignature = '''
mixin \$TestView on StatelessWidget {
''';
const kExample1AddValidationFunctionsFromAnnotation = '''

final Map<String, String? Function(String?)?> _TestViewTextValidations = {
NameValueKey: nameValidator,
EmailValueKey: null,
};

''';
const kExample1AddFocusNodesGetters = '''
FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
''';
