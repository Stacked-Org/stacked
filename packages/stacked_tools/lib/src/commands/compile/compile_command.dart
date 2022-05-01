import 'package:args/command_runner.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/services/template_service.dart';

/// The command to run
class CompileCommand extends Command {
  final _templateService = locator<TemplateService>();

  @override
  String get description =>
      '''Uses the /templates folder and creates the appropriate template code required for the scaffolding.
      This command is for use during development of the cli, not in its compile form. 
      ''';

  @override
  String get name => 'compile';

  @override
  Future<void> run() async {
    await _templateService.compileTemplateInformation();
  }
}
