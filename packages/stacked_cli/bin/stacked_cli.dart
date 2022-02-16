import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/commands/compile/compile_command.dart';
import 'package:stacked_cli/src/commands/create/create_command.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/message_constants.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';

Future<void> main(List<String> arguments) async {
  // Is this even right? I'm fine with this for now. Will look for better way to do it.
  setupLocator();

  if (arguments.contains(kTemplateNameView)) {
    // Check if we are at the root of the project. If not, exit gracefully
    if (!(await locator<FileService>().isProjectRoot())) {
      print(kInvalidRootDirectory);
      exit(2);
    }

    if (!(await locator<FileService>().isStakedApplication())) {
      print(kInvalidStackedStructure);
      exit(2);
    }
  }

  // TODO: When adding the command add accepted values to ensure we can never pass in random values.
  final runner = CommandRunner(
    'stacked_cli',
    'A command line interface for building and scaffolding stacked apps',
  )
    ..addCommand(CreateCommand())
    ..addCommand(CompileCommand())
    ..run(arguments);
}
