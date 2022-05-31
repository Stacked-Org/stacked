const ksFormImports = '''

import \'package:flutter/material.dart\';
import \'package:stacked/stacked.dart\';


''';

String ksFormKeys(String name, String date, String dropDown) => '''

const String ${name[0].toUpperCase()}${name.substring(1)}ValueKey = \'${name}\';
const String ${date[0].toUpperCase()}${date.substring(1)}ValueKey = \'${date}\';
const String ${dropDown[0].toUpperCase()}${dropDown.substring(1)}ValueKey = \'${dropDown}\';

''';

String ksDropdownItemsMap = '''

const Map<String, String> DropDownValueToTitleMap = {
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
