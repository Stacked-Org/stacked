import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

class CreateAppCommand extends Command {
  final _cLog = locator<ColorizedLogService>();
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _processService = locator<ProcessService>();
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<AnalyticsService>();

  @override
  String get description =>
      'Creates a stacked application with all the basics setup';

  @override
  String get name => 'app';

  CreateAppCommand() {
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
    await _configService.loadConfig();
    final appName = argResults!.rest.first;
    final appNameWithoutPath = appName.split('/').last;
    unawaited(_analyticsService.createAppEvent(name: appNameWithoutPath));
    _processService.formattingLineLength = argResults![ksLineLength];
    await _processService.runCreateApp(appName: appName);

    /// Removes `widget_test` file to avoid failing unit tests on created app
    await _fileService.deleteFile(filePath: '$appName/test/widget_test.dart');

    _cLog.stackedOutput(message: 'Add Stacked Magic ... ', isBold: true);

    await _templateService.renderTemplate(
      templateName: name,
      name: appNameWithoutPath,
      verbose: true,
      outputPath: appName,
      useBuilder: argResults![ksV1] ?? _configService.v1,
    );

    await _processService.runPubGet(appName: appName);
    await _processService.runBuildRunner(appName: appName);
    await _processService.runFormat(appName: appName);
  }
}
