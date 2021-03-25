import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'example_form_view.form.dart';
import 'example_form_viewmodel.dart';

// #1: Add the annotation
@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password', isPassword: true),
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
        body: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                //#4: Set email emailController and focus node
                controller: emailController,
                focusNode: emailFocusNode,
              ),
              SizedBox(height: 15),
              TextFormField(
                //#4: Set email emailController and focus node
                controller: passwordController,
                focusNode: passwordFocusNode,
                onFieldSubmitted: (_) => model.saveData(),
              ),
              SizedBox(height: 15),
              if (model.showValidation)
                Text(
                  model.validationMessage!,
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ExampleFormViewModel(),
    );
  }
}
