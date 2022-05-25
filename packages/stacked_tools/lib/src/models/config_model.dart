import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';

@freezed
class Config with _$Config {
  factory Config({
    /// Path of the file where StackedApp is setup.
    @Default('lib/app/app.dart') String stackedAppPath,

    /// Path where views and viewmodels will be genereated.
    @Default('lib/ui/views') String viewPath,

    /// Path where viewmodels unit tests will be genereated.
    @Default('test/viewmodel') String viewTestsPath,

    /// Path where services will be genereated.
    @Default('lib/services') String servicePath,

    /// Path where services unit tests will be genereated.
    @Default('test/service') String serviceTestsPath,

    /// Path for test helper file that contains the register functions for unit
    /// test setup.
    @Default('test/helpers') String testHelpersPath,

    /// Path for mock declarations.
    @Default('test/helpers') String testMocksPath,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
