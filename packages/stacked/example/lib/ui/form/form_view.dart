import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart' as annotations;

import 'form_view.forms.dart';
import 'form_viewmodel.dart';

@annotations.FormView(fields: [
  annotations.FormField(name: 'email'),
  annotations.FormField(name: 'password', isPassword: true),
])
class FormView extends StatelessWidget with $FormView {
  FormView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FormViewModel>.reactive(
      onModelReady: (model) {
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
                controller: emailController,
                focusNode: emailFocusNode,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                onFieldSubmitted: (_) => model.saveData(),
                focusNode: passwordFocusNode,
              ),
              SizedBox(height: 15),
              if (model.showValidation)
                Text(
                  model.validationMessage,
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => FormViewModel(),
    );
  }
}
