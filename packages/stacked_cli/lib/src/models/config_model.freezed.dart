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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

/// @nodoc
mixin _$Config {
  /// Path where views and viewmodels will be genereated.
  @JsonKey(name: 'views_path')
  String get viewsPath => throw _privateConstructorUsedError;

  /// Path where services will be genereated.
  @JsonKey(name: 'services_path')
  String get servicesPath => throw _privateConstructorUsedError;

  /// File path where StackedApp is setup.
  @JsonKey(name: 'stacked_app_file_path')
  String get stackedAppFilePath => throw _privateConstructorUsedError;

  /// File path where register functions for unit test setup and mock
  /// declarations are located.
  @JsonKey(name: 'test_helpers_file_path')
  String get testHelpersFilePath => throw _privateConstructorUsedError;

  /// Paths where services unit tests will be genereated.
  @JsonKey(name: 'test_services_path')
  String get testServicesPath => throw _privateConstructorUsedError;

  /// Path where viewmodels unit tests will be genereated.
  @JsonKey(name: 'test_views_path')
  String get testViewsPath => throw _privateConstructorUsedError;

  /// The name of the locator to use when registering test mocks
  @JsonKey(name: 'locator_name')
  String get locatorName => throw _privateConstructorUsedError;

  /// The name of the function that registers the mock services for tests.
  ///
  /// This is used when creating a test file during the `create service` command
  @JsonKey(name: 'register_mocks_function')
  String get registerMocksFunction => throw _privateConstructorUsedError;

  /// Boolean value to determine view builder style
  ///
  /// This is used when creating a view file during `create view` command. By
  /// default, StackedView is used.
  @JsonKey(name: 'v1')
  bool get v1 => throw _privateConstructorUsedError;

  /// Defines the integer value to determine the line length when formatting
  /// the code.
  @JsonKey(name: 'line_length')
  int get lineLength => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
  @useResult
  $Res call(
      {@JsonKey(name: 'views_path') String viewsPath,
      @JsonKey(name: 'services_path') String servicesPath,
      @JsonKey(name: 'stacked_app_file_path') String stackedAppFilePath,
      @JsonKey(name: 'test_helpers_file_path') String testHelpersFilePath,
      @JsonKey(name: 'test_services_path') String testServicesPath,
      @JsonKey(name: 'test_views_path') String testViewsPath,
      @JsonKey(name: 'locator_name') String locatorName,
      @JsonKey(name: 'register_mocks_function') String registerMocksFunction,
      @JsonKey(name: 'v1') bool v1,
      @JsonKey(name: 'line_length') int lineLength});
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewsPath = null,
    Object? servicesPath = null,
    Object? stackedAppFilePath = null,
    Object? testHelpersFilePath = null,
    Object? testServicesPath = null,
    Object? testViewsPath = null,
    Object? locatorName = null,
    Object? registerMocksFunction = null,
    Object? v1 = null,
    Object? lineLength = null,
  }) {
    return _then(_value.copyWith(
      viewsPath: null == viewsPath
          ? _value.viewsPath
          : viewsPath // ignore: cast_nullable_to_non_nullable
              as String,
      servicesPath: null == servicesPath
          ? _value.servicesPath
          : servicesPath // ignore: cast_nullable_to_non_nullable
              as String,
      stackedAppFilePath: null == stackedAppFilePath
          ? _value.stackedAppFilePath
          : stackedAppFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      testHelpersFilePath: null == testHelpersFilePath
          ? _value.testHelpersFilePath
          : testHelpersFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      testServicesPath: null == testServicesPath
          ? _value.testServicesPath
          : testServicesPath // ignore: cast_nullable_to_non_nullable
              as String,
      testViewsPath: null == testViewsPath
          ? _value.testViewsPath
          : testViewsPath // ignore: cast_nullable_to_non_nullable
              as String,
      locatorName: null == locatorName
          ? _value.locatorName
          : locatorName // ignore: cast_nullable_to_non_nullable
              as String,
      registerMocksFunction: null == registerMocksFunction
          ? _value.registerMocksFunction
          : registerMocksFunction // ignore: cast_nullable_to_non_nullable
              as String,
      v1: null == v1
          ? _value.v1
          : v1 // ignore: cast_nullable_to_non_nullable
              as bool,
      lineLength: null == lineLength
          ? _value.lineLength
          : lineLength // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$_ConfigCopyWith(_$_Config value, $Res Function(_$_Config) then) =
      __$$_ConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'views_path') String viewsPath,
      @JsonKey(name: 'services_path') String servicesPath,
      @JsonKey(name: 'stacked_app_file_path') String stackedAppFilePath,
      @JsonKey(name: 'test_helpers_file_path') String testHelpersFilePath,
      @JsonKey(name: 'test_services_path') String testServicesPath,
      @JsonKey(name: 'test_views_path') String testViewsPath,
      @JsonKey(name: 'locator_name') String locatorName,
      @JsonKey(name: 'register_mocks_function') String registerMocksFunction,
      @JsonKey(name: 'v1') bool v1,
      @JsonKey(name: 'line_length') int lineLength});
}

