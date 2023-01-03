import 'package:args/command_runner.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/process_service.dart';

class GenerateCommand extends Command {
  final _processService = locator<ProcessService>();

  @override
  String get description =>
      '''Generates the code for the stacked application if any changes were made''';

  @override
  String get name => 'generate';

  @override
  Future<void> run() async {
    await _processService.runBuildRunner();
  }
}
