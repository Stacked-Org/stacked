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
  /// Relative path where views and viewmodels will be genereated.
  @JsonKey(name: 'views_path')
  String get viewsPath => throw _privateConstructorUsedError;

  /// Relative path where services will be genereated.
  @JsonKey(name: 'services_path')
  String get servicesPath => throw _privateConstructorUsedError;

  /// Relative path of the file where StackedApp is setup.
  @JsonKey(name: 'stacked_app_path')
  String get stackedAppPath => throw _privateConstructorUsedError;

  /// Relative path for test helper file that contains the register functions
  /// for unit test setup and mock declarations.
  @JsonKey(name: 'test_helpers_path')
  String get testHelpersPath => throw _privateConstructorUsedError;

  /// Relative Paths where services unit tests will be genereated.
  @JsonKey(name: 'test_services_path')
  String get testServicesPath => throw _privateConstructorUsedError;

  /// Relative path where viewmodels unit tests will be genereated.
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
      @JsonKey(name: 'stacked_app_path') String stackedAppPath,
      @JsonKey(name: 'test_helpers_path') String testHelpersPath,
      @JsonKey(name: 'test_services_path') String testServicesPath,
      @JsonKey(name: 'test_views_path') String testViewsPath,
      @JsonKey(name: 'locator_name') String locatorName,
      @JsonKey(name: 'register_mocks_function') String registerMocksFunction,
      @JsonKey(name: 'v1') bool v1});
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
    Object? stackedAppPath = null,
    Object? testHelpersPath = null,
    Object? testServicesPath = null,
    Object? testViewsPath = null,
    Object? locatorName = null,
    Object? registerMocksFunction = null,
    Object? v1 = null,
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
      stackedAppPath: null == stackedAppPath
          ? _value.stackedAppPath
          : stackedAppPath // ignore: cast_nullable_to_non_nullable
              as String,
      testHelpersPath: null == testHelpersPath
          ? _value.testHelpersPath
          : testHelpersPath // ignore: cast_nullable_to_non_nullable
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
      @JsonKey(name: 'stacked_app_path') String stackedAppPath,
      @JsonKey(name: 'test_helpers_path') String testHelpersPath,
      @JsonKey(name: 'test_services_path') String testServicesPath,
      @JsonKey(name: 'test_views_path') String testViewsPath,
      @JsonKey(name: 'locator_name') String locatorName,
      @JsonKey(name: 'register_mocks_function') String registerMocksFunction,
      @JsonKey(name: 'v1') bool v1});
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
    Object? stackedAppPath = null,
    Object? testHelpersPath = null,
    Object? testServicesPath = null,
    Object? testViewsPath = null,
    Object? locatorName = null,
    Object? registerMocksFunction = null,
    Object? v1 = null,
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
      stackedAppPath: null == stackedAppPath
          ? _value.stackedAppPath
          : stackedAppPath // ignore: cast_nullable_to_non_nullable
              as String,
      testHelpersPath: null == testHelpersPath
          ? _value.testHelpersPath
          : testHelpersPath // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Config implements _Config {
  _$_Config(
      {@JsonKey(name: 'views_path')
          this.viewsPath = 'lib/ui/views',
      @JsonKey(name: 'services_path')
          this.servicesPath = 'lib/services',
      @JsonKey(name: 'stacked_app_path')
          this.stackedAppPath = 'lib/app/app.dart',
      @JsonKey(name: 'test_helpers_path')
          this.testHelpersPath = 'test/helpers',
      @JsonKey(name: 'test_services_path')
          this.testServicesPath = 'test/services',
      @JsonKey(name: 'test_views_path')
          this.testViewsPath = 'test/viewmodels',
      @JsonKey(name: 'locator_name')
          this.locatorName = 'locator',
      @JsonKey(name: 'register_mocks_function')
          this.registerMocksFunction = 'registerServices',
      @JsonKey(name: 'v1')
          this.v1 = false});

  factory _$_Config.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigFromJson(json);

  /// Relative path where views and viewmodels will be genereated.
  @override
  @JsonKey(name: 'views_path')
  final String viewsPath;

  /// Relative path where services will be genereated.
  @override
  @JsonKey(name: 'services_path')
  final String servicesPath;

  /// Relative path of the file where StackedApp is setup.
  @override
  @JsonKey(name: 'stacked_app_path')
  final String stackedAppPath;

  /// Relative path for test helper file that contains the register functions
  /// for unit test setup and mock declarations.
  @override
  @JsonKey(name: 'test_helpers_path')
  final String testHelpersPath;

  /// Relative Paths where services unit tests will be genereated.
  @override
  @JsonKey(name: 'test_services_path')
  final String testServicesPath;

  /// Relative path where viewmodels unit tests will be genereated.
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

  @override
  String toString() {
    return 'Config(viewsPath: $viewsPath, servicesPath: $servicesPath, stackedAppPath: $stackedAppPath, testHelpersPath: $testHelpersPath, testServicesPath: $testServicesPath, testViewsPath: $testViewsPath, locatorName: $locatorName, registerMocksFunction: $registerMocksFunction, v1: $v1)';
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
            (identical(other.stackedAppPath, stackedAppPath) ||
                other.stackedAppPath == stackedAppPath) &&
            (identical(other.testHelpersPath, testHelpersPath) ||
                other.testHelpersPath == testHelpersPath) &&
            (identical(other.testServicesPath, testServicesPath) ||
                other.testServicesPath == testServicesPath) &&
            (identical(other.testViewsPath, testViewsPath) ||
                other.testViewsPath == testViewsPath) &&
            (identical(other.locatorName, locatorName) ||
                other.locatorName == locatorName) &&
            (identical(other.registerMocksFunction, registerMocksFunction) ||
                other.registerMocksFunction == registerMocksFunction) &&
            (identical(other.v1, v1) || other.v1 == v1));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      viewsPath,
      servicesPath,
      stackedAppPath,
      testHelpersPath,
      testServicesPath,
      testViewsPath,
      locatorName,
      registerMocksFunction,
      v1);

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
      @JsonKey(name: 'stacked_app_path')
          final String stackedAppPath,
      @JsonKey(name: 'test_helpers_path')
          final String testHelpersPath,
      @JsonKey(name: 'test_services_path')
          final String testServicesPath,
      @JsonKey(name: 'test_views_path')
          final String testViewsPath,
      @JsonKey(name: 'locator_name')
          final String locatorName,
      @JsonKey(name: 'register_mocks_function')
          final String registerMocksFunction,
      @JsonKey(name: 'v1')
          final bool v1}) = _$_Config;

  factory _Config.fromJson(Map<String, dynamic> json) = _$_Config.fromJson;

  @override

  /// Relative path where views and viewmodels will be genereated.
  @JsonKey(name: 'views_path')
  String get viewsPath;
  @override

  /// Relative path where services will be genereated.
  @JsonKey(name: 'services_path')
  String get servicesPath;
  @override

  /// Relative path of the file where StackedApp is setup.
  @JsonKey(name: 'stacked_app_path')
  String get stackedAppPath;
  @override

  /// Relative path for test helper file that contains the register functions
  /// for unit test setup and mock declarations.
  @JsonKey(name: 'test_helpers_path')
  String get testHelpersPath;
  @override

  /// Relative Paths where services unit tests will be genereated.
  @JsonKey(name: 'test_services_path')
  String get testServicesPath;
  @override

  /// Relative path where viewmodels unit tests will be genereated.
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
  @JsonKey(ignore: true)
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      throw _privateConstructorUsedError;
}
