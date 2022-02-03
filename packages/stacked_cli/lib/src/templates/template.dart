/// This model contains all the the information for us to generate
/// a stacked template
class StackedTemplate {
  final List<TemplateFile> templateFiles;

  StackedTemplate({required this.templateFiles});
}

/// Describes a single file in a [StackedTemplate]
class TemplateFile {
  /// Stores the path to output the file relative to the root of your
  /// Flutter project
  final String relativeOutputPath;

  /// Stores templatable content to render out to disk
  final String content;

  TemplateFile({
    required this.relativeOutputPath,
    required this.content,
  });
}
