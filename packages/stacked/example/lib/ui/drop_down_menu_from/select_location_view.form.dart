// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CountryValueKey = 'country';
const String ProvinceValueKey = 'province';

final Map<String, String> CountryValueToTitleMap = {
  'ZAR': 'South Africa',
  'UK': 'United Kingdom',
};
final Map<String, String> ProvinceValueToTitleMap = {
  'Western Cape': 'Western Cape',
  'Easter Cape': 'Easter Cape',
  'Free State': 'Free State',
  'Gauteng': 'Gauteng',
  'KwaZulu-Natal': 'KwaZulu-Natal',
  'Limpopo': 'Limpopo',
  'Mpumalanga': 'Mpumalanga',
  'Northern Cape': 'Northern Cape',
  'North West': 'North West',
};

mixin $SelectLocationView on StatelessWidget {
  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {}

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {}

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get countryValue => this.formValueMap[CountryValueKey] as String?;
  String? get provinceValue => this.formValueMap[ProvinceValueKey] as String?;

  bool get hasCountry => this.formValueMap.containsKey(CountryValueKey);
  bool get hasProvince => this.formValueMap.containsKey(ProvinceValueKey);

  bool get hasCountryValidationMessage =>
      this.fieldsValidationMessages[CountryValueKey]?.isNotEmpty ?? false;
  bool get hasProvinceValidationMessage =>
      this.fieldsValidationMessages[ProvinceValueKey]?.isNotEmpty ?? false;

  String? get countryValidationMessage =>
      this.fieldsValidationMessages[CountryValueKey];
  String? get provinceValidationMessage =>
      this.fieldsValidationMessages[ProvinceValueKey];
}

extension Methods on FormViewModel {
  void setCountry(String country) {
    this.setData(this.formValueMap..addAll({CountryValueKey: country}));
  }

  void setProvince(String province) {
    this.setData(this.formValueMap..addAll({ProvinceValueKey: province}));
  }

  setCountryValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CountryValueKey] = validationMessage;
  setProvinceValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ProvinceValueKey] = validationMessage;
}
