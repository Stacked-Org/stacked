import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/commands/create/create_command.dart';
import 'package:stacked_cli/src/locator.dart';

void main(List<String> arguments) {
  // Is this even right? I'm fine with this for now. Will look for better way to do it.
  setupLocator();

  // TODO: When adding the command add accepted values to ensure we can never pass in random values.
  final runner = CommandRunner(
    'stacked_cli',
    'A command line interface for building and scaffolding stacked apps',
  )
    ..addCommand(CreateCommand())
    ..run(arguments);
}
