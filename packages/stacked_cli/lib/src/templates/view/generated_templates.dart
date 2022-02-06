/// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
///       This file should be checked into source control.

const String kViewTemplateGenericViewPath =
    'lib/ui/views/generic/generic_view.dart';

const String kViewTemplateGenericViewContent = '''
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '{{viewModelFileName}}';

class {{viewName}} extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<{{viewModelName}}>.reactive(
      viewModelBuilder: () => {{viewModelName}}(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          padding: EdgeInsets.only(left: 25.0, right: 25.0),
        ),
      ),
    );
  }
}
''';
