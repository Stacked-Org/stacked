import 'package:args/command_runner.dart';
import 'package:stacked_tools/src/constants/command_constants.dart';
import 'package:stacked_tools/src/constants/message_constants.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/mixins/project_structure_validator_mixin.dart';
import 'package:stacked_tools/src/services/config_service.dart';
import 'package:stacked_tools/src/services/file_service.dart';
import 'package:stacked_tools/src/services/process_service.dart';
import 'package:stacked_tools/src/services/pubspec_service.dart';
import 'package:stacked_tools/src/services/template_service.dart';
import 'package:stacked_tools/src/templates/compiled_templates.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';

class DeleteServiceCommand extends Command with ProjectStructureValidator {
  final _pubspecService = locator<PubspecService>();
  final _processService = locator<ProcessService>();
  final _fileService = locator<FileService>();
  final _templateService = locator<TemplateService>();

  @override
  String get description =>
      'Deletes a service with all associated files and makes necessary code changes for deleting a service.';

  @override
  String get name => kTemplateNameService;

  DeleteServiceCommand() {
    argParser.addFlag(
      ksExcludeRoute,
      defaultsTo: false,
      help: kCommandHelpExcludeRoute,
    );
    argParser.addOption(
      ksLineLength,
      abbr: 'l',
      help: 'The length of the line that is used for formatting',
      valueHelp: '80',
    );
  }

  @override
  Future<void> run() async {
    await locator<ConfigService>().loadConfig();

    final outputPath = argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    _processService.formattingLineLength = argResults?[ksLineLength];
    await _pubspecService.initialise(workingDirectory: outputPath);
    await validateStructure(outputPath: outputPath);
    await deleteServiceAndTestFiles(outputPath: outputPath);
    await removeServiceFromTestHelper(outputPath: outputPath);
    await _processService.runBuildRunner(appName: outputPath);
  }

  /// It deletes the service and test files
  ///
  /// Args:
  ///   outputPath (String): The path to the output folder.
  Future<void> deleteServiceAndTestFiles({String? outputPath}) async {
    /// Deleting the service file.
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kServiceTemplateGenericServicePath,
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.deleteFile(filePath: filePath);

    //Delete test file for service
    filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kServiceTemplateGenericServiceTestPath,
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.deleteFile(filePath: filePath);
  }

  Future<void> removeServiceFromTestHelper({String? outputPath}) async {
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kAppTemplateTestHelpersPath,
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.removeSpecificFileLines(
      filePath: filePath,
      removedContent: argResults!.rest.first,
      type: kTemplateNameService,
    );
    _processService.runFormat(appName: outputPath, filePath: filePath);
  }
}
