// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'template_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TemplateItem _$TemplateItemFromJson(Map<String, dynamic> json) {
  return _TemplateItem.fromJson(json);
}

/// @nodoc
class _$TemplateItemTearOff {
  const _$TemplateItemTearOff();

  _TemplateItem call(
      {required String templateName,
      required String templateFileName,
      required String templateFilePath,
      required String templateFileContent}) {
    return _TemplateItem(
      templateName: templateName,
      templateFileName: templateFileName,
      templateFilePath: templateFilePath,
      templateFileContent: templateFileContent,
    );
  }

  TemplateItem fromJson(Map<String, Object?> json) {
    return TemplateItem.fromJson(json);
  }
}

/// @nodoc
const $TemplateItem = _$TemplateItemTearOff();

/// @nodoc
mixin _$TemplateItem {
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
  $TemplateItemCopyWith<TemplateItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemplateItemCopyWith<$Res> {
  factory $TemplateItemCopyWith(
          TemplateItem value, $Res Function(TemplateItem) then) =
      _$TemplateItemCopyWithImpl<$Res>;
  $Res call(
      {String templateName,
      String templateFileName,
      String templateFilePath,
      String templateFileContent});
}

/// @nodoc
class _$TemplateItemCopyWithImpl<$Res> implements $TemplateItemCopyWith<$Res> {
  _$TemplateItemCopyWithImpl(this._value, this._then);

  final TemplateItem _value;
  // ignore: unused_field
  final $Res Function(TemplateItem) _then;

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
abstract class _$TemplateItemCopyWith<$Res>
    implements $TemplateItemCopyWith<$Res> {
  factory _$TemplateItemCopyWith(
          _TemplateItem value, $Res Function(_TemplateItem) then) =
      __$TemplateItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {String templateName,
      String templateFileName,
      String templateFilePath,
      String templateFileContent});
}

/// @nodoc
class __$TemplateItemCopyWithImpl<$Res> extends _$TemplateItemCopyWithImpl<$Res>
    implements _$TemplateItemCopyWith<$Res> {
  __$TemplateItemCopyWithImpl(
      _TemplateItem _value, $Res Function(_TemplateItem) _then)
      : super(_value, (v) => _then(v as _TemplateItem));

  @override
  _TemplateItem get _value => super._value as _TemplateItem;

  @override
  $Res call({
    Object? templateName = freezed,
    Object? templateFileName = freezed,
    Object? templateFilePath = freezed,
    Object? templateFileContent = freezed,
  }) {
    return _then(_TemplateItem(
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
class _$_TemplateItem implements _TemplateItem {
  _$_TemplateItem(
      {required this.templateName,
      required this.templateFileName,
      required this.templateFilePath,
      required this.templateFileContent});

  factory _$_TemplateItem.fromJson(Map<String, dynamic> json) =>
      _$$_TemplateItemFromJson(json);

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
    return 'TemplateItem(templateName: $templateName, templateFileName: $templateFileName, templateFilePath: $templateFilePath, templateFileContent: $templateFileContent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TemplateItem &&
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
  _$TemplateItemCopyWith<_TemplateItem> get copyWith =>
      __$TemplateItemCopyWithImpl<_TemplateItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TemplateItemToJson(this);
  }
}

abstract class _TemplateItem implements TemplateItem {
  factory _TemplateItem(
      {required String templateName,
      required String templateFileName,
      required String templateFilePath,
      required String templateFileContent}) = _$_TemplateItem;

  factory _TemplateItem.fromJson(Map<String, dynamic> json) =
      _$_TemplateItem.fromJson;

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
  _$TemplateItemCopyWith<_TemplateItem> get copyWith =>
      throw _privateConstructorUsedError;
}
