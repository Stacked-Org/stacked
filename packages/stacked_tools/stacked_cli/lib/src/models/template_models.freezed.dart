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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CompliledTemplateFile _$CompliledTemplateFileFromJson(
    Map<String, dynamic> json) {
  return _CompliledTemplateFile.fromJson(json);
}

/// @nodoc
mixin _$CompliledTemplateFile {
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
  $CompliledTemplateFileCopyWith<CompliledTemplateFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompliledTemplateFileCopyWith<$Res> {
  factory $CompliledTemplateFileCopyWith(CompliledTemplateFile value,
          $Res Function(CompliledTemplateFile) then) =
      _$CompliledTemplateFileCopyWithImpl<$Res>;
  $Res call({String name, String fileName, String path, String content});
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
abstract class _$$_CompliledTemplateFileCopyWith<$Res>
    implements $CompliledTemplateFileCopyWith<$Res> {
  factory _$$_CompliledTemplateFileCopyWith(_$_CompliledTemplateFile value,
          $Res Function(_$_CompliledTemplateFile) then) =
      __$$_CompliledTemplateFileCopyWithImpl<$Res>;
  @override
  $Res call({String name, String fileName, String path, String content});
}

/// @nodoc
class __$$_CompliledTemplateFileCopyWithImpl<$Res>
    extends _$CompliledTemplateFileCopyWithImpl<$Res>
    implements _$$_CompliledTemplateFileCopyWith<$Res> {
  __$$_CompliledTemplateFileCopyWithImpl(_$_CompliledTemplateFile _value,
      $Res Function(_$_CompliledTemplateFile) _then)
      : super(_value, (v) => _then(v as _$_CompliledTemplateFile));

  @override
  _$_CompliledTemplateFile get _value =>
      super._value as _$_CompliledTemplateFile;

  @override
  $Res call({
    Object? name = freezed,
    Object? fileName = freezed,
    Object? path = freezed,
    Object? content = freezed,
  }) {
    return _then(_$_CompliledTemplateFile(
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
class _$_CompliledTemplateFile implements _CompliledTemplateFile {
  _$_CompliledTemplateFile(
      {required this.name,
      required this.fileName,
      required this.path,
      required this.content});

  factory _$_CompliledTemplateFile.fromJson(Map<String, dynamic> json) =>
      _$$_CompliledTemplateFileFromJson(json);

  /// Pascal case name of the template this file belongs too
  @override
  final String name;

  /// Pascal case name of the file without the extension
  @override
  final String fileName;

  /// Relative file path from the template in the templates folder
  /// .i.e. from we don't include template/view/
  @override
  final String path;

  /// The content as is from the file that was read
  @override
  final String content;

  @override
  String toString() {
    return 'CompliledTemplateFile(name: $name, fileName: $fileName, path: $path, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompliledTemplateFile &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.fileName, fileName) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.content, content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(fileName),
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(content));

  @JsonKey(ignore: true)
  @override
  _$$_CompliledTemplateFileCopyWith<_$_CompliledTemplateFile> get copyWith =>
      __$$_CompliledTemplateFileCopyWithImpl<_$_CompliledTemplateFile>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompliledTemplateFileToJson(
      this,
    );
  }
}

abstract class _CompliledTemplateFile implements CompliledTemplateFile {
  factory _CompliledTemplateFile(
      {required final String name,
      required final String fileName,
      required final String path,
      required final String content}) = _$_CompliledTemplateFile;

  factory _CompliledTemplateFile.fromJson(Map<String, dynamic> json) =
      _$_CompliledTemplateFile.fromJson;

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
  _$$_CompliledTemplateFileCopyWith<_$_CompliledTemplateFile> get copyWith =>
      throw _privateConstructorUsedError;
}

CompiledStackedTemplate _$CompiledStackedTemplateFromJson(
    Map<String, dynamic> json) {
  return _CompiledStackedTemplate.fromJson(json);
}

/// @nodoc
mixin _$CompiledStackedTemplate {
  String get name => throw _privateConstructorUsedError;
  List<CompliledTemplateFile> get templateFiles =>
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
      List<CompliledTemplateFile> templateFiles,
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
              as List<CompliledTemplateFile>,
      modificationFiles: modificationFiles == freezed
          ? _value.modificationFiles
          : modificationFiles // ignore: cast_nullable_to_non_nullable
              as List<CompiledFileModification>,
    ));
  }
}

/// @nodoc
abstract class _$$_CompiledStackedTemplateCopyWith<$Res>
    implements $CompiledStackedTemplateCopyWith<$Res> {
  factory _$$_CompiledStackedTemplateCopyWith(_$_CompiledStackedTemplate value,
          $Res Function(_$_CompiledStackedTemplate) then) =
      __$$_CompiledStackedTemplateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      List<CompliledTemplateFile> templateFiles,
      List<CompiledFileModification> modificationFiles});
}

