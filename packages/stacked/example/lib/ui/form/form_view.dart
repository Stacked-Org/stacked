import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

import 'form_viewmodel.dart';

// REFACTOR: It's not a lot of effort to write this but it would be cool
// to not have to write it
const String EmailValueKey = 'email';
const String PasswordValueKey = 'password';

class FormView extends HookWidget {
  const FormView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // REFACTOR: I don't like how this is setup. I'd like not to have
    // to create the controllers or the focus nodes
    final email = useTextEditingController();
    final emailFocus = useFocusNode();
    final password = useTextEditingController();
    final passwordFocus = useFocusNode();

    // REFACTOR: This can be moved to the same place we would move the onChanges subscription.
    // THOUGHT: We can even let each controller update the map on their own instead of resetting the entire map?
    void _fireFormChanged(FormViewModel model) => model.setData({
          EmailValueKey: email.text,
          PasswordValueKey: password.text,
        });

    return ViewModelBuilder<FormViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                controller: email,
                // REFACTOR: Since this is called based on the controller it should be easy to
                // move this and into a hidden place where it happens automatically
                onChanged: (_) => _fireFormChanged(model),
                focusNode: emailFocus,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: password,
                onChanged: (_) => _fireFormChanged(model),
                onFieldSubmitted: (_) => model.saveData(),
                focusNode: passwordFocus,
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
