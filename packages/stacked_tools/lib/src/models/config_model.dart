// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';

@freezed
class Config with _$Config {
  factory Config({
    /// Relative path where views and viewmodels will be genereated.
    @JsonKey(name: 'views_path') @Default('lib/ui/views') String viewsPath,

    /// Relative path where services will be genereated.
    @JsonKey(name: 'services_path')
    @Default('lib/services')
        String servicesPath,

    /// Relative path of the file where StackedApp is setup.
    @JsonKey(name: 'stacked_app_path')
    @Default('lib/app/app.dart')
        String stackedAppPath,

    /// Relative path for test helper file that contains the register functions
    /// for unit test setup and mock declarations.
    @JsonKey(name: 'test_helpers_path')
    @Default('test/helpers')
        String testHelpersPath,

    /// Relative Paths where services unit tests will be genereated.
    @JsonKey(name: 'test_services_path')
    @Default('test/services')
        String testServicesPath,

    /// Relative path where viewmodels unit tests will be genereated.
    @JsonKey(name: 'test_views_path')
    @Default('test/viewmodels')
        String testViewsPath,

    /// The name of the locator to use when registering test mocks
    @JsonKey(name: 'locator_name') @Default('locator') String locatorName,

    /// The name of the function that registers the mock services for tests.
    ///
    /// This is used when creating a test file during the `create service` command
    @JsonKey(name: 'register_mocks_function')
    @Default('registerServices')
        String registerMocksFunction,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
