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

class CreateViewCommand extends Command with ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<AnalyticsService>();

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

    argParser.addOption(
      ksTemplateType,
      abbr: 't',
      // TODO (Create App Templates): Generate a constant with these values when
      // running the compile command
      allowed: ['empty'],
      help: kCommandHelpCreateViewTemplate,
    );
  }

  @override
  Future<void> run() async {
    final viewName = argResults!.rest.first;
    var templateType = argResults![ksTemplateType] as String?;
    unawaited(_analyticsService.createViewEvent(name: viewName));
    final outputPath = argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    await _configService.loadConfig(path: outputPath);
    _processService.formattingLineLength = argResults![ksLineLength];
    await _pubspecService.initialise(workingDirectory: outputPath);
    await validateStructure(outputPath: outputPath);

    // Determine which template to use with the following rules:
    // 1. If the template is supplied we use that template
    // 2. If the template is null use config web to decide
    templateType ??= _configService.preferWeb ? 'web' : 'empty';

    await _templateService.renderTemplate(
      templateName: name,
      name: viewName,
      outputPath: outputPath,
      verbose: true,
      excludeRoute: argResults![ksExcludeRoute],
      useBuilder: argResults![ksV1] ?? _configService.v1,
      templateType: templateType,
    );
    await _processService.runBuildRunner(appName: outputPath);
  }
}
