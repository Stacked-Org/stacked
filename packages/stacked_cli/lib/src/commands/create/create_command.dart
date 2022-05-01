import 'package:args/command_runner.dart';
import 'package:stacked_cli/src/commands/create/create_view_command.dart';

/// A command with subcommands that allows you to create / scaffold
/// different parts of the stacked application
class CreateCommand extends Command {
  @override
  String get description =>
      'Provides access to the different creation tools we have for stacked.';

  @override
  String get name => 'create';

  CreateCommand() {
    addSubcommand(CreateViewCommand());
  }
}
