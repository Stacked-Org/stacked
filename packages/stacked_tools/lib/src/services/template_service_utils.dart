import 'dart:async';
import 'dart:io';

import 'package:mustache_template/mustache_template.dart';
// TODO: Refactor into a service so we can mock out the return value
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:stacked_tools/src/locator.dart';
import 'package:stacked_tools/src/models/template_models.dart';
import 'package:stacked_tools/src/services/file_service.dart';
import 'package:stacked_tools/src/services/pubspec_service.dart';
import 'package:stacked_tools/src/templates/template_constants.dart';
import 'package:stacked_tools/src/templates/template_helper.dart';
import 'package:stacked_tools/src/templates/template_render_functions.dart';

/// Given the data that points to templates it writes out those templates
/// using the same file paths
class TemplateServiceUtils {
  final _fileService = locator<FileService>();
  final _templateHelper = locator<TemplateHelper>();
  final _pubspecService = locator<PubspecService>();

  /// Reads the template folder and creates the dart code that will be used to generate
  /// the templates
  Future<void> compileTemplateInformation() async {
    final templatesPath = _templateHelper.templatesPath;

    final stackedTemplateFolderPaths = await _fileService.getFoldersInDirectory(
      directoryPath: templatesPath,
    );

    final stackedTemplates = <CompiledStackedTemplate>[];
    final allTemplateItems = <CompiledTemplateFile>[];

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

    // Create the template map
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

  /// Returns the output path for the file given the input path of the template
  String getTemplateOutputPath({
    required String inputTemplatePath,
    required String name,
    String? outputFolder,
  }) {
    final hasOutputFolder = outputFolder != null;

    final recaseName = ReCase(name);
    final modifiedOutputPath = inputTemplatePath
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

  /// Returns a render data map from the [template_render_functions.dart] file with map
  Map<String, String> getTemplateRenderData({
    required String templateName,
    required String name,

    /// This value is only for testing
    Map<String, RenderFunction>? testRenderFunctions,
  }) {
    print(templateName +
        ' ' +
        name +
        ' ' +
        (testRenderFunctions == null).toString());
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
    };
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

  String getRenderedTemplateData(
      String modificationTemplate, String templateName, String name) {
    final template = Template(
      modificationTemplate,
      lenient: true,
    );

    final templateRenderData = getTemplateRenderData(
      templateName: templateName,
      name: name,
    );

    final renderedTemplate = template.renderString(templateRenderData);
    return renderedTemplate;
  }
}
