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

class CreateBottomSheetCommand extends Command with ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<AnalyticsService>();

  @override
  String get description =>
      'Creates a bottom sheet with all associated files and makes necessary code changes for adding a bottom sheet.';

  @override
  String get name => kTemplateNameBottomSheet;

  CreateBottomSheetCommand() {
    argParser.addFlag(
      ksExcludeRoute,
      defaultsTo: false,
      help: kCommandHelpExcludeRoute,
    );
    argParser.addFlag(
      ksModel,
      defaultsTo: true,
      help: kCommandHelpModel,
    );
    argParser.addOption(
      ksLineLength,
      abbr: 'l',
      help: kCommandHelpLineLength,
      valueHelp: '80',
    );

    argParser.addMultiOption(
      ksTemplateType,
      abbr: 't',
      // TODO (Create App Templates): Generate a constant with these values when
      // running the compile command
      allowed: ['empty'],
      defaultsTo: ['empty'],
      help: kCommandHelpCreateBottomSheetTemplate,
    );
  }

  @override
  Future<void> run() async {
    final bottomSheetName = argResults!.rest.first;
    final templateType = argResults![ksTemplateType];
    unawaited(_analyticsService.createBottomSheetEvent(name: bottomSheetName));
    final outputPath = argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    await _configService.loadConfig(path: outputPath);
    _processService.formattingLineLength = argResults![ksLineLength];
    await _pubspecService.initialise(workingDirectory: outputPath);
    await validateStructure(outputPath: outputPath);

    await _templateService.renderTemplate(
      templateName: name,
      name: bottomSheetName,
      outputPath: outputPath,
      verbose: true,
      excludeRoute: argResults![ksExcludeRoute],
      hasModel: argResults![ksModel],
      templateType: templateType,
    );

    await _processService.runBuildRunner(appName: outputPath);
  }
}
