import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/message_constants.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class CreateServiceCommand extends Command {
  final _templateService = locator<TemplateService>();

  @override
  String get description =>
      'Creates a service with all associated files and makes necessary code changes to include that service.';

  @override
  String get name => kTemplateNameService;

  CreateServiceCommand() {
    argParser.addFlag(
      'exclude-dependency',
      defaultsTo: false,
      help: kCommandHelpExcludeRoute,
    );
  }

  @override
  Future<void> run() async {
    // TODO: We need to add command structure validation if possible
    await _templateService.renderTemplate(
      templateName: kTemplateNameService,
      name: argResults!.rest.first,
      verbose: true,
      excludeRoute: argResults!['exclude-dependency'],
    );
  }
}
