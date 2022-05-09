import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/process_service.dart';
import 'package:stacked_tools/src/services/template_service.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';

class CreateAppCommand extends Command {
  final _templateService = locator<TemplateService>();
  final _processService = locator<ProcessService>();

  @override
  String get description =>
      'Creates a stacked application with all the basics setup';

  @override
  String get name => 'app';

  @override
  Future<void> run() async {
    final appName = argResults!.rest.first;

    await _processService.runCreateApp(appName: appName);

    stdout.writeln('Add Stacked Magic ... ');
    await _templateService.renderTemplate(
      templateName: kTemplateNameApp,
      name: appName,
      verbose: true,
      outputPath: appName,
    );
    await _processService.runPubGet(appName: appName);
    await _processService.runBuildRunner(appName: appName);
    await _processService.runFormat(appName: appName);
  }
}
