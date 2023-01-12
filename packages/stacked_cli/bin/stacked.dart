import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/commands/compile/compile_command.dart';
import 'package:stacked_cli/src/commands/create/create_command.dart';
import 'package:stacked_cli/src/commands/delete/delete_command.dart';
import 'package:stacked_cli/src/commands/generate/generate_command.dart';
import 'package:stacked_cli/src/commands/update/update_command.dart';
import 'package:stacked_cli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_cli/src/locator.dart';

Future<void> main(List<String> arguments) async {
  await setupLocator();

  try {
    CommandRunner(
      'stacked_cli',
      'A command line interface for building and scaffolding stacked apps',
    )
      ..addCommand(CreateCommand())
      ..addCommand(DeleteCommand())
      ..addCommand(CompileCommand())
      ..addCommand(GenerateCommand())
      ..addCommand(UpdateCommand())
      ..run(arguments);
  } on InvalidStackedStructureException catch (e) {
    stdout.writeln(e.message);
    exit(2);
  }
}
