import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:pubspec_yaml/pubspec_yaml.dart';
import 'package:stacked_cli/src/commands/compile/compile_command.dart';
import 'package:stacked_cli/src/commands/create/create_command.dart';
import 'package:stacked_cli/src/commands/delete/delete_command.dart';
import 'package:stacked_cli/src/commands/generate/generate_command.dart';
import 'package:stacked_cli/src/commands/update/update_command.dart';
import 'package:stacked_cli/src/constants/command_constants.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/analytics_service.dart';

Future<void> main(List<String> arguments) async {
  await setupLocator();

  final runner = CommandRunner(
    'stacked_cli',
    'A command line interface for building and scaffolding stacked apps',
  )
    ..argParser.addFlag(
      ksVersion,
      abbr: 'v',
      negatable: false,
      help: kCommandHelpVersion,
    )
    ..argParser.addFlag(
      ksEnableAnalytics,
      negatable: false,
      help: kCommandHelpEnableAnalytics,
    )
    ..argParser.addFlag(
      ksDisableAnalytics,
      negatable: false,
      help: kCommandHelpDisableAnalytics,
    )
    ..addCommand(CreateCommand())
    ..addCommand(DeleteCommand())
    ..addCommand(CompileCommand())
    ..addCommand(GenerateCommand())
    ..addCommand(UpdateCommand());

  try {
    final argResults = runner.parse(arguments);
    await _handleFirstRun();

    if (_handleVersion(argResults)) exit(0);

    if (_handleAnalytics(argResults)) exit(0);

    runner.run(arguments);
  } on InvalidStackedStructureException catch (e) {
    stdout.writeln(e.message);
    locator<AnalyticsService>().logExceptionEvent(
      mode: ExceptionMode.handledException,
      runtimeType: e.runtimeType.toString(),
      message: e.toString(),
    );
    exit(2);
  } catch (e, s) {
    stdout.writeln(e.toString());
    locator<AnalyticsService>().logExceptionEvent(
      mode: ExceptionMode.unhandledException,
      runtimeType: e.runtimeType.toString(),
      message: e.toString(),
      stackTrace: s.toString(),
    );
    exit(2);
  }
}

bool _handleVersion(ArgResults argResults) {
  if (!argResults[ksVersion]) return false;

  final pubspec = File('pubspec.yaml').readAsStringSync().toPubspecYaml();
  stdout.writeln(pubspec.version.valueOr(() => ''));

  return true;
}

bool _handleAnalytics(ArgResults argResults) {
  if (argResults[ksEnableAnalytics]) {
    locator<AnalyticsService>().enable(true);
    return true;
  }

  if (argResults[ksDisableAnalytics]) {
    locator<AnalyticsService>().enable(false);
    return true;
  }

  return false;
}

Future<void> _handleFirstRun() async {
  final analyticsService = locator<AnalyticsService>();
  if (!analyticsService.isFirstRun) return;

  stdout.write(
    '''
  +---------------------------------------------------+
  |           Welcome to the Stacked CLI!             |
  +---------------------------------------------------+
  | We would like to collect anonymous                |
  | usage statistics in order to improve the tool.    |
  |                                                   |
  | Would you like to opt-into help us improve?       |
  +---------------------------------------------------+
  ''',
  );
  stdout.write('[y/n]: ');

  final opt = stdin.readLineSync()?.toLowerCase().trim();
  analyticsService.enable(opt == 'y' || opt == 'yes');
}
