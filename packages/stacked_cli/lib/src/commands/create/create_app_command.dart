import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/template_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

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
    final flutterCreateCompleter = Completer();
    print('Create flutter app');
    var process = await Process.start('flutter', [
      'create',
      appName,
    ]);
    process.stdout.transform(utf8.decoder).forEach((output) {
      print(output);
      if (output.toLowerCase().contains('done')) {
        flutterCreateCompleter.complete();
      }
    });

    await flutterCreateCompleter.future;
    print('Flutter create complete.');
    print('Add Stacked Magic ... ');
    await _templateService.renderTemplate(
      templateName: kTemplateNameApp,
      name: argResults!.rest.first,
      verbose: true,
    );
  }
}
