import 'dart:async';
import 'dart:io';

import 'package:mustache_template/mustache_template.dart';
// TODO: Refactor into a service so we can mock out the return value
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:stacked_cli/src/constants/message_constants.dart';
import 'package:stacked_cli/src/exceptions/invalid_stacked_structure_exception.dart';
import 'package:stacked_cli/src/locator.dart';
import 'package:stacked_cli/src/models/template_models.dart';
import 'package:stacked_cli/src/services/colorized_log_service.dart';
import 'package:stacked_cli/src/services/config_service.dart';
import 'package:stacked_cli/src/services/file_service.dart';
import 'package:stacked_cli/src/services/process_service.dart';
import 'package:stacked_cli/src/services/pubspec_service.dart';
import 'package:stacked_cli/src/templates/compiled_template_map.dart';
import 'package:stacked_cli/src/templates/template_constants.dart';
import 'package:stacked_cli/src/templates/template_helper.dart';
import 'package:stacked_cli/src/templates/template_render_functions.dart';

/// Given the data that points to templates it writes out those templates
/// using the same file paths
class TemplateService {
  final _fileService = locator<FileService>();
  final _processService = locator<ProcessService>();
  final _templateHelper = locator<TemplateHelper>();
  final _pubspecService = locator<PubspecService>();
  final _configService = locator<ConfigService>();
  final _clog = locator<ColorizedLogService>();

  /// List of templates that can be appended.
  static const List<String> templatesToAppend = [
    'lib/ui/setup/setup_bottom_sheet_ui.dart.stk',
    'lib/enums/bottom_sheet_type.dart.stk',
    'lib/ui/setup/setup_dialog_ui.dart.stk',
    'lib/enums/dialog_type.dart.stk',
  ];

  /// Reads the template folder and creates the dart code that will be used to generate
  /// the templates
  Future<void> compileTemplateInformation() async {
    final templatesPath = _templateHelper.templatesPath;

    final stackedTemplateFolderPaths = await _fileService.getFoldersInDirectory(
      directoryPath: templatesPath,
    );

    final stackedTemplates = <CompiledStackedTemplate>[];
    final allTemplateItems = <CompliledTemplateFile>[];

    for (final stackedTemplateFolderPath in stackedTemplateFolderPaths) {
      final templateName = _templateHelper.getTemplateFolderName(
        templateFilePath: stackedTemplateFolderPath,
      );

      final templateItemsToRender =
          await _templateHelper.getTemplateItemsToRender(
        templateName: templateName,
      );

      allTemplateItems.addAll(templateItemsToRender);

      final templateModificationsToApply = await _templateHelper
          .getTemplateModificationsToApply(templateName: templateName);

      stackedTemplates.add(CompiledStackedTemplate(
        name: templateName,
        templateFiles: templateItemsToRender,
        modificationFiles: templateModificationsToApply,
      ));
    }

    final outputTemplate = Template(kTemplateDataStructure);
    final templateItemsData = {
      'templateItems': allTemplateItems.map((e) => e.toJson()).toList(),
    };

    final allTemplateItemsContent =
        outputTemplate.renderString(templateItemsData);

    await _fileService.writeFile(
      file: File(path.join(templatesPath, 'compiled_templates.dart')),
      fileContent: allTemplateItemsContent,
    );

    // Creat the template map
    final templateMap = Template(kTemplateMapDataStructure);
    final templateMapData = {
      'stackedTemplates': stackedTemplates.map((e) => e.toJson()).toList(),
    };

    final templateMapContent = templateMap.renderString(templateMapData);
    await _fileService.writeFile(
      file: File(path.join(templatesPath, 'compiled_template_map.dart')),
      fileContent: templateMapContent,
    );
  }

