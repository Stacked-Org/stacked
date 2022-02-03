/// This model contains all the the information for us to generate
/// a stacked template
class StackedTemplate {
  final List<TemplateFile> templateFiles;
  final List<ModificationFile> modificationFiles;

  StackedTemplate({
    required this.templateFiles,
    this.modificationFiles = const [],
  });
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

/// Describes a file to modify as apart of the template process and
/// provides all information required for the modification as well as
/// failure feedback.
class ModificationFile {
  /// The relative path from the root of the flutter project
  /// to file to modify.
  final String relativeModificationPath;

  /// The string to look for in the file to indicate where the
  /// modification has to happen
  final String modificationIdentifier;

  /// The template to use when rendering the modification data
  final String modificationTemplate;

  /// The message to show to the user of the cli if the modification fails
  final String modificationProblemError;

  ModificationFile({
    required this.relativeModificationPath,
    required this.modificationIdentifier,
    required this.modificationTemplate,
    required this.modificationProblemError,
  });
}
