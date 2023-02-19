import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_models.freezed.dart';
part 'template_models.g.dart';

@freezed
class CompliledTemplateFile with _$CompliledTemplateFile {
  factory CompliledTemplateFile({
    /// Pascal case name of the template this file belongs too
    required String name,

    /// Pascal case name of the file without the extension
    required String fileName,

    /// Relative file path from the template in the templates folder
    /// .i.e. from we don't include template/view/
    required String path,

    /// The content as is from the file that was read
    required String content,
  }) = _CompliledTemplateFile;

  factory CompliledTemplateFile.fromJson(Map<String, dynamic> json) =>
      _$CompliledTemplateFileFromJson(json);
}

@freezed
class CompiledStackedTemplate with _$CompiledStackedTemplate {
  factory CompiledStackedTemplate({
    required String name,
    required List<CompliledTemplateFile> templateFiles,
    @Default([]) List<CompiledFileModification> modificationFiles,
  }) = _CompiledStackedTemplate;

  factory CompiledStackedTemplate.fromJson(Map<String, dynamic> json) =>
      _$CompiledStackedTemplateFromJson(json);
}

@freezed
class CompiledFileModification with _$CompiledFileModification {
  factory CompiledFileModification({
    /// A short description for what this modiciation does
    required String description,

    /// The relative path to the file that needs to be modified
    required String path,

    /// The identifier to use to determine location of modifications
    required String identifier,

    /// The mustache template to use when rendering the modification
    required String template,

    /// The message to show the user of the cli if the modification fails
    required String error,

    /// The message to show the user of the cli if the modification succeeds
    required String name,
  }) = _CompiledFileModification;

  factory CompiledFileModification.fromJson(Map<String, dynamic> json) =>
      _$CompiledFileModificationFromJson(json);
}

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

  final String modificationName;

  ModificationFile({
    required this.relativeModificationPath,
    required this.modificationIdentifier,
    required this.modificationTemplate,
    required this.modificationProblemError,
    required this.modificationName,
  });
}
