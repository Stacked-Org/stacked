import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'example_form_view.form.dart';
import 'example_form_viewmodel.dart';

// #1: Add the annotation
@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password', isPassword: true),
  FormTextField(name: 'shortBio'),
  FormDateField(name: 'birthDate'),
  FormDropdownField(
    name: 'doYouLoveFood',
    items: [
      StaticDropdownItem(
        title: 'Yes',
        value: 'YesDr',
      ),
      StaticDropdownItem(
        title: 'No',
        value: 'NoDr',
      ),
    ],
  )
])
// #2: with $ExampleFormView
class ExampleFormView extends StatelessWidget with $ExampleFormView {
  ExampleFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExampleFormViewModel>.reactive(
      onModelReady: (viewModel) {
        // #3: Listen to text updates by calling listenToFormUpdated(model);
        listenToFormUpdated(viewModel);
        viewModel.setDoYouLoveFood(DoYouLoveFoodValueToTitleMap.keys.first);
      },
      builder: (context, viewModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            viewModel.navigateSomewhere();
          },
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: TextFormField(
                    //#4: Set email emailController and focus node
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                  ),
                ),
                SizedBox(height: 15),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: TextFormField(
                    //#5: Set password passwordController and focus node
                    controller: passwordController,
                    decoration: InputDecoration(hintText: 'password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    focusNode: passwordFocusNode,
                    onFieldSubmitted: (_) => viewModel.saveData(),
                  ),
                ),
                if (viewModel.showValidation)
                  Text(
                    viewModel.validationMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 15),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: TextField(
                    //#6: Set shortBio shortBioController and focus node
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: shortBioController,
                    decoration: InputDecoration(
                      hintText: 'Tell us a bit more about yourself',
                    ),
                    focusNode: shortBioFocusNode,
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => viewModel.selectBirthDate(
                      context: context,
                      firstDate: DateTime(1950),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2023)),
                  child: Text(
                    viewModel.hasBirthDate
                        ? viewModel.birthDateValue.toString()
                        : 'Select your Date of birth',
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text('Do you love food?'),
                    SizedBox(width: 15),
                    DropdownButton<String>(
                      value: viewModel.doYouLoveFoodValue,
                      onChanged: (value) {
                        viewModel.setDoYouLoveFood(value!);
                      },
                      items: DoYouLoveFoodValueToTitleMap.keys
                          .map(
                            (value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(DoYouLoveFoodValueToTitleMap[value]!),
                            ),
                          )
                          .toList(),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ExampleFormViewModel(),
    );
  }
}
