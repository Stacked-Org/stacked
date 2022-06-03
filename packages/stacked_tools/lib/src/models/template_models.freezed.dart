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

CompiledTemplateFile _$CompiledTemplateFileFromJson(Map<String, dynamic> json) {
  return _CompiledTemplateFile.fromJson(json);
}

/// @nodoc
class _$CompiledTemplateFileTearOff {
  const _$CompiledTemplateFileTearOff();

  _CompiledTemplateFile call(
      {required String name,
      required String fileName,
      required String path,
      required String content}) {
    return _CompiledTemplateFile(
      name: name,
      fileName: fileName,
      path: path,
      content: content,
    );
  }

  CompiledTemplateFile fromJson(Map<String, Object?> json) {
    return CompiledTemplateFile.fromJson(json);
  }
}

/// @nodoc
const $CompiledTemplateFile = _$CompiledTemplateFileTearOff();

/// @nodoc
mixin _$CompiledTemplateFile {
  /// Pascal case name of the template this file belongs too
  String get name => throw _privateConstructorUsedError;

  /// Pascal case name of the file without the extension
  String get fileName => throw _privateConstructorUsedError;

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  String get path => throw _privateConstructorUsedError;

  /// The content as is from the file that was read
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompiledTemplateFileCopyWith<CompiledTemplateFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompiledTemplateFileCopyWith<$Res> {
  factory $CompiledTemplateFileCopyWith(CompiledTemplateFile value,
          $Res Function(CompiledTemplateFile) then) =
      _$CompiledTemplateFileCopyWithImpl<$Res>;
  $Res call({String name, String fileName, String path, String content});
}

/// @nodoc
class _$CompiledTemplateFileCopyWithImpl<$Res>
    implements $CompiledTemplateFileCopyWith<$Res> {
  _$CompiledTemplateFileCopyWithImpl(this._value, this._then);

  final CompiledTemplateFile _value;
  // ignore: unused_field
  final $Res Function(CompiledTemplateFile) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? fileName = freezed,
    Object? path = freezed,
    Object? content = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: fileName == freezed
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CompiledTemplateFileCopyWith<$Res>
    implements $CompiledTemplateFileCopyWith<$Res> {
  factory _$CompiledTemplateFileCopyWith(_CompiledTemplateFile value,
          $Res Function(_CompiledTemplateFile) then) =
      __$CompiledTemplateFileCopyWithImpl<$Res>;
  @override
  $Res call({String name, String fileName, String path, String content});
}

/// @nodoc
class __$CompiledTemplateFileCopyWithImpl<$Res>
    extends _$CompiledTemplateFileCopyWithImpl<$Res>
    implements _$CompiledTemplateFileCopyWith<$Res> {
  __$CompiledTemplateFileCopyWithImpl(
      _CompiledTemplateFile _value, $Res Function(_CompiledTemplateFile) _then)
      : super(_value, (v) => _then(v as _CompiledTemplateFile));

  @override
  _CompiledTemplateFile get _value => super._value as _CompiledTemplateFile;

  @override
  $Res call({
    Object? name = freezed,
    Object? fileName = freezed,
    Object? path = freezed,
    Object? content = freezed,
  }) {
    return _then(_CompiledTemplateFile(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: fileName == freezed
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CompiledTemplateFile implements _CompiledTemplateFile {
  _$_CompiledTemplateFile(
      {required this.name,
      required this.fileName,
      required this.path,
      required this.content});

  factory _$_CompiledTemplateFile.fromJson(Map<String, dynamic> json) =>
      _$$_CompiledTemplateFileFromJson(json);

  @override

  /// Pascal case name of the template this file belongs too
  final String name;
  @override

  /// Pascal case name of the file without the extension
  final String fileName;
  @override

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  final String path;
  @override

  /// The content as is from the file that was read
  final String content;

  @override
  String toString() {
    return 'CompiledTemplateFile(name: $name, fileName: $fileName, path: $path, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledTemplateFile &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.fileName, fileName) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.content, content));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(fileName),
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(content));

  @JsonKey(ignore: true)
  @override
  _$CompiledTemplateFileCopyWith<_CompiledTemplateFile> get copyWith =>
      __$CompiledTemplateFileCopyWithImpl<_CompiledTemplateFile>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompiledTemplateFileToJson(this);
  }
}

abstract class _CompiledTemplateFile implements CompiledTemplateFile {
  factory _CompiledTemplateFile(
      {required String name,
      required String fileName,
      required String path,
      required String content}) = _$_CompiledTemplateFile;

  factory _CompiledTemplateFile.fromJson(Map<String, dynamic> json) =
      _$_CompiledTemplateFile.fromJson;

  @override

  /// Pascal case name of the template this file belongs too
  String get name;
  @override

  /// Pascal case name of the file without the extension
  String get fileName;
  @override

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  String get path;
  @override

  /// The content as is from the file that was read
  String get content;
  @override
  @JsonKey(ignore: true)
  _$CompiledTemplateFileCopyWith<_CompiledTemplateFile> get copyWith =>
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
      {required String name,
      required List<CompiledTemplateFile> templateFiles,
      List<CompiledFileModification> modificationFiles = const []}) {
    return _CompiledStackedTemplate(
      name: name,
      templateFiles: templateFiles,
      modificationFiles: modificationFiles,
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
  String get name => throw _privateConstructorUsedError;
  List<CompiledTemplateFile> get templateFiles =>
      throw _privateConstructorUsedError;
  List<CompiledFileModification> get modificationFiles =>
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
      {String name,
      List<CompiledTemplateFile> templateFiles,
      List<CompiledFileModification> modificationFiles});
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
    Object? name = freezed,
    Object? templateFiles = freezed,
    Object? modificationFiles = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templateFiles: templateFiles == freezed
          ? _value.templateFiles
          : templateFiles // ignore: cast_nullable_to_non_nullable
              as List<CompiledTemplateFile>,
      modificationFiles: modificationFiles == freezed
          ? _value.modificationFiles
          : modificationFiles // ignore: cast_nullable_to_non_nullable
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
      {String name,
      List<CompiledTemplateFile> templateFiles,
      List<CompiledFileModification> modificationFiles});
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
    Object? name = freezed,
    Object? templateFiles = freezed,
    Object? modificationFiles = freezed,
  }) {
    return _then(_CompiledStackedTemplate(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templateFiles: templateFiles == freezed
          ? _value.templateFiles
          : templateFiles // ignore: cast_nullable_to_non_nullable
              as List<CompiledTemplateFile>,
      modificationFiles: modificationFiles == freezed
          ? _value.modificationFiles
          : modificationFiles // ignore: cast_nullable_to_non_nullable
              as List<CompiledFileModification>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CompiledStackedTemplate implements _CompiledStackedTemplate {
  _$_CompiledStackedTemplate(
      {required this.name,
      required this.templateFiles,
      this.modificationFiles = const []});

  factory _$_CompiledStackedTemplate.fromJson(Map<String, dynamic> json) =>
      _$$_CompiledStackedTemplateFromJson(json);

  @override
  final String name;
  @override
  final List<CompiledTemplateFile> templateFiles;
  @JsonKey()
  @override
  final List<CompiledFileModification> modificationFiles;

  @override
  String toString() {
    return 'CompiledStackedTemplate(name: $name, templateFiles: $templateFiles, modificationFiles: $modificationFiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledStackedTemplate &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.templateFiles, templateFiles) &&
            const DeepCollectionEquality()
                .equals(other.modificationFiles, modificationFiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(templateFiles),
      const DeepCollectionEquality().hash(modificationFiles));

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
          {required String name,
          required List<CompiledTemplateFile> templateFiles,
          List<CompiledFileModification> modificationFiles}) =
      _$_CompiledStackedTemplate;

  factory _CompiledStackedTemplate.fromJson(Map<String, dynamic> json) =
      _$_CompiledStackedTemplate.fromJson;

  @override
  String get name;
  @override
  List<CompiledTemplateFile> get templateFiles;
  @override
  List<CompiledFileModification> get modificationFiles;
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
      {required String description,
      required String path,
      required String identifier,
      required String template,
      required String error,
      required String name}) {
    return _CompiledFileModification(
      description: description,
      path: path,
      identifier: identifier,
      template: template,
      error: error,
      name: name,
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
  /// A short description for what this modification does
  String get description => throw _privateConstructorUsedError;

  /// The relative path to the file that needs to be modified
  String get path => throw _privateConstructorUsedError;

  /// The identifier to use to determine location of modifications
  String get identifier => throw _privateConstructorUsedError;

  /// The mustache template to use when rendering the modification
  String get template => throw _privateConstructorUsedError;

  /// The message to show the user of the cli if the modification fails
  String get error => throw _privateConstructorUsedError;

  /// The message to show the user of the cli if the modification succeeds
  String get name => throw _privateConstructorUsedError;

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
      {String description,
      String path,
      String identifier,
      String template,
      String error,
      String name});
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
    Object? description = freezed,
    Object? path = freezed,
    Object? identifier = freezed,
    Object? template = freezed,
    Object? error = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      template: template == freezed
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
      {String description,
      String path,
      String identifier,
      String template,
      String error,
      String name});
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
    Object? description = freezed,
    Object? path = freezed,
    Object? identifier = freezed,
    Object? template = freezed,
    Object? error = freezed,
    Object? name = freezed,
  }) {
    return _then(_CompiledFileModification(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: identifier == freezed
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      template: template == freezed
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CompiledFileModification implements _CompiledFileModification {
  _$_CompiledFileModification(
      {required this.description,
      required this.path,
      required this.identifier,
      required this.template,
      required this.error,
      required this.name});

  factory _$_CompiledFileModification.fromJson(Map<String, dynamic> json) =>
      _$$_CompiledFileModificationFromJson(json);

  @override

  /// A short description for what this modification does
  final String description;
  @override

  /// The relative path to the file that needs to be modified
  final String path;
  @override

  /// The identifier to use to determine location of modifications
  final String identifier;
  @override

  /// The mustache template to use when rendering the modification
  final String template;
  @override

  /// The message to show the user of the cli if the modification fails
  final String error;
  @override

  /// The message to show the user of the cli if the modification succeeds
  final String name;

  @override
  String toString() {
    return 'CompiledFileModification(description: $description, path: $path, identifier: $identifier, template: $template, error: $error, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompiledFileModification &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality()
                .equals(other.identifier, identifier) &&
            const DeepCollectionEquality().equals(other.template, template) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(identifier),
      const DeepCollectionEquality().hash(template),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(name));

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
      {required String description,
      required String path,
      required String identifier,
      required String template,
      required String error,
      required String name}) = _$_CompiledFileModification;

  factory _CompiledFileModification.fromJson(Map<String, dynamic> json) =
      _$_CompiledFileModification.fromJson;

  @override

  /// A short description for what this modification does
  String get description;
  @override

  /// The relative path to the file that needs to be modified
  String get path;
  @override

  /// The identifier to use to determine location of modifications
  String get identifier;
  @override

  /// The mustache template to use when rendering the modification
  String get template;
  @override

  /// The message to show the user of the cli if the modification fails
  String get error;
  @override

  /// The message to show the user of the cli if the modification succeeds
  String get name;
  @override
  @JsonKey(ignore: true)
  _$CompiledFileModificationCopyWith<_CompiledFileModification> get copyWith =>
      throw _privateConstructorUsedError;
}
