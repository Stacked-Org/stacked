import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/commands/create/create_command.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/services/file_service.dart';

Future<void> main(List<String> arguments) async {
  // Is this even right? I'm fine with this for now. Will look for better way to do it.
  setupLocator();

  // Check if we are at the root of the project. If not, exit gracefully
  if (!(await locator<FileService>().isProjectRoot())) {
    print(
        '''
    No pubspec.yaml detected. It seems that you are not running the cli from the root of a flutter project. 
    Please ensure that you are in the root of a flutter project when using stackedcli.
    ''');
  }

  // TODO: When adding the command add accepted values to ensure we can never pass in random values.
  final runner = CommandRunner(
    'stacked_cli',
    'A command line interface for building and scaffolding stacked apps',
  )
    ..addCommand(CreateCommand())
    ..run(arguments);
}
