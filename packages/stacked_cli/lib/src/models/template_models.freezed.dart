// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$CompliledTemplateFileCopyWithImpl<$Res, CompliledTemplateFile>;
  @useResult
  $Res call({String name, String fileName, String path, String content});
}

/// @nodoc
class _$CompliledTemplateFileCopyWithImpl<$Res,
        $Val extends CompliledTemplateFile>
    implements $CompliledTemplateFileCopyWith<$Res> {
  _$CompliledTemplateFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fileName = null,
    Object? path = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompliledTemplateFileCopyWith<$Res>
    implements $CompliledTemplateFileCopyWith<$Res> {
  factory _$$_CompliledTemplateFileCopyWith(_$_CompliledTemplateFile value,
          $Res Function(_$_CompliledTemplateFile) then) =
      __$$_CompliledTemplateFileCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String fileName, String path, String content});
}

/// @nodoc
class __$$_CompliledTemplateFileCopyWithImpl<$Res>
    extends _$CompliledTemplateFileCopyWithImpl<$Res, _$_CompliledTemplateFile>
    implements _$$_CompliledTemplateFileCopyWith<$Res> {
  __$$_CompliledTemplateFileCopyWithImpl(_$_CompliledTemplateFile _value,
      $Res Function(_$_CompliledTemplateFile) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fileName = null,
    Object? path = null,
    Object? content = null,
  }) {
    return _then(_$_CompliledTemplateFile(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
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
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, fileName, path, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      _$CompiledStackedTemplateCopyWithImpl<$Res, CompiledStackedTemplate>;
  @useResult
  $Res call(
      {String name,
      List<CompliledTemplateFile> templateFiles,
      List<CompiledFileModification> modificationFiles});
}

/// @nodoc
class _$CompiledStackedTemplateCopyWithImpl<$Res,
        $Val extends CompiledStackedTemplate>
    implements $CompiledStackedTemplateCopyWith<$Res> {
  _$CompiledStackedTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? templateFiles = null,
    Object? modificationFiles = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templateFiles: null == templateFiles
          ? _value.templateFiles
          : templateFiles // ignore: cast_nullable_to_non_nullable
              as List<CompliledTemplateFile>,
      modificationFiles: null == modificationFiles
          ? _value.modificationFiles
          : modificationFiles // ignore: cast_nullable_to_non_nullable
              as List<CompiledFileModification>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompiledStackedTemplateCopyWith<$Res>
    implements $CompiledStackedTemplateCopyWith<$Res> {
  factory _$$_CompiledStackedTemplateCopyWith(_$_CompiledStackedTemplate value,
          $Res Function(_$_CompiledStackedTemplate) then) =
      __$$_CompiledStackedTemplateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      List<CompliledTemplateFile> templateFiles,
      List<CompiledFileModification> modificationFiles});
}

/// @nodoc
class __$$_CompiledStackedTemplateCopyWithImpl<$Res>
    extends _$CompiledStackedTemplateCopyWithImpl<$Res,
        _$_CompiledStackedTemplate>
    implements _$$_CompiledStackedTemplateCopyWith<$Res> {
  __$$_CompiledStackedTemplateCopyWithImpl(_$_CompiledStackedTemplate _value,
      $Res Function(_$_CompiledStackedTemplate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? templateFiles = null,
    Object? modificationFiles = null,
  }) {
    return _then(_$_CompiledStackedTemplate(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      templateFiles: null == templateFiles
          ? _value._templateFiles
          : templateFiles // ignore: cast_nullable_to_non_nullable
              as List<CompliledTemplateFile>,
      modificationFiles: null == modificationFiles
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
    if (_templateFiles is EqualUnmodifiableListView) return _templateFiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_templateFiles);
  }

  final List<CompiledFileModification> _modificationFiles;
  @override
  @JsonKey()
  List<CompiledFileModification> get modificationFiles {
    if (_modificationFiles is EqualUnmodifiableListView)
      return _modificationFiles;
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
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._templateFiles, _templateFiles) &&
            const DeepCollectionEquality()
                .equals(other._modificationFiles, _modificationFiles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_templateFiles),
      const DeepCollectionEquality().hash(_modificationFiles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      _$CompiledFileModificationCopyWithImpl<$Res, CompiledFileModification>;
  @useResult
  $Res call(
      {String description,
      String path,
      String identifier,
      String template,
      String error,
      String name});
}

/// @nodoc
class _$CompiledFileModificationCopyWithImpl<$Res,
        $Val extends CompiledFileModification>
    implements $CompiledFileModificationCopyWith<$Res> {
  _$CompiledFileModificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? path = null,
    Object? identifier = null,
    Object? template = null,
    Object? error = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
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
  @useResult
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
    extends _$CompiledFileModificationCopyWithImpl<$Res,
        _$_CompiledFileModification>
    implements _$$_CompiledFileModificationCopyWith<$Res> {
  __$$_CompiledFileModificationCopyWithImpl(_$_CompiledFileModification _value,
      $Res Function(_$_CompiledFileModification) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? path = null,
    Object? identifier = null,
    Object? template = null,
    Object? error = null,
    Object? name = null,
  }) {
    return _then(_$_CompiledFileModification(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
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
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.template, template) ||
                other.template == template) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, description, path, identifier, template, error, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
