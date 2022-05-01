import 'package:args/command_runner.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/message_constants.dart';
import 'package:stacked_tools/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_tools/src/services/template_service.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';

class CreateServiceCommand extends Command with ProjectStructureValidator {
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
    final outputPath = argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    await validateStructure(outputPath: outputPath);

    await _templateService.renderTemplate(
      templateName: kTemplateNameService,
      name: argResults!.rest.first,
      outputPath: outputPath,
      verbose: true,
      excludeRoute: argResults!['exclude-dependency'],
    );
  }
}
