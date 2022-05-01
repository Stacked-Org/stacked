import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:stackedcli/src/commands/compile/compile_command.dart';
import 'package:stackedcli/src/commands/create/create_command.dart';
import 'package:stackedcli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stackedcli/src/locator.dart';

Future<void> main(List<String> arguments) async {
  await setupLocator();

  try {
    CommandRunner(
      'stackedcli',
      'A command line interface for building and scaffolding stacked apps',
    )
      ..addCommand(CreateCommand())
      ..addCommand(CompileCommand())
      ..run(arguments);
  } on InvalidStackedStructureException catch (e) {
    stdout.writeln(e.message);
    exit(2);
  }
}
