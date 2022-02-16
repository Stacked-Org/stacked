import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/message_constants.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class CreateViewCommand extends Command {
  final _templateService = locator<TemplateService>();

  @override
  String get description =>
      'Creates a view with all associated files and makes necessary code changes for adding a view.';

  @override
  String get name => kTemplateNameView;

  CreateViewCommand() {
    // TODO: Move the command names and flags into a constants file to make it easier to work with
    argParser.addFlag(
      'exclude-route',
      defaultsTo: false,
      help: kCommandHelpExcludeRoute,
    );
  }

  @override
  Future<void> run() async {
    // TODO: We need to add command structure validation if possible
    await _templateService.renderTemplate(
      templateName: kTemplateNameView,
      name: argResults!.rest.first,
      verbose: true,
      excludeRoute: argResults!['exclude-route'],
    );
  }
}
