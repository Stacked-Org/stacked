import 'package:args/command_runner.dart';
import 'package:stacked_tools/src/constants/command_constants.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_tools/src/services/process_service.dart';
import 'package:stacked_tools/src/services/template_service.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';

import '../../services/pubspec_service.dart';

class CreateServiceCommand extends Command with ProjectStructureValidator {
  final _templateService = locator<TemplateService>();
  final _pubspecService = locator<PubspecService>();
  final _processService = locator<ProcessService>();

  @override
  String get description =>
      'Creates a service with all associated files and makes necessary code changes to include that service.';

  @override
  String get name => kTemplateNameService;

  CreateServiceCommand() {
    argParser.addFlag(
      ksExcludeDependency,
      defaultsTo: false,
      help: kCommandHelpExcludeRoute,
    );
    argParser.addOption(
      ksLineLength,
      abbr: 'l',
      help: 'The length of the line that is used for formatting',
      valueHelp: '80',
    );
  }

  @override
  Future<void> run() async {
    final outputPath = argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    _processService.formattingLineLength = argResults?[ksLineLength];
    await _pubspecService.initialise(workingDirectory: outputPath);
    await validateStructure(outputPath: outputPath);

    await _templateService.renderTemplate(
      templateName: kTemplateNameService,
      name: argResults!.rest.first,
      outputPath: outputPath,
      verbose: true,
      excludeRoute: argResults![ksExcludeDependency],
    );
    await _processService.runBuildRunner(appName: outputPath);
  }
}
