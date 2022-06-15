import 'package:args/command_runner.dart';
import 'package:stacked_tools/src/constants/command_constants.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_tools/src/services/revert_template_service.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';

class DeleteServiceCommand extends Command with ProjectStructureValidator {
  final _revertTemplateService = locator<RevertTemplateService>();

  @override
  String get description =>
      'Deletes a service with all associated files and makes necessary code changes for deleting a service.';

  @override
  String get name => kTemplateNameService;

  DeleteServiceCommand() {
    argParser.addFlag(
      ksExcludeRoute,
      defaultsTo: false,
      help: kCommandHelpExcludeDependency,
    );
  }

  @override
  Future<void> run() async {
    await _revertTemplateService.purgeTemplate(
        kTemplateNameService, argResults!, this);
  }
}
