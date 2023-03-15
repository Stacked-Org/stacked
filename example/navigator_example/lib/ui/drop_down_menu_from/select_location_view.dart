import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'select_location_view.form.dart';
import 'select_location_viewmodel.dart';

@FormView(fields: [
  FormDropdownField(name: 'country', items: [
    StaticDropdownItem(
      title: 'South Africa',
      value: 'ZAR',
    ),
    StaticDropdownItem(
      title: 'United Kingdom',
      value: 'UK',
    ),
  ]),
  FormDropdownField(name: 'province', items: [
    StaticDropdownItem(
      title: 'Western Cape',
      value: 'Western Cape',
    ),
    StaticDropdownItem(
      title: 'Easter Cape',
      value: 'Easter Cape',
    ),
    StaticDropdownItem(
      title: 'Free State',
      value: 'Free State',
    ),
    StaticDropdownItem(
      title: 'Gauteng',
      value: 'Gauteng',
    ),
    StaticDropdownItem(
      title: 'KwaZulu-Natal',
      value: 'KwaZulu-Natal',
    ),
    StaticDropdownItem(
      title: 'Limpopo',
      value: 'Limpopo',
    ),
    StaticDropdownItem(
      title: 'Mpumalanga',
      value: 'Mpumalanga',
    ),
    StaticDropdownItem(
      title: 'Northern Cape',
      value: 'Northern Cape',
    ),
    StaticDropdownItem(
      title: 'North West',
      value: 'North West',
    ),
  ]),
])
class SelectLocationView extends StatelessWidget with $SelectLocationView {
  const SelectLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectLocationViewModel>.reactive(
      onViewModelReady: (model) {
        syncFormWithViewModel(model);
        model.setCountry(CountryValueToTitleMap.keys.first);
        model.setProvince(ProvinceValueToTitleMap.keys.first);
      },
      viewModelBuilder: () => SelectLocationViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 26, 27, 30),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const Text("Select Location",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800)),
              const Text("Manually select your location"),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Country'),
                  const SizedBox(width: 15),
                  DropdownButton<String>(
                    value: model.countryValue,
                    onChanged: (value) {
                      model.setCountry(value!);
                    },
                    items: CountryValueToTitleMap.keys
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(CountryValueToTitleMap[value]!),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('State &#x2F; Province'),
                  const SizedBox(width: 15),
                  DropdownButton<String>(
                    value: model.provinceValue,
                    onChanged: (value) {
                      model.setProvince(value!);
                    },
                    items: ProvinceValueToTitleMap.keys
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(ProvinceValueToTitleMap[value]!),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ]),
          ),
        ),
      ),
    );
  }
}
