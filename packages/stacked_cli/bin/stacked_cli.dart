import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/template_service.dart';

void main(List<String> arguments) {
  // Is this even right? I'm fine with this for now. Will look for better way to do it.
  setupLocator();

// TODO: When adding the command add accepted values to ensure we can never pass in random values.

// Create a templating service that will write out files in the directory this
// is run using mustache for templates.
  TemplateService().renderTemplate(
    templateName: 'view',
    viewName: 'details',
    verbose: true,
  );
}
