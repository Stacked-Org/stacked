import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';

class GenerateCommand extends Command {
  final _processService = locator<ProcessService>();
  final _analyticsService = locator<AnalyticsService>();

  @override
  String get description =>
      '''Generates the code for the stacked application if any changes were made''';

  @override
  String get name => 'generate';

  @override
  Future<void> run() async {
    unawaited(_analyticsService.generateCodeEvent());
    await _processService.runBuildRunner();
  }
}