/// @nodoc
class __$$_ConfigCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$_Config>
    implements _$$_ConfigCopyWith<$Res> {
  __$$_ConfigCopyWithImpl(_$_Config _value, $Res Function(_$_Config) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viewsPath = null,
    Object? servicesPath = null,
    Object? stackedAppFilePath = null,
    Object? testHelpersFilePath = null,
    Object? testServicesPath = null,
    Object? testViewsPath = null,
    Object? locatorName = null,
    Object? registerMocksFunction = null,
    Object? v1 = null,
    Object? lineLength = null,
  }) {
    return _then(_$_Config(
      viewsPath: null == viewsPath
          ? _value.viewsPath
          : viewsPath // ignore: cast_nullable_to_non_nullable
              as String,
      servicesPath: null == servicesPath
          ? _value.servicesPath
          : servicesPath // ignore: cast_nullable_to_non_nullable
              as String,
      stackedAppFilePath: null == stackedAppFilePath
          ? _value.stackedAppFilePath
          : stackedAppFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      testHelpersFilePath: null == testHelpersFilePath
          ? _value.testHelpersFilePath
          : testHelpersFilePath // ignore: cast_nullable_to_non_nullable
              as String,
      testServicesPath: null == testServicesPath
          ? _value.testServicesPath
          : testServicesPath // ignore: cast_nullable_to_non_nullable
              as String,
      testViewsPath: null == testViewsPath
          ? _value.testViewsPath
          : testViewsPath // ignore: cast_nullable_to_non_nullable
              as String,
      locatorName: null == locatorName
          ? _value.locatorName
          : locatorName // ignore: cast_nullable_to_non_nullable
              as String,
      registerMocksFunction: null == registerMocksFunction
          ? _value.registerMocksFunction
          : registerMocksFunction // ignore: cast_nullable_to_non_nullable
              as String,
      v1: null == v1
          ? _value.v1
          : v1 // ignore: cast_nullable_to_non_nullable
              as bool,
      lineLength: null == lineLength
          ? _value.lineLength
          : lineLength // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Config implements _Config {
  _$_Config(
      {@JsonKey(name: 'views_path')
          this.viewsPath = 'ui/views',
      @JsonKey(name: 'services_path')
          this.servicesPath = 'services',
      @JsonKey(name: 'stacked_app_file_path')
          this.stackedAppFilePath = 'app/app.dart',
      @JsonKey(name: 'test_helpers_file_path')
          this.testHelpersFilePath = 'helpers/test_helpers.dart',
      @JsonKey(name: 'test_services_path')
          this.testServicesPath = 'services',
      @JsonKey(name: 'test_views_path')
          this.testViewsPath = 'viewmodels',
      @JsonKey(name: 'locator_name')
          this.locatorName = 'locator',
      @JsonKey(name: 'register_mocks_function')
          this.registerMocksFunction = 'registerServices',
      @JsonKey(name: 'v1')
          this.v1 = false,
      @JsonKey(name: 'line_length')
          this.lineLength = 80});

  factory _$_Config.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigFromJson(json);

  /// Path where views and viewmodels will be genereated.
  @override
  @JsonKey(name: 'views_path')
  final String viewsPath;

  /// Path where services will be genereated.
  @override
  @JsonKey(name: 'services_path')
  final String servicesPath;

  /// File path where StackedApp is setup.
  @override
  @JsonKey(name: 'stacked_app_file_path')
  final String stackedAppFilePath;

  /// File path where register functions for unit test setup and mock
  /// declarations are located.
  @override
  @JsonKey(name: 'test_helpers_file_path')
  final String testHelpersFilePath;

  /// Paths where services unit tests will be genereated.
  @override
  @JsonKey(name: 'test_services_path')
  final String testServicesPath;

  /// Path where viewmodels unit tests will be genereated.
  @override
  @JsonKey(name: 'test_views_path')
  final String testViewsPath;

  /// The name of the locator to use when registering test mocks
  @override
  @JsonKey(name: 'locator_name')
  final String locatorName;

  /// The name of the function that registers the mock services for tests.
  ///
  /// This is used when creating a test file during the `create service` command
  @override
  @JsonKey(name: 'register_mocks_function')
  final String registerMocksFunction;

  /// Boolean value to determine view builder style
  ///
  /// This is used when creating a view file during `create view` command. By
  /// default, StackedView is used.
  @override
  @JsonKey(name: 'v1')
  final bool v1;

  /// Defines the integer value to determine the line length when formatting
  /// the code.
  @override
  @JsonKey(name: 'line_length')
  final int lineLength;

  @override
  String toString() {
    return 'Config(viewsPath: $viewsPath, servicesPath: $servicesPath, stackedAppFilePath: $stackedAppFilePath, testHelpersFilePath: $testHelpersFilePath, testServicesPath: $testServicesPath, testViewsPath: $testViewsPath, locatorName: $locatorName, registerMocksFunction: $registerMocksFunction, v1: $v1, lineLength: $lineLength)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Config &&
            (identical(other.viewsPath, viewsPath) ||
                other.viewsPath == viewsPath) &&
            (identical(other.servicesPath, servicesPath) ||
                other.servicesPath == servicesPath) &&
            (identical(other.stackedAppFilePath, stackedAppFilePath) ||
                other.stackedAppFilePath == stackedAppFilePath) &&
            (identical(other.testHelpersFilePath, testHelpersFilePath) ||
                other.testHelpersFilePath == testHelpersFilePath) &&
            (identical(other.testServicesPath, testServicesPath) ||
                other.testServicesPath == testServicesPath) &&
            (identical(other.testViewsPath, testViewsPath) ||
                other.testViewsPath == testViewsPath) &&
            (identical(other.locatorName, locatorName) ||
                other.locatorName == locatorName) &&
            (identical(other.registerMocksFunction, registerMocksFunction) ||
                other.registerMocksFunction == registerMocksFunction) &&
            (identical(other.v1, v1) || other.v1 == v1) &&
            (identical(other.lineLength, lineLength) ||
                other.lineLength == lineLength));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      viewsPath,
      servicesPath,
      stackedAppFilePath,
      testHelpersFilePath,
      testServicesPath,
      testViewsPath,
      locatorName,
      registerMocksFunction,
      v1,
      lineLength);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      __$$_ConfigCopyWithImpl<_$_Config>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigToJson(
      this,
    );
  }
}

