import 'package:args/command_runner.dart';
import 'package:stacked_tools/src/constants/command_constants.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_tools/src/services/process_service.dart';
import 'package:stacked_tools/src/services/pubspec_service.dart';
import 'package:stacked_tools/src/services/render_template_service.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';

class CreateViewCommand extends Command with ProjectStructureValidator {
  final _renderTemplateService = locator<RenderTemplateService>();
  final _pubspecService = locator<PubspecService>();
  final _processService = locator<ProcessService>();

  @override
  String get description =>
      'Creates a view with all associated files and makes necessary code changes for adding a view.';

  @override
  String get name => kTemplateNameView;

  CreateViewCommand() {
    argParser.addFlag(
      ksExcludeRoute,
      defaultsTo: false,
      help: kCommandHelpExcludeRoute,
    );
  }

  @override
  Future<void> run() async {
    final outputPath = argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    await _pubspecService.initialise(workingDirectory: outputPath);
    await validateStructure(outputPath: outputPath);

    await _renderTemplateService.renderTemplate(
      templateName: kTemplateNameView,
      name: argResults!.rest.first,
      outputPath: outputPath,
      verbose: true,
      excludeRoute: argResults![ksExcludeRoute],
    );
    await _processService.runBuildRunner(appName: outputPath);
    await _processService.runFormat(appName: outputPath);
  }
}
