import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';

class UpdateCommand extends Command {
  final _analyticsService = locator<AnalyticsService>();
  final _processService = locator<ProcessService>();

  @override
  String get description => '''Updates stacked_cli to latest version''';

  @override
  String get name => 'update';

  @override
  Future<void> run() async {
    await _processService.runPubGlobal();
    unawaited(_analyticsService.cliUpdated());
  }
}