/// @nodoc
class __$$_CompiledStackedTemplateCopyWithImpl<$Res>
    extends _$CompiledStackedTemplateCopyWithImpl<$Res>
    implements _$$_CompiledStackedTemplateCopyWith<$Res> {
  __$$_CompiledStackedTemplateCopyWithImpl(_$_CompiledStackedTemplate _value,
      $Res Function(_$_CompiledStackedTemplate) _then)
      : super(_value, (v) => _then(v as _$_CompiledStackedTemplate));

  @override
  _$_CompiledStackedTemplate get _value =>
      super._value as _$_CompiledStackedTemplate;

  @override
  $Res call({
    Object? name = freezed,
    Object? templateFiles = freezed,
    Object? modificationFiles = freezed,
  }) {
    return _then(_$_CompiledStackedTemplate(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templateFiles: templateFiles == freezed
          ? _value._templateFiles
          : templateFiles // ignore: cast_nullable_to_non_nullable
              as List<CompliledTemplateFile>,
      modificationFiles: modificationFiles == freezed
          ? _value._modificationFiles
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
      required final List<CompliledTemplateFile> templateFiles,
      final List<CompiledFileModification> modificationFiles = const []})
      : _templateFiles = templateFiles,
        _modificationFiles = modificationFiles;

  factory _$_CompiledStackedTemplate.fromJson(Map<String, dynamic> json) =>
      _$$_CompiledStackedTemplateFromJson(json);

  @override
  final String name;
  final List<CompliledTemplateFile> _templateFiles;
  @override
  List<CompliledTemplateFile> get templateFiles {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templateFiles);
  }

  final List<CompiledFileModification> _modificationFiles;
  @override
  @JsonKey()
  List<CompiledFileModification> get modificationFiles {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modificationFiles);
  }

  @override
  String toString() {
    return 'CompiledStackedTemplate(name: $name, templateFiles: $templateFiles, modificationFiles: $modificationFiles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompiledStackedTemplate &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other._templateFiles, _templateFiles) &&
            const DeepCollectionEquality()
                .equals(other._modificationFiles, _modificationFiles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(_templateFiles),
      const DeepCollectionEquality().hash(_modificationFiles));

  @JsonKey(ignore: true)
  @override
  _$$_CompiledStackedTemplateCopyWith<_$_CompiledStackedTemplate>
      get copyWith =>
          __$$_CompiledStackedTemplateCopyWithImpl<_$_CompiledStackedTemplate>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompiledStackedTemplateToJson(
      this,
    );
  }
}

abstract class _CompiledStackedTemplate implements CompiledStackedTemplate {
  factory _CompiledStackedTemplate(
          {required final String name,
          required final List<CompliledTemplateFile> templateFiles,
          final List<CompiledFileModification> modificationFiles}) =
      _$_CompiledStackedTemplate;

  factory _CompiledStackedTemplate.fromJson(Map<String, dynamic> json) =
      _$_CompiledStackedTemplate.fromJson;

  @override
  String get name;
  @override
  List<CompliledTemplateFile> get templateFiles;
  @override
  List<CompiledFileModification> get modificationFiles;
  @override
  @JsonKey(ignore: true)
  _$$_CompiledStackedTemplateCopyWith<_$_CompiledStackedTemplate>
      get copyWith => throw _privateConstructorUsedError;
}

CompiledFileModification _$CompiledFileModificationFromJson(
    Map<String, dynamic> json) {
  return _CompiledFileModification.fromJson(json);
}

/// @nodoc
mixin _$CompiledFileModification {
  /// A short description for what this modiciation does
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
abstract class _$$_CompiledFileModificationCopyWith<$Res>
    implements $CompiledFileModificationCopyWith<$Res> {
  factory _$$_CompiledFileModificationCopyWith(
          _$_CompiledFileModification value,
          $Res Function(_$_CompiledFileModification) then) =
      __$$_CompiledFileModificationCopyWithImpl<$Res>;
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
class __$$_CompiledFileModificationCopyWithImpl<$Res>
    extends _$CompiledFileModificationCopyWithImpl<$Res>
    implements _$$_CompiledFileModificationCopyWith<$Res> {
  __$$_CompiledFileModificationCopyWithImpl(_$_CompiledFileModification _value,
      $Res Function(_$_CompiledFileModification) _then)
      : super(_value, (v) => _then(v as _$_CompiledFileModification));

  @override
  _$_CompiledFileModification get _value =>
      super._value as _$_CompiledFileModification;

  @override
  $Res call({
    Object? description = freezed,
    Object? path = freezed,
    Object? identifier = freezed,
    Object? template = freezed,
    Object? error = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_CompiledFileModification(
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

  /// A short description for what this modiciation does
  @override
  final String description;

  /// The relative path to the file that needs to be modified
  @override
  final String path;

  /// The identifier to use to determine location of modifications
  @override
  final String identifier;

  /// The mustache template to use when rendering the modification
  @override
  final String template;

  /// The message to show the user of the cli if the modification fails
  @override
  final String error;

  /// The message to show the user of the cli if the modification succeeds
  @override
  final String name;

  @override
  String toString() {
    return 'CompiledFileModification(description: $description, path: $path, identifier: $identifier, template: $template, error: $error, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompiledFileModification &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality()
                .equals(other.identifier, identifier) &&
            const DeepCollectionEquality().equals(other.template, template) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
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
  _$$_CompiledFileModificationCopyWith<_$_CompiledFileModification>
      get copyWith => __$$_CompiledFileModificationCopyWithImpl<
          _$_CompiledFileModification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompiledFileModificationToJson(
      this,
    );
  }
}

abstract class _CompiledFileModification implements CompiledFileModification {
  factory _CompiledFileModification(
      {required final String description,
      required final String path,
      required final String identifier,
      required final String template,
      required final String error,
      required final String name}) = _$_CompiledFileModification;

  factory _CompiledFileModification.fromJson(Map<String, dynamic> json) =
      _$_CompiledFileModification.fromJson;

  @override

  /// A short description for what this modiciation does
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
  _$$_CompiledFileModificationCopyWith<_$_CompiledFileModification>
      get copyWith => throw _privateConstructorUsedError;
}