  /// Using the [templateName] this function will write out the template
  /// files in the directory the cli is currently running.
  Future<void> renderTemplate({
    required String templateName,

    /// The name to use for the views when generating the view template
    required String name,
    bool verbose = false,

    /// When set to true the newly generated view will not be added to the app.dart file
    bool excludeRoute = false,

    /// When value is set, will override stacked config value. Otherwise, stacked config
    /// value is going to be used or default value.
    bool useBuilder = false,

    /// When the value is true, the bottom sheet or dialog will extends from StackedView
    /// to use a model which will be also created.
    bool hasModel = true,

    /// When supplied the templates will be created using the folder supplied here as the
    /// output location.
    ///
    /// i.e. When the template writes too lib/ui/view.dart if output path is playground
    /// the final output path will be playground/lib/ui/view.dart
    String? outputPath,
  }) async {
    // Get the template that we want to render
    final template = kCompiledStackedTemplates[templateName] ??
        StackedTemplate(templateFiles: []);

    await writeOutTemplateFiles(
      template: template,
      templateName: templateName,
      name: name,
      outputFolder: outputPath,
      useBuilder: useBuilder,
      hasModel: hasModel,
    );

    // TODO: Refactor into an exclusionary rule system where we can
    // provide new rules to exclude functionality with.
    if (templateName == kTemplateNameView && excludeRoute) {
      return;
    }

    await modifyExistingFiles(
      template: template,
      templateName: templateName,
      name: name,
      outputPath: outputPath,
    );
  }

  Future<void> writeOutTemplateFiles({
    required StackedTemplate template,
    required String templateName,
    required String name,
    String? outputFolder,
    bool useBuilder = false,
    bool hasModel = true,
  }) async {
    /// Sort template files to ensure default view will be always after v1 view.
    template.templateFiles.sort(
      (a, b) => b.relativeOutputPath.compareTo(a.relativeOutputPath),
    );

    for (var i = 0; i < template.templateFiles.length; i++) {
      final templateFile = template.templateFiles[i];

      /// Replaces view content if [useBuilder] is true and always avoid to
      /// write v1 views.
      if (templateName != 'service') {
        if (templateFile.relativeOutputPath.contains('_view_v1.dart.stk')) {
          if (useBuilder) {
            template.templateFiles[i + 1] = TemplateFile(
              relativeOutputPath:
                  template.templateFiles[i + 1].relativeOutputPath,
              content: templateFile.content,
            );
          }

          continue;
        }
      }

      if (templateName == 'bottom_sheet' || templateName == 'dialog') {
        if (templateFile.relativeOutputPath.contains('_model.dart.stk')) {
          if (!hasModel) continue;
        }

        if (templateFile.relativeOutputPath.contains('_use_model.dart.stk')) {
          if (hasModel) {
            template.templateFiles[i + 2] = TemplateFile(
              relativeOutputPath:
                  template.templateFiles[i + 2].relativeOutputPath,
              content: templateFile.content,
            );
          }

          continue;
        }
      }

      final templateContent = renderContentForTemplate(
        content: templateFile.content,
        templateName: templateName,
        name: name,
      );

      final templateFileOutputPath = getTemplateOutputPath(
        inputTemplatePath: templateFile.relativeOutputPath,
        name: name,
        outputFolder: outputFolder,
      );

      await _fileService.writeFile(
        file: File(templateFileOutputPath),
        fileContent: templateContent,
        forceAppend: shouldAppendTemplate(templateFile.relativeOutputPath),
        verbose: true,
      );

      // TODO: Add this back and format the entire project in one step
      // await _processService.runFormat(
      //   appName: outputFolder,
      //   filePath: templateFileOutputPath,
      // );
    }
  }

  /// Returns the output path for the file given the input path of the template
  String getTemplateOutputPath({
    required String inputTemplatePath,
    required String name,
    String? outputFolder,
  }) {
    final hasOutputFolder = outputFolder != null;
    final recaseName = ReCase(name);
    final modifiedOutputPath = _configService
        .replaceCustomPaths(inputTemplatePath)
        .replaceAll(
          'generic',
          recaseName.snakeCase,
        )
        .replaceFirst('.stk', '');

    if (hasOutputFolder) {
      return path.join(outputFolder, modifiedOutputPath);
    }

    return modifiedOutputPath;
  }

  /// Takes in a templated string [content] and builds the template data
  /// to use when rendering
  String renderContentForTemplate({
    required String content,
    required String templateName,
    required String name,
  }) {
    var viewTemplate = Template(content, lenient: true);

    final renderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
    );

