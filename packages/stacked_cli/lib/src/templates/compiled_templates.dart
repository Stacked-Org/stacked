/// NOTE: This is generated code from the compileTemplates command. Do not modify by hand
///       This file should be checked into source control.


// -------- GenericService Template Data ----------

const String kServiceTemplateGenericServicePath =
    'lib\\services\\generic_service.dart.stk';

const String kServiceTemplateGenericServiceContent = '''
class {{serviceName}}Service {

}
''';

// --------------------------------------------------


// -------- GenericServiceTest Template Data ----------

const String kServiceTemplateGenericServiceTestPath =
    'test\\services_tests\\generic_service_test.dart.stk';

const String kServiceTemplateGenericServiceTestContent = '''
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('{{serviceName}}ServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------


// -------- GenericView Template Data ----------

const String kViewTemplateGenericViewPath =
    'lib\\ui\\views\\generic\\generic_view.dart.stk';

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

// --------------------------------------------------


// -------- GenericViewmodel Template Data ----------

const String kViewTemplateGenericViewmodelPath =
    'lib\\ui\\views\\generic\\generic_viewmodel.dart.stk';

const String kViewTemplateGenericViewmodelContent = '''
import 'package:stacked/stacked.dart';

class {{viewModelName}} extends BaseViewModel {
}
''';

// --------------------------------------------------


// -------- GenericViewmodelTest Template Data ----------

const String kViewTemplateGenericViewmodelTestPath =
    'test\\viewmodel_tests\\generic_viewmodel_test.dart.stk';

const String kViewTemplateGenericViewmodelTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('{{viewModelName}} Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

''';

// --------------------------------------------------

