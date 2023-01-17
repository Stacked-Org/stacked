import 'package:args/command_runner.dart';

import 'create_app_command.dart';
import 'create_bottom_sheet_command.dart';
import 'create_dialog_command.dart';
import 'create_service_command.dart';
import 'create_view_command.dart';

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
    addSubcommand(CreateServiceCommand());
    addSubcommand(CreateAppCommand());
    addSubcommand(CreateBottomSheetCommand());
    addSubcommand(CreateDialogCommand());
  }
}
