// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';

@freezed
class Config with _$Config {
  factory Config({
    /// Path where views and viewmodels will be genereated.
    @JsonKey(name: 'views_path') @Default('ui/views') String viewsPath,

    /// Path where services will be genereated.
    @JsonKey(name: 'services_path') @Default('services') String servicesPath,

    /// Path where bottom sheets will be genereated.
    @JsonKey(name: 'bottom_sheets_path')
    @Default('ui/bottom_sheets')
        String bottomSheetsPath,

    /// File path where StackedApp is setup.
    @JsonKey(name: 'stacked_app_file_path')
    @Default('app/app.dart')
        String stackedAppFilePath,

    /// File path where register functions for unit test setup and mock
    /// declarations are located.
    @JsonKey(name: 'test_helpers_file_path')
    @Default('helpers/test_helpers.dart')
        String testHelpersFilePath,

    /// Paths where services unit tests will be genereated.
    @JsonKey(name: 'test_services_path')
    @Default('services')
        String testServicesPath,

    /// Path where viewmodels unit tests will be genereated.
    @JsonKey(name: 'test_views_path')
    @Default('viewmodels')
        String testViewsPath,

    /// The name of the locator to use when registering test mocks
    @JsonKey(name: 'locator_name') @Default('locator') String locatorName,

    /// The name of the function that registers the mock services for tests.
    ///
    /// This is used when creating a test file during the `create service` command
    @JsonKey(name: 'register_mocks_function')
    @Default('registerServices')
        String registerMocksFunction,

    /// Boolean value to determine view builder style
    ///
    /// This is used when creating a view file during `create view` command. By
    /// default, StackedView is used.
    @JsonKey(name: 'v1') @Default(false) bool v1,

    /// Defines the integer value to determine the line length when formatting
    /// the code.
    @JsonKey(name: 'line_length') @Default(80) int lineLength,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
