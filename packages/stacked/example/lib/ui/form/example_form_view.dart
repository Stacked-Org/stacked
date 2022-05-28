import 'package:flutter/material.dart';
import 'package:new_architecture/ui/form/validators.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'example_form_view.form.dart';
import 'example_form_viewmodel.dart';

// #1: Add the annotation
@FormView(fields: [
  FormTextField(
    name: 'email',
    initialValue: "Lorem",
    validator: FormValidators.emailValidator,
  ),
  FormTextField(
    name: 'password',
    isPassword: true,
    validator: FormValidators.passwordValidator,
  ),
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
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: TextFormField(
                    //#4: Set email emailController and focus node
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                  ),
                ),
                if (viewModel.hasEmailValidationMessage)
                  Text(
                    viewModel.emailValidationMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 15),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: TextFormField(
                    //#5: Set password passwordController and focus node
                    controller: passwordController,
                    decoration: const InputDecoration(hintText: 'password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    focusNode: passwordFocusNode,
                    onFieldSubmitted: (_) => viewModel.saveData(),
                  ),
                ),
                if (viewModel.hasPasswordValidationMessage)
                  Text(
                    viewModel.passwordValidationMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 15),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                  ),
                  child: TextField(
                    //#6: Set shortBio shortBioController and focus node
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: shortBioController,
                    decoration: const InputDecoration(
                      hintText: 'Tell us a bit more about yourself',
                    ),
                    focusNode: shortBioFocusNode,
                  ),
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text('Do you love food?'),
                    const SizedBox(width: 15),
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
                ),
                const SizedBox(height: 15),
                if (viewModel.showValidationMessage)
                  Text(
                    viewModel.validationMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ExampleFormViewModel(),
    );
  }
}