    return viewTemplate.renderString(renderData);
  }

  /// Returns a render data map from the [template_render_functions.dart] file with map
  Map<String, String> getTemplateRenderData({
    required String templateName,
    required String name,

    /// This value is only for testing
    Map<String, RenderFunction>? testRenderFunctions,
  }) {
    final nameRecase = ReCase(name);

    final renderFunction = testRenderFunctions != null
        ? testRenderFunctions[templateName]
        : renderFunctions[templateName];

    if (renderFunction == null) {
      throw Exception(
          'No render function has been defined for the template $templateName. Please define a render function before running the command again.');
    }

    final renderDataForTemplate = renderFunction(nameRecase);

    final packageName = templateName == kTemplateNameApp ? name : null;

    return applyGlobalTemplateProperties(
      renderDataForTemplate,
      packageName: packageName,
    );
  }

  Map<String, String> applyGlobalTemplateProperties(
    Map<String, String> renderTemplate, {
    String? packageName,
  }) {
    return {
      ...renderTemplate,
      // All template data will have the values added below
      kTemplatePropertyPackageName:
          packageName ?? _pubspecService.getPackageName,
      kTemplatePropertyServiceImportPath: _configService.serviceImportPath,
      kTemplatePropertyServiceTestHelpersImport:
          _configService.serviceTestHelpersImport,
      kTemplatePropertyViewImportPath: _configService.viewImportPath,
      kTemplatePropertyViewTestHelpersImport:
          _configService.viewTestHelpersImport,
      kTemplatePropertySheetsPath: _configService.bottomSheetsPath,
      kTemplatePropertySheetBuilderFilePath:
          _configService.bottomSheetBuilderFilePath,
      kTemplatePropertySheetTypeFilePath:
          _configService.bottomSheetTypeFilePath,
      kTemplatePropertyDialogsPath: _configService.dialogsPath,
      kTemplatePropertyDialogBuilderFilePath:
          _configService.dialogBuilderFilePath,
      kTemplatePropertyDialogTypeFilePath: _configService.dialogTypeFilePath,
    };
  }

  Future<void> modifyExistingFiles({
    required StackedTemplate template,
    required String templateName,
    required String name,
    String? outputPath,
  }) async {
    final hasOutputPath = outputPath != null;
    for (final fileToModify in template.modificationFiles) {
      final customRelativeModificationPath = _configService.replaceCustomPaths(
        fileToModify.relativeModificationPath,
      );
      final modificationPath = hasOutputPath
          ? path.join(outputPath, customRelativeModificationPath)
          : customRelativeModificationPath;

      final fileExists = await _fileService.fileExists(
        filePath: modificationPath,
      );

      if (!fileExists) {
        _clog.warn(
            message:
                'Modification not applied. The file $modificationPath does not exist');
        throw InvalidStackedStructureException(kInvalidStackedStructureAppFile);
      }

      final fileContent = await _fileService.readFileAsString(
        filePath: modificationPath,
      );

      if (!fileContent.contains(fileToModify.modificationIdentifier)) {
        _clog.warn(
            message:
                'Modification not applied. The identifier `${fileToModify.modificationIdentifier}` does not exist in the file.');
      }

      final updatedFileContent = templateModificationFileContent(
        fileContent: fileContent,
        modificationIdentifier: fileToModify.modificationIdentifier,
        modificationTemplate: fileToModify.modificationTemplate,
        name: name,
        templateName: templateName,
      );

      final verboseMessage = templateModificationName(
        modificationName: fileToModify.modificationName,
        name: name,
        templateName: templateName,
      );

      // Write the file back that was modified
      await _fileService.writeFile(
        file: File(modificationPath),
        fileContent: updatedFileContent,
        verbose: true,
        type: FileModificationType.Modify,
        verboseMessage: verboseMessage,
      );
    }

    await _processService.runFormat(
      appName: outputPath,
    );
  }

  String templateModificationName({
    required String modificationName,
    required String name,
    required String templateName,
  }) {
    final template = Template(
      modificationName,
      lenient: true,
    );

    final templateRenderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
    );

    final renderedTemplate = template.renderString(templateRenderData);
    return renderedTemplate;
  }

  String templateModificationFileContent({
    required String fileContent,
    required String modificationTemplate,
    required String modificationIdentifier,
    required String name,
    required String templateName,
  }) {
    final template = Template(
      modificationTemplate,
      lenient: true,
    );

    final templateRenderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
    );

    final renderedTemplate = template.renderString(templateRenderData);

    // Take the content, replace the identifier in the file with the new code
    // plus the identifier so we can do the same thing again later.
    return fileContent.replaceFirst(
      modificationIdentifier,
      '$renderedTemplate\n$modificationIdentifier',
    );
  }

  /// Determines if a template with [relativeOutputPath] should be written using
  /// append as their FileModificationType or not.
  bool shouldAppendTemplate(String relativeOutputPath) {
    return templatesToAppend.any((template) => template == relativeOutputPath);
  }
}
