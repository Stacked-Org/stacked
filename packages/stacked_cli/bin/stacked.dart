import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:stacked_tools/src/commands/compile/compile_command.dart';
import 'package:stacked_tools/src/commands/create/create_command.dart';
import 'package:stacked_tools/src/commands/delete/delete_command.dart';
import 'package:stacked_tools/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_tools/src/locator.dart';

Future<void> main(List<String> arguments) async {
  await setupLocator();

  try {
    CommandRunner(
      'stacked_tools',
      'A command line interface for building and scaffolding stacked apps',
    )
      ..addCommand(CreateCommand())
      ..addCommand(DeleteCommand())
      ..addCommand(CompileCommand())
      ..run(arguments);
  } on InvalidStackedStructureException catch (e) {
    stdout.writeln(e.message);
    exit(2);
  }
}
