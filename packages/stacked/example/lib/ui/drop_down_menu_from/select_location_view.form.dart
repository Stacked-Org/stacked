// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CountryValueKey = 'country';
const String ProvinceValueKey = 'province';

const Map<String, String> CountryValueToTitleMap = {
  'ZAR': 'South Africa',
  'UK': 'United Kingdom',
};
const Map<String, String> ProvinceValueToTitleMap = {
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
  void listenToFormUpdated(FormViewModel model) {}

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap..addAll({}),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null
  }
}

extension ValueProperties on FormViewModel {
  String? get countryValue => this.formValueMap[CountryValueKey];
  String? get provinceValue => this.formValueMap[ProvinceValueKey];

  bool get hasCountry => this.formValueMap.containsKey(CountryValueKey);
  bool get hasProvince => this.formValueMap.containsKey(ProvinceValueKey);
}

extension Methods on FormViewModel {
  void setCountry(String country) {
    this.setData(this.formValueMap..addAll({CountryValueKey: country}));
  }

  void setProvince(String province) {
    this.setData(this.formValueMap..addAll({ProvinceValueKey: province}));
  }
}
