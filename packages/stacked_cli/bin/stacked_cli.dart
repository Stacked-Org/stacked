import 'package:stacked_cli/src/services/template_service.dart';

void main(List<String> arguments) {
// TODO: When adding the command add accepted values to ensure we can never pass in random values.

// Create a templating service that will write out files in the directory this
// is run using mustache for templates.
  TemplateService().renderTemplate(
    templateName: 'view',
    viewName: 'details',
  );
}