abstract class _Config implements Config {
  factory _Config(
      {@JsonKey(name: 'views_path')
          final String viewsPath,
      @JsonKey(name: 'services_path')
          final String servicesPath,
      @JsonKey(name: 'stacked_app_file_path')
          final String stackedAppFilePath,
      @JsonKey(name: 'test_helpers_file_path')
          final String testHelpersFilePath,
      @JsonKey(name: 'test_services_path')
          final String testServicesPath,
      @JsonKey(name: 'test_views_path')
          final String testViewsPath,
      @JsonKey(name: 'locator_name')
          final String locatorName,
      @JsonKey(name: 'register_mocks_function')
          final String registerMocksFunction,
      @JsonKey(name: 'v1')
          final bool v1,
      @JsonKey(name: 'line_length')
          final int lineLength}) = _$_Config;

  factory _Config.fromJson(Map<String, dynamic> json) = _$_Config.fromJson;

  @override

  /// Path where views and viewmodels will be genereated.
  @JsonKey(name: 'views_path')
  String get viewsPath;
  @override

  /// Path where services will be genereated.
  @JsonKey(name: 'services_path')
  String get servicesPath;
  @override

  /// File path where StackedApp is setup.
  @JsonKey(name: 'stacked_app_file_path')
  String get stackedAppFilePath;
  @override

  /// File path where register functions for unit test setup and mock
  /// declarations are located.
  @JsonKey(name: 'test_helpers_file_path')
  String get testHelpersFilePath;
  @override

  /// Paths where services unit tests will be genereated.
  @JsonKey(name: 'test_services_path')
  String get testServicesPath;
  @override

  /// Path where viewmodels unit tests will be genereated.
  @JsonKey(name: 'test_views_path')
  String get testViewsPath;
  @override

  /// The name of the locator to use when registering test mocks
  @JsonKey(name: 'locator_name')
  String get locatorName;
  @override

  /// The name of the function that registers the mock services for tests.
  ///
  /// This is used when creating a test file during the `create service` command
  @JsonKey(name: 'register_mocks_function')
  String get registerMocksFunction;
  @override

  /// Boolean value to determine view builder style
  ///
  /// This is used when creating a view file during `create view` command. By
  /// default, StackedView is used.
  @JsonKey(name: 'v1')
  bool get v1;
  @override

  /// Defines the integer value to determine the line length when formatting
  /// the code.
  @JsonKey(name: 'line_length')
  int get lineLength;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      throw _privateConstructorUsedError;
}
