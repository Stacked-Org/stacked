import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class CreateServiceCommand extends Command with ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<AnalyticsService>();

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
      help: kCommandHelpLineLength,
      valueHelp: '80',
    );
  }

  @override
  Future<void> run() async {
    final serviceName = argResults!.rest.first;
    final templateType = argResults![ksTemplateType];
    unawaited(_analyticsService.createServiceEvent(name: serviceName));
    final outputPath = argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    await _configService.loadConfig(path: outputPath);
    _processService.formattingLineLength = argResults?[ksLineLength];
    await _pubspecService.initialise(workingDirectory: outputPath);
    await validateStructure(outputPath: outputPath);

    await _templateService.renderTemplate(
      templateName: name,
      name: serviceName,
      outputPath: outputPath,
      verbose: true,
      excludeRoute: argResults![ksExcludeDependency],
      templateType: templateType,
    );
    await _processService.runBuildRunner(appName: outputPath);
  }
}
