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
      "org",
      abbr: "o",
      help: kCommandOrganizationHelp,
    );

    argParser.addOption(
      "platform",
      abbr: "p",
      help: kCommandPlatformHelp,
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
      allowed: ['mobile', 'web'],
      defaultsTo: 'mobile',
      help: kCommandHelpCreateAppTemplate,
    );
  }

  @override
  Future<void> run() async {
    await _configService.loadConfig();
    _cLog.stackedOutput(message: argResults!.rest.first, isBold: true);
    final appName = argResults!.rest.first;
    final appNameWithoutPath = appName.split('/').last;
    final templateType = argResults![ksTemplateType];
    String organization = "";
    String platforms = "";

    int indexOrg = argResults!.arguments.indexOf("--org");
    if (indexOrg != -1) {
      organization = argResults!.arguments[indexOrg + 1];
    }

    if (indexOrg == -1) {
      indexOrg = argResults!.arguments.indexOf("-o");
      if (indexOrg != -1) {
        organization = argResults!.arguments[indexOrg + 1];
      }
    }

    int indexPlatform = argResults!.arguments.indexOf("--platforms");
    if (indexPlatform != -1) {
      platforms = argResults!.arguments[indexPlatform + 1];
    }

    if (indexPlatform == -1) {
      indexPlatform = argResults!.arguments.indexOf("-p");
      if (indexPlatform != -1) {
        platforms = argResults!.arguments[indexPlatform + 1];
      }
    }

    // Organization must be a valid bundle name. (com.example)
    if (organization.isNotEmpty && !organization.contains(".")) {
      _cLog.error(
          message: "Organization must be a valid bundle name. (com.example)");
      return;
    }

    // Regarding https://dart.dev/tools/pub/pubspec#name
    // The name may only contain lowercase letters, digits, underscores.
    // And is not allowed to starts with numbers.
    if (appName.contains(RegExp(r'[A-Z]')) ||
        appName.startsWith(RegExp(r'[0-9]'))) {
      _cLog.error(
          message:
              "App name must contains lower letters and is not allowed to start with numbers (example, example1)");
      return;
    }

    unawaited(_analyticsService.createAppEvent(name: appNameWithoutPath));
    _processService.formattingLineLength = argResults![ksLineLength];

    _cLog.stackedOutput(message: 'Add Stacked Magic ... ', isBold: true);

    await _processService.runCreateApp(
        organization: organization, platforms: platforms, appName: appName);

    await _templateService.renderTemplate(
      templateName: name,
      name: appNameWithoutPath,
      verbose: true,
      outputPath: appName,
      useBuilder: argResults![ksV1] ?? _configService.v1,
      templateType: templateType,
    );

    await _processService.runPubGet(appName: appName);
    await _processService.runBuildRunner(appName: appName);
    await _processService.runFormat(appName: appName);
    await _clean(appName: appName);
  }

  /// Cleans the project.
  ///
  ///   - Deletes widget_test.dart file
  ///   - Removes unused imports
  Future<void> _clean({required String appName}) async {
    _cLog.stackedOutput(message: 'Cleaning project...');

    // Removes `widget_test` file to avoid failing unit tests on created app
    await _fileService.deleteFile(
      filePath: '$appName/test/widget_test.dart',
      verbose: false,
    );

    // Analyze the project and return output lines
    final issues = await _processService.runAnalyze(appName: appName);

    for (var i in issues) {
      if (!i.endsWith('unused_import')) continue;

      final log = i.split(' • ')[2].split(':');

      await _fileService.removeLinesOnFile(
        filePath: '$appName/${log[0]}',
        linesNumber: [int.parse(log[1])],
      );
    }

    _cLog.stackedOutput(message: 'Project cleaned.');
  }
}
