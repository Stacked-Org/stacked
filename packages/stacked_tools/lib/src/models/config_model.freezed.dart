// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

/// @nodoc
class _$ConfigTearOff {
  const _$ConfigTearOff();

  _Config call(
      {String stackedAppPath = 'lib/app/app.dart',
      String viewPath = 'lib/ui/views',
      String viewTestsPath = 'test/viewmodel',
      String servicePath = 'lib/services',
      String serviceTestsPath = 'test/service',
      String testHelpersPath = 'test/helpers',
      String testMocksPath = 'test/helpers'}) {
    return _Config(
      stackedAppPath: stackedAppPath,
      viewPath: viewPath,
      viewTestsPath: viewTestsPath,
      servicePath: servicePath,
      serviceTestsPath: serviceTestsPath,
      testHelpersPath: testHelpersPath,
      testMocksPath: testMocksPath,
    );
  }

  Config fromJson(Map<String, Object?> json) {
    return Config.fromJson(json);
  }
}

/// @nodoc
const $Config = _$ConfigTearOff();

/// @nodoc
mixin _$Config {
  /// Path of the file where StackedApp is setup.
  String get stackedAppPath => throw _privateConstructorUsedError;

  /// Path where views and viewmodels will be genereated.
  String get viewPath => throw _privateConstructorUsedError;

  /// Path where viewmodels unit tests will be genereated.
  String get viewTestsPath => throw _privateConstructorUsedError;

  /// Path where services will be genereated.
  String get servicePath => throw _privateConstructorUsedError;

  /// Path where services unit tests will be genereated.
  String get serviceTestsPath => throw _privateConstructorUsedError;

  /// Path for test helper file that contains the register functions for unit
  /// test setup.
  String get testHelpersPath => throw _privateConstructorUsedError;

  /// Path for mock declarations.
  String get testMocksPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res>;
  $Res call(
      {String stackedAppPath,
      String viewPath,
      String viewTestsPath,
      String servicePath,
      String serviceTestsPath,
      String testHelpersPath,
      String testMocksPath});
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res> implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  final Config _value;
  // ignore: unused_field
  final $Res Function(Config) _then;

  @override
  $Res call({
    Object? stackedAppPath = freezed,
    Object? viewPath = freezed,
    Object? viewTestsPath = freezed,
    Object? servicePath = freezed,
    Object? serviceTestsPath = freezed,
    Object? testHelpersPath = freezed,
    Object? testMocksPath = freezed,
  }) {
    return _then(_value.copyWith(
      stackedAppPath: stackedAppPath == freezed
          ? _value.stackedAppPath
          : stackedAppPath // ignore: cast_nullable_to_non_nullable
              as String,
      viewPath: viewPath == freezed
          ? _value.viewPath
          : viewPath // ignore: cast_nullable_to_non_nullable
              as String,
      viewTestsPath: viewTestsPath == freezed
          ? _value.viewTestsPath
          : viewTestsPath // ignore: cast_nullable_to_non_nullable
              as String,
      servicePath: servicePath == freezed
          ? _value.servicePath
          : servicePath // ignore: cast_nullable_to_non_nullable
              as String,
      serviceTestsPath: serviceTestsPath == freezed
          ? _value.serviceTestsPath
          : serviceTestsPath // ignore: cast_nullable_to_non_nullable
              as String,
      testHelpersPath: testHelpersPath == freezed
          ? _value.testHelpersPath
          : testHelpersPath // ignore: cast_nullable_to_non_nullable
              as String,
      testMocksPath: testMocksPath == freezed
          ? _value.testMocksPath
          : testMocksPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$ConfigCopyWith(_Config value, $Res Function(_Config) then) =
      __$ConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {String stackedAppPath,
      String viewPath,
      String viewTestsPath,
      String servicePath,
      String serviceTestsPath,
      String testHelpersPath,
      String testMocksPath});
}

/// @nodoc
class __$ConfigCopyWithImpl<$Res> extends _$ConfigCopyWithImpl<$Res>
    implements _$ConfigCopyWith<$Res> {
  __$ConfigCopyWithImpl(_Config _value, $Res Function(_Config) _then)
      : super(_value, (v) => _then(v as _Config));

  @override
  _Config get _value => super._value as _Config;

  @override
  $Res call({
    Object? stackedAppPath = freezed,
    Object? viewPath = freezed,
    Object? viewTestsPath = freezed,
    Object? servicePath = freezed,
    Object? serviceTestsPath = freezed,
    Object? testHelpersPath = freezed,
    Object? testMocksPath = freezed,
  }) {
    return _then(_Config(
      stackedAppPath: stackedAppPath == freezed
          ? _value.stackedAppPath
          : stackedAppPath // ignore: cast_nullable_to_non_nullable
              as String,
      viewPath: viewPath == freezed
          ? _value.viewPath
          : viewPath // ignore: cast_nullable_to_non_nullable
              as String,
      viewTestsPath: viewTestsPath == freezed
          ? _value.viewTestsPath
          : viewTestsPath // ignore: cast_nullable_to_non_nullable
              as String,
      servicePath: servicePath == freezed
          ? _value.servicePath
          : servicePath // ignore: cast_nullable_to_non_nullable
              as String,
      serviceTestsPath: serviceTestsPath == freezed
          ? _value.serviceTestsPath
          : serviceTestsPath // ignore: cast_nullable_to_non_nullable
              as String,
      testHelpersPath: testHelpersPath == freezed
          ? _value.testHelpersPath
          : testHelpersPath // ignore: cast_nullable_to_non_nullable
              as String,
      testMocksPath: testMocksPath == freezed
          ? _value.testMocksPath
          : testMocksPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Config implements _Config {
  _$_Config(
      {this.stackedAppPath = 'lib/app/app.dart',
      this.viewPath = 'lib/ui/views',
      this.viewTestsPath = 'test/viewmodel',
      this.servicePath = 'lib/services',
      this.serviceTestsPath = 'test/service',
      this.testHelpersPath = 'test/helpers',
      this.testMocksPath = 'test/helpers'});

  factory _$_Config.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigFromJson(json);

  @JsonKey()
  @override

  /// Path of the file where StackedApp is setup.
  final String stackedAppPath;
  @JsonKey()
  @override

  /// Path where views and viewmodels will be genereated.
  final String viewPath;
  @JsonKey()
  @override

  /// Path where viewmodels unit tests will be genereated.
  final String viewTestsPath;
  @JsonKey()
  @override

  /// Path where services will be genereated.
  final String servicePath;
  @JsonKey()
  @override

  /// Path where services unit tests will be genereated.
  final String serviceTestsPath;
  @JsonKey()
  @override

  /// Path for test helper file that contains the register functions for unit
  /// test setup.
  final String testHelpersPath;
  @JsonKey()
  @override

  /// Path for mock declarations.
  final String testMocksPath;

  @override
  String toString() {
    return 'Config(stackedAppPath: $stackedAppPath, viewPath: $viewPath, viewTestsPath: $viewTestsPath, servicePath: $servicePath, serviceTestsPath: $serviceTestsPath, testHelpersPath: $testHelpersPath, testMocksPath: $testMocksPath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Config &&
            const DeepCollectionEquality()
                .equals(other.stackedAppPath, stackedAppPath) &&
            const DeepCollectionEquality().equals(other.viewPath, viewPath) &&
            const DeepCollectionEquality()
                .equals(other.viewTestsPath, viewTestsPath) &&
            const DeepCollectionEquality()
                .equals(other.servicePath, servicePath) &&
            const DeepCollectionEquality()
                .equals(other.serviceTestsPath, serviceTestsPath) &&
            const DeepCollectionEquality()
                .equals(other.testHelpersPath, testHelpersPath) &&
            const DeepCollectionEquality()
                .equals(other.testMocksPath, testMocksPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(stackedAppPath),
      const DeepCollectionEquality().hash(viewPath),
      const DeepCollectionEquality().hash(viewTestsPath),
      const DeepCollectionEquality().hash(servicePath),
      const DeepCollectionEquality().hash(serviceTestsPath),
      const DeepCollectionEquality().hash(testHelpersPath),
      const DeepCollectionEquality().hash(testMocksPath));

  @JsonKey(ignore: true)
  @override
  _$ConfigCopyWith<_Config> get copyWith =>
      __$ConfigCopyWithImpl<_Config>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigToJson(this);
  }
}

abstract class _Config implements Config {
  factory _Config(
      {String stackedAppPath,
      String viewPath,
      String viewTestsPath,
      String servicePath,
      String serviceTestsPath,
      String testHelpersPath,
      String testMocksPath}) = _$_Config;

  factory _Config.fromJson(Map<String, dynamic> json) = _$_Config.fromJson;

  @override

  /// Path of the file where StackedApp is setup.
  String get stackedAppPath;
  @override

  /// Path where views and viewmodels will be genereated.
  String get viewPath;
  @override

  /// Path where viewmodels unit tests will be genereated.
  String get viewTestsPath;
  @override

  /// Path where services will be genereated.
  String get servicePath;
  @override

  /// Path where services unit tests will be genereated.
  String get serviceTestsPath;
  @override

  /// Path for test helper file that contains the register functions for unit
  /// test setup.
  String get testHelpersPath;
  @override

  /// Path for mock declarations.
  String get testMocksPath;
  @override
  @JsonKey(ignore: true)
  _$ConfigCopyWith<_Config> get copyWith => throw _privateConstructorUsedError;
}
