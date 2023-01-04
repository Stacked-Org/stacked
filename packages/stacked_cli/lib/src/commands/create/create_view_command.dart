import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class CreateViewCommand extends Command with ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();

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
    argParser.addFlag(
      ksV1,
      aliases: [ksUseBuilder],
      defaultsTo: null,
      help: kCommandHelpV1,
    );
    argParser.addOption(
      ksLineLength,
      abbr: 'l',
      help: kCommandHelpLineLength,
      valueHelp: '80',
    );
  }

  @override
  Future<void> run() async {
    final outputPath = argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    await _configService.loadConfig(path: outputPath);
    _processService.formattingLineLength = argResults![ksLineLength];
    await _pubspecService.initialise(workingDirectory: outputPath);
    await validateStructure(outputPath: outputPath);

    await _templateService.renderTemplate(
      templateName: kTemplateNameView,
      name: argResults!.rest.first,
      outputPath: outputPath,
      verbose: true,
      excludeRoute: argResults![ksExcludeRoute],
      useBuilder: argResults![ksV1] ?? _configService.v1,
    );
    await _processService.runBuildRunner(appName: outputPath);
  }
}
