import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:stackedcli/src/locator.dart';
import 'package:stackedcli/src/services/template_service.dart';
import 'package:stackedcli/src/templates/template_constants.dart';

class CreateAppCommand extends Command {
  final _templateService = locator<TemplateService>();

  @override
  String get description =>
      'Creates a stacked application with all the basics setup';

  @override
  String get name => 'app';

  @override
  Future<void> run() async {
    final appName = argResults!.rest.first;

    await _runProcessAndLogOutput(
      programName: 'flutter',
      arguments: ['create', appName],
    );

    stdout.writeln('Add Stacked Magic ... ');
    await _templateService.renderTemplate(
      templateName: kTemplateNameApp,
      name: appName,
      verbose: true,
      outputPath: appName,
    );

    await _runProcessAndLogOutput(
      programName: 'flutter',
      arguments: ['pub', 'get'],
      workingDirectory: appName,
    );
    // flutter pub run build_runner build --delete-conflicting-outputs
    await _runProcessAndLogOutput(
      programName: 'flutter',
      arguments: [
        'pub',
        'run',
        'build_runner',
        'build',
        '--delete-conflicting-outputs'
      ],
      workingDirectory: appName,
    );
  }

  Future<void> _runProcessAndLogOutput({
    required String programName,
    List<String> arguments = const [],
    String? workingDirectory,
  }) async {
    final hasWorkingDirectory = workingDirectory != null;
    stdout.writeln(
        'Running $workingDirectory${hasWorkingDirectory ? '/' : ''}$programName ${arguments.join(' ')} ... ');
    var process = await Process.start(
      programName,
      arguments,
      workingDirectory: workingDirectory,
    );
    process.stdout.transform(utf8.decoder).forEach((output) {
      stdout.writeln(output);
    });

    final exitCode = await process.exitCode;
    stdout.writeln('Command complete. ExitCode: $exitCode');
  }
}
