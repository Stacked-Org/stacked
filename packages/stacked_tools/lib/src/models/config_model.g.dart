// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Config _$$_ConfigFromJson(Map<String, dynamic> json) => _$_Config(
      viewsPath: json['views_path'] as String? ?? 'lib/ui/views',
      servicesPath: json['services_path'] as String? ?? 'lib/services',
      stackedAppFilePath:
          json['stacked_app_file_path'] as String? ?? 'lib/app/app.dart',
      testHelpersFilePath: json['test_helpers_file_path'] as String? ??
          'test/helpers/test_helpers.dart',
      testServicesPath:
          json['test_services_path'] as String? ?? 'test/services',
      testViewsPath: json['test_views_path'] as String? ?? 'test/viewmodels',
      locatorName: json['locator_name'] as String? ?? 'locator',
      registerMocksFunction:
          json['register_mocks_function'] as String? ?? 'registerServices',
      v1: json['v1'] as bool? ?? false,
      lineLength: json['line_length'] as int? ?? 80,
    );

Map<String, dynamic> _$$_ConfigToJson(_$_Config instance) => <String, dynamic>{
      'views_path': instance.viewsPath,
      'services_path': instance.servicesPath,
      'stacked_app_file_path': instance.stackedAppFilePath,
      'test_helpers_file_path': instance.testHelpersFilePath,
      'test_services_path': instance.testServicesPath,
      'test_views_path': instance.testViewsPath,
      'locator_name': instance.locatorName,
      'register_mocks_function': instance.registerMocksFunction,
      'v1': instance.v1,
      'line_length': instance.lineLength,
    };
