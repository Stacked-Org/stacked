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

class DeleteViewCommand extends Command with ProjectStructureValidator {
  final _configService = locator<ConfigService>();
  final _fileService = locator<FileService>();
  final _processService = locator<ProcessService>();
  final _pubspecService = locator<PubspecService>();
  final _templateService = locator<TemplateService>();

  @override
  String get description =>
      'Deletes a view with all associated files and makes necessary code changes for deleting a view.';

  @override
  String get name => kTemplateNameView;

  DeleteViewCommand() {
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
    final outputPath = argResults!.rest.length > 1 ? argResults!.rest[1] : null;
    await _configService.loadConfig(path: outputPath);
    _processService.formattingLineLength = argResults?[ksLineLength];
    await _pubspecService.initialise(workingDirectory: outputPath);
    await validateStructure(outputPath: outputPath);
    await deleteViewAndTestFiles(outputPath: outputPath);
    await removeViewFromRoute(outputPath: outputPath);
    await _processService.runBuildRunner(appName: outputPath);
  }

  /// It deletes the view and test files
  ///
  /// Args:
  ///   outputPath (String): The path to the output folder.
  Future<void> deleteViewAndTestFiles({String? outputPath}) async {
    /// Deleting the view folder.
    String directoryPath = _templateService.getTemplateOutputPath(
      inputTemplatePath: 'lib/ui/views/generic/',

      ///TODO: Change this 👆 to the config file view path when it's added.
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.deleteFolder(directoryPath: directoryPath);

    /// Deleting the test file for the view.
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kViewTemplateGenericViewmodelTestPath,
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.deleteFile(filePath: filePath);
  }

  /// It removes the view from [app.dart]
  ///
  /// Args:
  ///   outputPath (String): The path to the output folder.
  Future<void> removeViewFromRoute({String? outputPath}) async {
    String filePath = _templateService.getTemplateOutputPath(
      inputTemplatePath: kAppTemplateAppPath,
      name: argResults!.rest.first,
      outputFolder: outputPath,
    );
    await _fileService.removeSpecificFileLines(
      filePath: filePath,
      removedContent: argResults!.rest.first,
    );
  }
}
