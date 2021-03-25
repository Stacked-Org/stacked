import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'example_form_view.form.dart';
import 'example_form_viewmodel.dart';

// #1: Add the annotation
@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password', isPassword: true),
  FormDateField(name: 'birthDate'),
  FormDropdownField(
    name: 'orderSize',
    items: ['Extra Large', 'Large', 'Medium', 'Small', 'Extra Small'],
  )
])
// #2: with $ExampleFormView
class ExampleFormView extends StatelessWidget with $ExampleFormView {
  ExampleFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExampleFormViewModel>.reactive(
      onModelReady: (model) {
        // #3: Listen to text updates by calling listenToFormUpdated(model);
        listenToFormUpdated(model);
      },
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.navigateSomewhere();
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
                    focusNode: passwordFocusNode,
                    onFieldSubmitted: (_) => model.saveData(),
                  ),
                ),
                if (model.showValidation)
                  Text(
                    '${model.validationMessage}',
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => model.selectBirthDate(
                      context: context,
                      firstDate: DateTime(1950),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2023)),
                  child: Text(
                    model.hasBirthDate
                        ? model.birthDateValue.toString()
                        : 'Select your Date of birth',
                  ),
                ),
                SizedBox(height: 15),
                DropdownButton<String>(
                  value: model.hasOrderSize
                      ? model.orderSizeValue
                      : OrderSizeValues.first,
                  onChanged: (orderSize) {
                    model.setOrderSize(orderSize!);
                  },
                  items: OrderSizeValues.map(
                    (e) => DropdownMenuItem<String>(
                      child: Text(e),
                    ),
                  ).toList(),
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
