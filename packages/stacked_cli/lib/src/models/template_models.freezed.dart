// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'template_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CompliledTemplateFile _$CompliledTemplateFileFromJson(
    Map<String, dynamic> json) {
  return _CompliledTemplateFile.fromJson(json);
}

/// @nodoc
class _$CompliledTemplateFileTearOff {
  const _$CompliledTemplateFileTearOff();

  _CompliledTemplateFile call(
      {required String templateName,
      required String templateFileName,
      required String templateFilePath,
      required String templateFileContent}) {
    return _CompliledTemplateFile(
      templateName: templateName,
      templateFileName: templateFileName,
      templateFilePath: templateFilePath,
      templateFileContent: templateFileContent,
    );
  }

  CompliledTemplateFile fromJson(Map<String, Object?> json) {
    return CompliledTemplateFile.fromJson(json);
  }
}

/// @nodoc
const $CompliledTemplateFile = _$CompliledTemplateFileTearOff();

/// @nodoc
mixin _$CompliledTemplateFile {
  /// Pascal case name of the template this file belongs too
  String get templateName => throw _privateConstructorUsedError;

  /// Pascal case name of the file without the extension
  String get templateFileName => throw _privateConstructorUsedError;

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  String get templateFilePath => throw _privateConstructorUsedError;

  /// The content as is from the file that was read
  String get templateFileContent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompliledTemplateFileCopyWith<CompliledTemplateFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompliledTemplateFileCopyWith<$Res> {
  factory $CompliledTemplateFileCopyWith(CompliledTemplateFile value,
          $Res Function(CompliledTemplateFile) then) =
      _$CompliledTemplateFileCopyWithImpl<$Res>;
  $Res call(
      {String templateName,
      String templateFileName,
      String templateFilePath,
      String templateFileContent});
}

/// @nodoc
class _$CompliledTemplateFileCopyWithImpl<$Res>
    implements $CompliledTemplateFileCopyWith<$Res> {
  _$CompliledTemplateFileCopyWithImpl(this._value, this._then);

  final CompliledTemplateFile _value;
  // ignore: unused_field
  final $Res Function(CompliledTemplateFile) _then;

  @override
  $Res call({
    Object? templateName = freezed,
    Object? templateFileName = freezed,
    Object? templateFilePath = freezed,
    Object? templateFileContent = freezed,
  }) {
    return _then(_value.copyWith(
      templateName: templateName == freezed
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      templateFileName: templateFileName == freezed
          ? _value.templateFileName
          : templateFileName // ignore: cast_nullable_to_non_nullable
              as String,
      templateFilePath: templateFilePath == freezed
          ? _value.templateFilePath
          : templateFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      templateFileContent: templateFileContent == freezed
          ? _value.templateFileContent
          : templateFileContent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CompliledTemplateFileCopyWith<$Res>
    implements $CompliledTemplateFileCopyWith<$Res> {
  factory _$CompliledTemplateFileCopyWith(_CompliledTemplateFile value,
          $Res Function(_CompliledTemplateFile) then) =
      __$CompliledTemplateFileCopyWithImpl<$Res>;
  @override
  $Res call(
      {String templateName,
      String templateFileName,
      String templateFilePath,
      String templateFileContent});
}

/// @nodoc
class __$CompliledTemplateFileCopyWithImpl<$Res>
    extends _$CompliledTemplateFileCopyWithImpl<$Res>
    implements _$CompliledTemplateFileCopyWith<$Res> {
  __$CompliledTemplateFileCopyWithImpl(_CompliledTemplateFile _value,
      $Res Function(_CompliledTemplateFile) _then)
      : super(_value, (v) => _then(v as _CompliledTemplateFile));

  @override
  _CompliledTemplateFile get _value => super._value as _CompliledTemplateFile;

  @override
  $Res call({
    Object? templateName = freezed,
    Object? templateFileName = freezed,
    Object? templateFilePath = freezed,
    Object? templateFileContent = freezed,
  }) {
    return _then(_CompliledTemplateFile(
      templateName: templateName == freezed
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      templateFileName: templateFileName == freezed
          ? _value.templateFileName
          : templateFileName // ignore: cast_nullable_to_non_nullable
              as String,
      templateFilePath: templateFilePath == freezed
          ? _value.templateFilePath
          : templateFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      templateFileContent: templateFileContent == freezed
          ? _value.templateFileContent
          : templateFileContent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CompliledTemplateFile implements _CompliledTemplateFile {
  _$_CompliledTemplateFile(
      {required this.templateName,
      required this.templateFileName,
      required this.templateFilePath,
      required this.templateFileContent});

  factory _$_CompliledTemplateFile.fromJson(Map<String, dynamic> json) =>
      _$$_CompliledTemplateFileFromJson(json);

  @override

  /// Pascal case name of the template this file belongs too
  final String templateName;
  @override

  /// Pascal case name of the file without the extension
  final String templateFileName;
  @override

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  final String templateFilePath;
  @override

  /// The content as is from the file that was read
  final String templateFileContent;

  @override
  String toString() {
    return 'CompliledTemplateFile(templateName: $templateName, templateFileName: $templateFileName, templateFilePath: $templateFilePath, templateFileContent: $templateFileContent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompliledTemplateFile &&
            const DeepCollectionEquality()
                .equals(other.templateName, templateName) &&
            const DeepCollectionEquality()
                .equals(other.templateFileName, templateFileName) &&
            const DeepCollectionEquality()
                .equals(other.templateFilePath, templateFilePath) &&
            const DeepCollectionEquality()
                .equals(other.templateFileContent, templateFileContent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(templateName),
      const DeepCollectionEquality().hash(templateFileName),
      const DeepCollectionEquality().hash(templateFilePath),
      const DeepCollectionEquality().hash(templateFileContent));

  @JsonKey(ignore: true)
  @override
  _$CompliledTemplateFileCopyWith<_CompliledTemplateFile> get copyWith =>
      __$CompliledTemplateFileCopyWithImpl<_CompliledTemplateFile>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompliledTemplateFileToJson(this);
  }
}

abstract class _CompliledTemplateFile implements CompliledTemplateFile {
  factory _CompliledTemplateFile(
      {required String templateName,
      required String templateFileName,
      required String templateFilePath,
      required String templateFileContent}) = _$_CompliledTemplateFile;

  factory _CompliledTemplateFile.fromJson(Map<String, dynamic> json) =
      _$_CompliledTemplateFile.fromJson;

  @override

  /// Pascal case name of the template this file belongs too
  String get templateName;
  @override

  /// Pascal case name of the file without the extension
  String get templateFileName;
  @override

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  String get templateFilePath;
  @override

  /// The content as is from the file that was read
  String get templateFileContent;
  @override
  @JsonKey(ignore: true)
  _$CompliledTemplateFileCopyWith<_CompliledTemplateFile> get copyWith =>
      throw _privateConstructorUsedError;
}

CompiledStackedTemplate _$CompiledStackedTemplateFromJson(
    Map<String, dynamic> json) {
  return _CompiledStackedTemplate.fromJson(json);
}

/// @nodoc
class _$CompiledStackedTemplateTearOff {
  const _$CompiledStackedTemplateTearOff();

  _CompiledStackedTemplate call(
      {required String templateName,
      required List<CompliledTemplateFile> templateFiles,
      List<CompiledFileModification> fileModifications = const []}) {
    return _CompiledStackedTemplate(
      templateName: templateName,
      templateFiles: templateFiles,
      fileModifications: fileModifications,
    );
  }

  CompiledStackedTemplate fromJson(Map<String, Object?> json) {
    return CompiledStackedTemplate.fromJson(json);
  }
}

/// @nodoc
const $CompiledStackedTemplate = _$CompiledStackedTemplateTearOff();

/// @nodoc
mixin _$CompiledStackedTemplate {
  String get templateName => throw _privateConstructorUsedError;
  List<CompliledTemplateFile> get templateFiles =>
      throw _privateConstructorUsedError;
  List<CompiledFileModification> get fileModifications =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompiledStackedTemplateCopyWith<CompiledStackedTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompiledStackedTemplateCopyWith<$Res> {
  factory $CompiledStackedTemplateCopyWith(CompiledStackedTemplate value,
          $Res Function(CompiledStackedTemplate) then) =
      _$CompiledStackedTemplateCopyWithImpl<$Res>;
  $Res call(
      {String templateName,
      List<CompliledTemplateFile> templateFiles,
      List<CompiledFileModification> fileModifications});
}

/// @nodoc
class _$CompiledStackedTemplateCopyWithImpl<$Res>
    implements $CompiledStackedTemplateCopyWith<$Res> {
  _$CompiledStackedTemplateCopyWithImpl(this._value, this._then);

  final CompiledStackedTemplate _value;
  // ignore: unused_field
  final $Res Function(CompiledStackedTemplate) _then;

  @override
  $Res call({
    Object? templateName = freezed,
    Object? templateFiles = freezed,
    Object? fileModifications = freezed,
  }) {
    return _then(_value.copyWith(
      templateName: templateName == freezed
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      templateFiles: templateFiles == freezed
          ? _value.templateFiles
          : templateFiles // ignore: cast_nullable_to_non_nullable
              as List<CompliledTemplateFile>,
      fileModifications: fileModifications == freezed
          ? _value.fileModifications
          : fileModifications // ignore: cast_nullable_to_non_nullable
              as List<CompiledFileModification>,
    ));
  }
}

/// @nodoc
abstract class _$CompiledStackedTemplateCopyWith<$Res>
    implements $CompiledStackedTemplateCopyWith<$Res> {
  factory _$CompiledStackedTemplateCopyWith(_CompiledStackedTemplate value,
          $Res Function(_CompiledStackedTemplate) then) =
      __$CompiledStackedTemplateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String templateName,
      List<CompliledTemplateFile> templateFiles,
      List<CompiledFileModification> fileModifications});
}

/// @nodoc
class __$CompiledStackedTemplateCopyWithImpl<$Res>
    extends _$CompiledStackedTemplateCopyWithImpl<$Res>
    implements _$CompiledStackedTemplateCopyWith<$Res> {
  __$CompiledStackedTemplateCopyWithImpl(_CompiledStackedTemplate _value,
      $Res Function(_CompiledStackedTemplate) _then)
      : super(_value, (v) => _then(v as _CompiledStackedTemplate));

  @override
  _CompiledStackedTemplate get _value =>
      super._value as _CompiledStackedTemplate;

  @override
  $Res call({
    Object? templateName = freezed,
    Object? templateFiles = freezed,
    Object? fileModifications = freezed,
  }) {
    return _then(_CompiledStackedTemplate(
      templateName: templateName == freezed
          ? _value.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      templateFiles: templateFiles == freezed
          ? _value.templateFiles
          : templateFiles // ignore: cast_nullable_to_non_nullable
              as List<CompliledTemplateFile>,
      fileModifications: fileModifications == freezed
          ? _value.fileModifications
          : fileModifications // ignore: cast_nullable_to_non_nullable
              as List<CompiledFileModification>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CompiledStackedTemplate implements _CompiledStackedTemplate {
  _$_CompiledStackedTemplate(
      {required this.templateName,
      required this.templateFiles,
      this.fileModifications = const []});

  factory _$_CompiledStackedTemplate.fromJson(Map<String, dynamic> json) =>
      _$$_CompiledStackedTemplateFromJson(json);

  @override
  final String templateName;
  @override
  final List<CompliledTemplateFile> templateFiles;
  @JsonKey()
  @override
  final List<CompiledFileModification> fileModifications;

  @override
  String toString() {
    return 'CompiledStackedTemplate(templateName: $templateName, templateFiles: $templateFiles, fileModifications: $fileModifications)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledStackedTemplate &&
            const DeepCollectionEquality()
                .equals(other.templateName, templateName) &&
            const DeepCollectionEquality()
                .equals(other.templateFiles, templateFiles) &&
            const DeepCollectionEquality()
                .equals(other.fileModifications, fileModifications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(templateName),
      const DeepCollectionEquality().hash(templateFiles),
      const DeepCollectionEquality().hash(fileModifications));

  @JsonKey(ignore: true)
  @override
  _$CompiledStackedTemplateCopyWith<_CompiledStackedTemplate> get copyWith =>
      __$CompiledStackedTemplateCopyWithImpl<_CompiledStackedTemplate>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompiledStackedTemplateToJson(this);
  }
}

abstract class _CompiledStackedTemplate implements CompiledStackedTemplate {
  factory _CompiledStackedTemplate(
          {required String templateName,
          required List<CompliledTemplateFile> templateFiles,
          List<CompiledFileModification> fileModifications}) =
      _$_CompiledStackedTemplate;

  factory _CompiledStackedTemplate.fromJson(Map<String, dynamic> json) =
      _$_CompiledStackedTemplate.fromJson;

  @override
  String get templateName;
  @override
  List<CompliledTemplateFile> get templateFiles;
  @override
  List<CompiledFileModification> get fileModifications;
  @override
  @JsonKey(ignore: true)
  _$CompiledStackedTemplateCopyWith<_CompiledStackedTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

CompiledFileModification _$CompiledFileModificationFromJson(
    Map<String, dynamic> json) {
  return _CompiledFileModification.fromJson(json);
}

/// @nodoc
class _$CompiledFileModificationTearOff {
  const _$CompiledFileModificationTearOff();

  _CompiledFileModification call(
      {required String modificationPath,
      required String modificationIndentifier,
      required String modificationTemplate,
      required String modificationErrorMessage}) {
    return _CompiledFileModification(
      modificationPath: modificationPath,
      modificationIndentifier: modificationIndentifier,
      modificationTemplate: modificationTemplate,
      modificationErrorMessage: modificationErrorMessage,
    );
  }

  CompiledFileModification fromJson(Map<String, Object?> json) {
    return CompiledFileModification.fromJson(json);
  }
}

/// @nodoc
const $CompiledFileModification = _$CompiledFileModificationTearOff();

/// @nodoc
mixin _$CompiledFileModification {
  /// The relative path to the file that needs to be modified
  String get modificationPath => throw _privateConstructorUsedError;

  /// The identifier to use to determine location of modifications
  String get modificationIndentifier => throw _privateConstructorUsedError;

  /// The mustache template to use when rendering the modification
  String get modificationTemplate => throw _privateConstructorUsedError;

  /// The message to show the user of the cli if the modification fails
  String get modificationErrorMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompiledFileModificationCopyWith<CompiledFileModification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompiledFileModificationCopyWith<$Res> {
  factory $CompiledFileModificationCopyWith(CompiledFileModification value,
          $Res Function(CompiledFileModification) then) =
      _$CompiledFileModificationCopyWithImpl<$Res>;
  $Res call(
      {String modificationPath,
      String modificationIndentifier,
      String modificationTemplate,
      String modificationErrorMessage});
}

/// @nodoc
class _$CompiledFileModificationCopyWithImpl<$Res>
    implements $CompiledFileModificationCopyWith<$Res> {
  _$CompiledFileModificationCopyWithImpl(this._value, this._then);

  final CompiledFileModification _value;
  // ignore: unused_field
  final $Res Function(CompiledFileModification) _then;

  @override
  $Res call({
    Object? modificationPath = freezed,
    Object? modificationIndentifier = freezed,
    Object? modificationTemplate = freezed,
    Object? modificationErrorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      modificationPath: modificationPath == freezed
          ? _value.modificationPath
          : modificationPath // ignore: cast_nullable_to_non_nullable
              as String,
      modificationIndentifier: modificationIndentifier == freezed
          ? _value.modificationIndentifier
          : modificationIndentifier // ignore: cast_nullable_to_non_nullable
              as String,
      modificationTemplate: modificationTemplate == freezed
          ? _value.modificationTemplate
          : modificationTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      modificationErrorMessage: modificationErrorMessage == freezed
          ? _value.modificationErrorMessage
          : modificationErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CompiledFileModificationCopyWith<$Res>
    implements $CompiledFileModificationCopyWith<$Res> {
  factory _$CompiledFileModificationCopyWith(_CompiledFileModification value,
          $Res Function(_CompiledFileModification) then) =
      __$CompiledFileModificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String modificationPath,
      String modificationIndentifier,
      String modificationTemplate,
      String modificationErrorMessage});
}

/// @nodoc
class __$CompiledFileModificationCopyWithImpl<$Res>
    extends _$CompiledFileModificationCopyWithImpl<$Res>
    implements _$CompiledFileModificationCopyWith<$Res> {
  __$CompiledFileModificationCopyWithImpl(_CompiledFileModification _value,
      $Res Function(_CompiledFileModification) _then)
      : super(_value, (v) => _then(v as _CompiledFileModification));

  @override
  _CompiledFileModification get _value =>
      super._value as _CompiledFileModification;

  @override
  $Res call({
    Object? modificationPath = freezed,
    Object? modificationIndentifier = freezed,
    Object? modificationTemplate = freezed,
    Object? modificationErrorMessage = freezed,
  }) {
    return _then(_CompiledFileModification(
      modificationPath: modificationPath == freezed
          ? _value.modificationPath
          : modificationPath // ignore: cast_nullable_to_non_nullable
              as String,
      modificationIndentifier: modificationIndentifier == freezed
          ? _value.modificationIndentifier
          : modificationIndentifier // ignore: cast_nullable_to_non_nullable
              as String,
      modificationTemplate: modificationTemplate == freezed
          ? _value.modificationTemplate
          : modificationTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      modificationErrorMessage: modificationErrorMessage == freezed
          ? _value.modificationErrorMessage
          : modificationErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CompiledFileModification implements _CompiledFileModification {
  _$_CompiledFileModification(
      {required this.modificationPath,
      required this.modificationIndentifier,
      required this.modificationTemplate,
      required this.modificationErrorMessage});

  factory _$_CompiledFileModification.fromJson(Map<String, dynamic> json) =>
      _$$_CompiledFileModificationFromJson(json);

  @override

  /// The relative path to the file that needs to be modified
  final String modificationPath;
  @override

  /// The identifier to use to determine location of modifications
  final String modificationIndentifier;
  @override

  /// The mustache template to use when rendering the modification
  final String modificationTemplate;
  @override

  /// The message to show the user of the cli if the modification fails
  final String modificationErrorMessage;

  @override
  String toString() {
    return 'CompiledFileModification(modificationPath: $modificationPath, modificationIndentifier: $modificationIndentifier, modificationTemplate: $modificationTemplate, modificationErrorMessage: $modificationErrorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledFileModification &&
            const DeepCollectionEquality()
                .equals(other.modificationPath, modificationPath) &&
            const DeepCollectionEquality().equals(
                other.modificationIndentifier, modificationIndentifier) &&
            const DeepCollectionEquality()
                .equals(other.modificationTemplate, modificationTemplate) &&
            const DeepCollectionEquality().equals(
                other.modificationErrorMessage, modificationErrorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(modificationPath),
      const DeepCollectionEquality().hash(modificationIndentifier),
      const DeepCollectionEquality().hash(modificationTemplate),
      const DeepCollectionEquality().hash(modificationErrorMessage));

  @JsonKey(ignore: true)
  @override
  _$CompiledFileModificationCopyWith<_CompiledFileModification> get copyWith =>
      __$CompiledFileModificationCopyWithImpl<_CompiledFileModification>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompiledFileModificationToJson(this);
  }
}

abstract class _CompiledFileModification implements CompiledFileModification {
  factory _CompiledFileModification(
      {required String modificationPath,
      required String modificationIndentifier,
      required String modificationTemplate,
      required String modificationErrorMessage}) = _$_CompiledFileModification;

  factory _CompiledFileModification.fromJson(Map<String, dynamic> json) =
      _$_CompiledFileModification.fromJson;

  @override

  /// The relative path to the file that needs to be modified
  String get modificationPath;
  @override

  /// The identifier to use to determine location of modifications
  String get modificationIndentifier;
  @override

  /// The mustache template to use when rendering the modification
  String get modificationTemplate;
  @override

  /// The message to show the user of the cli if the modification fails
  String get modificationErrorMessage;
  @override
  @JsonKey(ignore: true)
  _$CompiledFileModificationCopyWith<_CompiledFileModification> get copyWith =>
      throw _privateConstructorUsedError;
}
