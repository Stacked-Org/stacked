import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/template_service.dart';

/// The command to run
class CompileCommand extends Command {
  final _templateService = locator<TemplateService>();
  final _analyticsService = locator<AnalyticsService>();

  @override
  String get description =>
      '''Uses the /templates folder and creates the appropriate template code required for the scaffolding.
      This command is for use during development of the cli, not in its compile form. 
      ''';

  @override
  String get name => 'compile';

  @override
  Future<void> run() async {
    await _templateService.compileTemplateInformation();
    unawaited(_analyticsService.templatesCompiled());
  }
}
